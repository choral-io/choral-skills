# Report Templates

Use the nearest template when the requested mode matches. Keep reports read-only.

## Weekly Delivery Report

```md
## Status Summary

- Scope: delivery-only
- Period: ...
- Reliability: high | medium | low

## Counts

| Area                       | Count | Basis                     | Notes |
| -------------------------- | ----- | ------------------------- | ----- |
| `kanban.cards_by_column`   |       | board-based               |       |
| `tasks.by_readiness`       |       | field-based               |       |
| `reviews.pending`          |       | board-based + field-based |       |
| `tasks.blocked_unresolved` |       | field-based               |       |

## Movement

- Started:
- Reached review:
- Done:
- Cancelled:

## Risks And Gaps

- ...

## Recommended Next Actions

- ...

## Sources
```

## Knowledge Health Report

```md
## Status Summary

- Scope: project-wide
- Reliability: high | medium | low

## Counts

| Area                         | Count | Basis                    | Notes |
| ---------------------------- | ----- | ------------------------ | ----- |
| `knowledge.by_area`          |       | path-based + field-based |       |
| localized files              |       | path-based               |       |
| missing owners               |       | field-based              |       |
| stale or ambiguous wikilinks |       | link-based               |       |

## Risks And Gaps

- ...

## Recommended Next Actions

- route fixes to `knowledge-schema-audit` or `task-metadata-audit`

## Sources
```

## Proposal And Decision Queue

```md
## Status Summary

- Scope: project-wide
- Filter: proposals and decisions
- Reliability: high | medium | low

## Counts

| Area                             | Count | Basis                    | Notes |
| -------------------------------- | ----- | ------------------------ | ----- |
| `proposals.by_status`            |       | field-based              |       |
| `proposals.accepted_unconverted` |       | field-based + link check |       |
| `decisions.by_status`            |       | field-based or inferred  |       |

## Queues

- Needs review:
- Accepted but not converted:
- Superseded/rejected:

## Recommended Next Actions

- ...

## Sources
```

## Member Workload Report

```md
## Status Summary

- Scope: member-specific
- Member: ...
- Reliability: high | medium | low

## Counts

| Area                  | Count | Basis                     | Notes |
| --------------------- | ----- | ------------------------- | ----- |
| active assignee tasks |       | field-based + board-based |       |
| review requests       |       | field-based + board-based |       |
| shared handoffs       |       | path-based + link-based   |       |

## Workload

- Assigned:
- Reviewing:
- Handoffs:
- Risks:

## Sources
```

## Blocked Work Report

```md
## Status Summary

- Scope: delivery-only
- Filter: blockers
- Reliability: high | medium | low

## Counts

| Area                                | Count | Basis                     | Notes |
| ----------------------------------- | ----- | ------------------------- | ----- |
| `tasks.blocked_unresolved`          |       | field-based               |       |
| Blocked cards                       |       | board-based               |       |
| Backlog tasks with planned blockers |       | field-based + board-based |       |

## Blocker Groups

- Dependency task:
- Decision:
- Access/environment:
- External source:

## Recommended Next Actions

- ...

## Sources
```
