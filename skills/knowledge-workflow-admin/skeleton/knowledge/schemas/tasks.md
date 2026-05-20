---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - tasks
---

# Tasks Schema

Task documents describe durable delivery context. The Kanban board tracks status; task items hold scope and acceptance criteria.

## Frontmatter

```yaml
---
scope: project
type: task
owners:
    - "[[members/Gavroche]]"
assignees:
    - "[[members/Gavroche]]"
reviewers:
    - "[[members/Éponine]]"
tags:
    - app
priority: P1
value: H
module: app
effort: M
readiness: ready
sprint: Sprint 1
blocked_by: []
related_to:
    - "[[tasks/example-related-task]]"
---
```

## Delivery Fields

- `type`: `task`, `issue`, `bug`, or `defect`.
- `priority`: `P0`, `P1`, `P2`, `P3`.
- `severity`: `S0`, `S1`, `S2`, `S3`; use for issue, bug, or defect impact. Keep it separate from delivery `priority`.
- `value`: `H`, `M`, `L`.
- `module`: `app`, `api`, `docs`, `infra`, `knowledge`.
- `effort`: `S`, `M`, `L`.
- `readiness`: `ready`, `needs-refinement`, `blocked`.
- `sprint`: sprint label when scheduled.
- `owners`: member or group wikilinks for durable task ownership. `owners: []` is allowed while a task is being drafted or refined, but `readiness: ready`, Kanban promotion, and active delivery require non-empty owners that resolve to existing member or group documents.
- `assignees`: member wikilinks for people currently responsible for moving the task forward. Group assignees mean a team or group pool, not assignment to the current member.
- `reviewers`: member or group wikilinks for expected reviewers for delivery acceptance.
- `blocked_by`: hard blocker relationships. Entries may remain after blockers are resolved; a task is blocked only when one or more entries are unresolved.
- `related_to`: context links that do not block work.
- `reported_by`: optional source, member id, role, channel, or anonymized reporter for issue, bug, or defect tasks.
- `affected_area`: optional product, module, user journey, integration, customer segment, or environment affected by an issue, bug, or defect.

Use task knowledge-reference wikilinks in relationship fields. Manual short task wikilinks such as `[[example-related-task]]` are valid only when they resolve uniquely. Tool-written task relationship values should prefer path-qualified wikilinks such as `[[tasks/example-related-task]]`.

## Body Template

- Goal
- Problem
- Sources
- Reproduction
- Expected
- Actual
- Impact
- Triage
- Context and source knowledge
- In scope
- Out of scope
- Acceptance criteria
- Relationship notes
- Open questions

## Rules

- Raw feedback, support notes, QA observations, and market signals should not become task items by default. Store raw or synthesized context in `{{knowledge_dir}}/workspace/<member-id>/research/` or `{{knowledge_dir}}/discovery/` first.
- Use `type: issue`, `type: bug`, or `type: defect` only when the problem is actionable enough to triage as delivery work.
- Issue, bug, and defect tasks must include `Problem`, `Sources`, `Impact`, and `Triage` before they can be classified as Backlog, Ready, Blocked, or Cancelled delivery work.
- Bug and defect tasks should include `Reproduction`, `Expected`, and `Actual` sections when the problem is reproducible. If not reproducible yet, explain that in `Triage` and keep `readiness: needs-refinement`.
- Use `severity` for user or system impact. Use `priority` for delivery ordering.
- Use `readiness: needs-refinement` for new or incomplete task items that need clearer scope, acceptance criteria, metadata, design, or dependency analysis.
- Use `readiness: ready` only when the task satisfies every item in the Ready Checklist below.
- Stable source material means the task item and all required referenced task, product, design, architecture, decision, planning, and asset files are committed. If the repository has a default remote, those commits must also be pushed to that remote. External stable sources are allowed only when the task records the URL, access condition, and relevant version or date.
- Use `readiness: blocked` when work cannot start because a `blocked_by` task, decision, external condition, or required access is unresolved.
- `readiness` is execution readiness, not delivery completion state or Kanban column state. Do not use it to mirror `Done` or `Cancelled`; delivery status belongs in the Kanban board.
- `blocked_by` records dependency facts. It does not automatically mean the Kanban card belongs in `Blocked`; planned dependent tasks may stay in `Backlog` with `readiness: blocked`.
- A task in the `Ready` Kanban column must have `readiness: ready` and no unresolved `blocked_by` entries.
- Use the `Blocked` Kanban column only for work that was expected to proceed or already started but cannot continue because an active blocker is unresolved.
- A `blocked_by` task reference is resolved when the referenced task is in `Done`, or when the task item records that the blocker was resolved by another approved path. Missing, ambiguous, or unresolved references remain blockers.
- When a task reaches `Done`, keep historical `blocked_by` entries unless they are inaccurate, obsolete, or too weak and should become `related_to`; reassess downstream tasks that reference the completed task.
- Agents may propose `readiness` changes in dry-run output. Writing `readiness: ready` should happen only after maintainer approval or as part of an approved metadata dry-run.
- Agents may conservatively set or propose `needs-refinement` or `blocked` when evidence is clear, but should explain the reason.
- Use `blocked_by` and `related_to` instead of a generic `dependencies` field when possible.
- Do not duplicate delivery status in every task item.
- Do not use `assignees` as a replacement for moving a card between Kanban columns.
- Keep localized files out of planning inputs unless explicitly requested.

## Ready Checklist

All items are required before setting `readiness: ready`:

- Frontmatter includes valid `type`, `priority`, `value`, `module`, `effort`, and `readiness`.
- `owners` is non-empty, and every owner resolves to an existing member or group document.
- The task has `## Goal`, `## Sources`, `## In scope`, `## Out of scope`, and `## Acceptance criteria` sections.
- `## Sources` links to committed canonical-language project knowledge, accepted decisions, architecture, product, design, planning, task, or explicitly selected shared workspace material.
- `## Acceptance criteria` contains observable pass/fail criteria.
- `blocked_by` is empty, or every referenced blocker is resolved by `Done` status or by an approved resolution note in the task body.
- The task does not require local-only notes, localized-only files, secrets, private personal information, or unapproved customer-sensitive context.
- The task item and required local source material are committed; if the repository has a default remote, those commits are pushed to that remote.
- Issue, bug, or defect tasks also include `## Problem`, `## Impact`, and `## Triage`; reproducible bugs or defects include `## Reproduction`, `## Expected`, and `## Actual`.

## Sources

Use a `## Sources` section for canonical source knowledge:

```md
## Sources

- [[product/example-source-note]]
- [[planning/WORKFLOW]]
```

Sources should point to canonical-language project knowledge, accepted decisions, architecture, product, design, or explicitly selected workspace summaries, handoffs, or research. Do not use local workspace notes or localized files as the only source.

## Kanban Link Resolution

Kanban cards use Foam wikilinks:

```md
- [ ] [[tasks/example-delivery-task|Example delivery task]]
```

Resolve `[[tasks/example-delivery-task]]` to `{{knowledge_dir}}/tasks/example-delivery-task.md`. Manual short task links such as `[[example-delivery-task]]` may resolve to `{{knowledge_dir}}/tasks/example-delivery-task.md` when unambiguous. If multiple canonical files match the same id, report ambiguity instead of guessing. Do not use display titles as ids.
