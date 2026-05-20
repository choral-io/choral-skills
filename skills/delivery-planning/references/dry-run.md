# Delivery Planning Dry Run

Use this table before changing `<knowledge_dir>/planning/KANBAN.md`:

| Title                 | Sources                                          | Module | Priority | Sprint   | Owners   | Blockers | Target Column |
| --------------------- | ------------------------------------------------ | ------ | -------- | -------- | -------- | -------- | ------------- |
| Example delivery task | `<knowledge_dir>/tasks/example-delivery-task.md` | app    | P1       | Sprint 1 | Gavroche | None     | Ready         |

For newly decomposed dependent work, use `Backlog` as the target column unless the task is ready for immediate selection. Do not target `Blocked` only because `blocked_by` is present.

Task item metadata may include:

```yaml
type: task
priority: P1
severity:
value: H
module: app
owners:
    - "[[members/Gavroche]]"
assignees:
    - "[[members/Gavroche]]"
reviewers:
    - "[[members/Éponine]]"
effort: M
readiness: ready
sprint: Sprint 1
blocked_by: []
related_to:
    - "[[tasks/example-related-task]]"
reported_by:
affected_area:
```

Suggested values:

- `type`: `task`, `issue`, `bug`, `defect`
- `priority`: `P0`, `P1`, `P2`, `P3`
- `severity`: `S0`, `S1`, `S2`, `S3` for issue, bug, or defect impact
- `value`: `H`, `M`, `L`
- `module`: `app`, `api`, `docs`, `infra`, `knowledge`
- `effort`: `S`, `M`, `L`
- `readiness`: `ready`, `needs-refinement`, `blocked`
- `owners`: member or group wikilinks, preferring path-qualified values such as `[[members/Gavroche]]` or `[[groups/review-board]]`; do not use display names. `Ready` proposals require non-empty owners that resolve to existing member or group documents.
- `assignees`: member or group wikilinks for people or pools currently responsible for moving the task forward
- `reviewers`: member or group wikilinks for expected reviewers for delivery acceptance
