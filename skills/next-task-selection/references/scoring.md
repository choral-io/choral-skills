# Next Task Selection Scoring

## Candidate Sources

Default candidate source is accepted cards in `<knowledge_dir>/planning/KANBAN.md`.
Use linked task items only as context for those cards.

Default Kanban scan order:

1. `Ready`
2. `Backlog`

Do not select cards from `Doing`, `Reviewing`, `Done`, or `Cancelled` unless the user asks for recovery or review work.

Do not select cards from `Blocked` for implementation. Use blocked cards only when the user asks for blocker-resolution or recovery work.

Cards in `Backlog` may have `readiness: blocked` for planned dependency order. Keep them visible as context, but exclude them from implementation recommendations until blockers are resolved.

Do not select loose task items from `<knowledge_dir>/tasks/*.md` unless they are linked from a candidate Kanban card. If the user asks to rank task items that are not on the board, route to `delivery-planning`.

## Metadata

Task items may include:

```yaml
priority: P1
value: H
effort: M
readiness: ready
module: app
owners:
    - "[[members/Gavroche]]"
assignees:
    - "[[members/Gavroche]]"
reviewers:
    - "[[members/Éponine]]"
blocked_by:
    - "[[tasks/example-upstream-task]]"
related_to:
    - "[[tasks/example-related-task]]"
```

Use task knowledge-reference wikilinks in relationship fields, not display titles. Tool-written values should prefer path-qualified task wikilinks.

## Field Meanings

- `priority`: team priority. Suggested values: `P0`, `P1`, `P2`, `P3`.
- `value`: expected product or engineering value. Suggested values: `H`, `M`, `L`.
- `effort`: expected implementation size. Suggested values: `S`, `M`, `L`.
- `readiness`: execution readiness. Suggested values: `ready`, `needs-refinement`, `blocked`.
- `assignees`: member wikilinks for people currently responsible for moving the task forward.
- `reviewers`: member wikilinks for expected reviewers for delivery acceptance.
- `blocked_by`: hard blockers that prevent work from starting.
- `related_to`: useful context or adjacent work, not a blocker.
- Downstream unlocks are derived by reverse-looking up other tasks whose `blocked_by` references the candidate.

## Assignment Priority

Apply assignment priority before normal ranking:

1. Tasks where `assignees` includes the current member id.
2. Tasks with missing or empty `assignees`.
3. Tasks assigned only to other members.

Only recommend from the first non-empty eligible group. If only tasks assigned to other members remain, list them as candidates and state that reassignment or explicit approval is needed before starting.

Normalize member and group wikilinks before matching assignment. For example, `[[members/Gavroche]]` and `[[Gavroche|Display Name]]` both match id `Gavroche`. Group assignees mean team-pool assignment and do not match the current member.

Within each assignment group, score candidates with the table below.

## Auto-Start

If the user explicitly allows automatic start, the Agent may proceed only for:

- `assigned-to-current-member`
- `unassigned`

For `assigned-to-others`, the Agent must ask for a second explicit confirmation before starting. This protects another member's active work even when general automatic start is enabled.

## Candidate Score Table

Use this table for each eligible candidate in the first non-empty assignment group. Use `pass`, `warn`, or `fail` for status-like fields. Exclude candidates with any `fail` in `readiness`, `blockers`, `source_stability`, `sensitive_context`, or `dirty_conflict`.

| Field                | Allowed values or scoring rule                                                       |
| -------------------- | ------------------------------------------------------------------------------------ |
| `assignment_class`   | `assigned-to-current-member`, `unassigned`, `assigned-to-others`                     |
| `kanban_column`      | `Ready` ranks before `Backlog`; other columns require explicit user scope            |
| `readiness`          | `pass` only for `readiness: ready`                                                   |
| `blockers`           | `pass` when `blocked_by` is empty or resolved; otherwise `fail`                      |
| `source_stability`   | `pass`, `warn`, or `fail` from source stability checks                               |
| `acceptance`         | `pass` only when observable acceptance criteria exist                                |
| `sensitive_context`  | `fail` when secrets, private personal data, or unapproved customer data are required |
| `dirty_conflict`     | `fail` when current dirty files overlap likely task files                            |
| `priority_score`     | `P0=4`, `P1=3`, `P2=2`, `P3=1`, missing=`0`                                          |
| `value_score`        | `H=3`, `M=2`, `L=1`, missing=`0`                                                     |
| `effort_fit`         | `S=3`, `M=2`, `L=1`, missing=`0`                                                     |
| `downstream_unlocks` | count tasks whose unresolved `blocked_by` references this candidate                  |
| `fit_notes`          | module, owner, member profile, or user goal fit                                      |

Sort by assignment partition first, then by fail-free eligibility, `kanban_column`, `priority_score`, `value_score`, `downstream_unlocks`, `effort_fit`, and `fit_notes`.

Use this output shape:

```md
## Candidate Scores

| Task | Assignment | Column | Ready | Blockers | Source | Dirty | P   | V   | Effort | Unlocks | Result |
| ---- | ---------- | ------ | ----- | -------- | ------ | ----- | --- | --- | ------ | ------- | ------ |
```

## Ranking Heuristics

Rank candidates higher when they:

- Have higher `priority`.
- Have higher `value`.
- Are in `Ready`.
- Have `readiness: ready`.
- Have no unresolved `blocked_by` entries.
- Release high-priority or multiple downstream tasks, derived from other tasks' `blocked_by` entries.
- Reduce product, technical, or delivery risk early.
- Fit the requested module.
- Have lower effort when value and priority are similar.

Rank candidates lower or exclude them when they:

- Have unresolved `blocked_by` entries.
- Have missing acceptance criteria.
- Have `readiness: needs-refinement` or `readiness: blocked`.
- Are in the `Blocked` column, unless the user asked for blocker-resolution work.
- Depend on localized files or local workspace notes as their only source.
- Have unclear scope or sensitive information.

## Output Example

```text
Recommended next task: Example delivery task

Reason:
- P1 with high product value.
- No unresolved `blocked_by` entries.
- Releases downstream delivery work through referenced `blocked_by` relationships.
- Fits one focused implementation pass with no known dependency conflict.

Alternatives:
1. Example documentation task
2. Example integration task

Blocked:
- Example downstream task: blocked by example-upstream-task
```
