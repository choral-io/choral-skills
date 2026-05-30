# Run Selection

Use this for `run-goal` selection checkpoints, source stability, and downstream follow-up.

## Selection Checkpoints

`run-goal` may re-check `Reviewing`, `Doing`, `Ready`, or `Backlog` after a task reaches review readiness, becomes blocked, exhausts local items, reaches a budget, or when the user asks to keep pulling eligible work.

Use this source order inside the confirmed scope:

1. `Reviewing` cards when the user asks for work closest to Done, review follow-up, or completion readiness. Route these to `delivery-review`; do not implement or move to Done directly.
2. `Doing` cards with linked current-member `Active` WORKLIST items. Continue these before pulling new Ready work unless the user explicitly excludes Doing.
3. `Ready` cards selected through `next-task-selection`.
4. `Backlog` cards only when explicitly included in the run goal; blocked planned dependencies remain context until blockers resolve.

When a prompt says "assigned Ready tasks", keep the scope to Ready even if local Active items exist. When a prompt says "Doing", "active", "continue", "closest to Done", or "finish current work", include the earlier source classes above.

At a checkpoint:

1. Check repository and worktree state.
2. If freshness matters, propose `git pull`; in `auto-review`, pull only when clean, classified as `low` risk, and no worker result is pending.
3. Re-read `<knowledge_dir>/planning/KANBAN.md` and linked task context.
4. Route `Reviewing` cards in scope to `delivery-review`.
5. Continue `Doing` cards with linked current-member Active WORKLIST items before selecting new Ready work.
6. Use `next-task-selection` for Ready or Backlog candidates within the goal scope.
7. Intake only approved candidates.

Never move a card to `Done` from `run-goal`; use `delivery-review` and approved `kanban-maintenance`.

## Source Stability

Default `source-stability-rules`: `focused`.

Use layered source checks so long-running `run-goal` stays reliable without expensive full scans:

| Rules         | When to use                                            | Required checks                                                                                                                                                    |
| ------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `lightweight` | simple `run-next` or low-risk local work               | repository state, selected WORKLIST item, and directly linked task or note                                                                                         |
| `focused`     | default for `run-goal` and medium-risk work            | lightweight checks plus selected task `Sources`, `blocked_by`, required requirement/design/resource links, and likely dirty-file overlap                           |
| `strict`      | high-risk surfaces, unclear freshness, or user request | focused checks plus broader linked context, relevant schema/workflow rules, planned validation, and whether related sources are committed and synced when required |

Every checkpoint performs lightweight checks. Before starting a selected task, perform focused checks. Use strict checks only when the run contract, risk, dirty state, protected surface, worker dispatch, or user prompt requires it.

If source stability cannot be established, classify the item as `blocked`, `out-of-scope`, or `needs-user` instead of implementing.

## Downstream Follow-Up

Use two stages for tasks whose completion may release downstream work:

1. At `reviewing-ready`, reverse-look up downstream tasks whose `blocked_by` references the selected task and report possible follow-up only. Do not change downstream readiness or Kanban state.
2. After `delivery-review` accepts the task, reverse-look up again and propose actionable downstream readiness, task metadata, or Kanban follow-up through the owning skill.

Never treat `reviewing-ready` as delivery completion or as permission to update downstream cards automatically.
