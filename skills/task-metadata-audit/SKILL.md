---
name: task-metadata-audit
description: Use when task items or Kanban links need a read-only check for readiness, dependencies, issues, acceptance, or board consistency.
---

# Task Metadata Audit

## Runtime Context

Before acting, use the repository Knowledge Workflow runtime context from root `AGENTS.md` and its manifest; do not assume workflow paths or default ids.

Use this skill to inspect task metadata and report issues. This skill is read-only.

## Workflow

1. Read `<knowledge_dir>/schemas/common.md`.
2. Read `<knowledge_dir>/schemas/tasks.md`.
3. Read `<knowledge_dir>/planning/WORKFLOW.md`.
4. Read `<knowledge_dir>/planning/KANBAN.md`.
5. Scan `<knowledge_dir>/tasks/*.md`, excluding localized files.
6. Parse frontmatter and task body sections.
7. Check task relationships against existing task ids and Kanban card ids.
8. Report issues and dry-run fixes without editing files.

## Checks

- Missing or invalid `type`, `priority`, `value`, `effort`, `readiness`, or `module`.
- Missing or invalid `severity` only when `type` is `issue`, `bug`, or `defect` and impact is needed for triage.
- Missing, empty, or unresolved `owners` in task items that are `readiness: ready`, linked from a Kanban card, scheduled, assigned, or actively maintained.
- `owners`, `assignees`, or `reviewers` values that reference member or group documents without wikilinks, or tool-written values that should be path-qualified.
- Group values in `assignees`; report these as team-pool assignments, not direct assignment to the current member.
- Missing `assignees` only when the task appears scheduled or actively assigned.
- Missing `reviewers` only when review responsibility is expected.
- `blocked_by` or `related_to` entries that point to missing or ambiguous task references.
- Missing `## Sources` section or sources that point only to local workspace notes or localized files.
- Tasks with `readiness: ready` but missing acceptance criteria.
- Issue, bug, or defect tasks with `readiness: ready` but missing `Problem`, `Impact`, or `Triage` context.
- Reproducible bug or defect tasks with `readiness: ready` but missing `Reproduction`, `Expected`, or `Actual`.
- Tasks with `readiness: ready` whose task item or required source materials are uncommitted.
- Tasks with `readiness: ready` whose task item or required source materials are not pushed to the default remote when one exists.
- Tasks in `Ready` with unresolved `blocked_by` entries.
- Tasks in `Ready` with `readiness` other than `ready`.
- Tasks in `Blocked` without `readiness: blocked`, unresolved `blocked_by`, or an explicit blocker note.
- Tasks in `Backlog` with `readiness: blocked`; report as allowed planned dependency state, not an error.
- Tasks outside `Backlog` or `Blocked` with unresolved `blocked_by` entries.
- Downstream tasks whose `blocked_by` references are all resolved but still have `readiness: blocked` or remain in `Blocked`.
- Tasks in `Backlog` that appear ready but have not been promoted to `Ready`.
- Localized task files used as planning inputs.

## Output

Use the standard task audit output shape from `references/report.md`: `Summary`, `Findings`, `Dry-run fixes`, `Requires judgment`, `Safe for next-task-selection`, and `Sources`.

## Guardrails

- Do not edit task items.
- Do not move Kanban cards.
- Do not infer sensitive information.
- Do not treat `assignees` as Kanban status.
- Treat source stability as a readiness audit and Ready-column maintenance check. Do not require `next-task-selection` to run the full audit for every candidate unless the user asks for strict verification or automatic start.
- Require maintainer approval before any suggested fix is applied by another skill.

## References

- For audit output examples, read `references/report.md`.
