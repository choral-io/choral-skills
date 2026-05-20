# Delivery

Use this for task items, `KANBAN.md`, Ready, Doing, Reviewing, Blocked, Done, or Cancelled.

- `tasks/` holds durable task context and acceptance criteria.
- `planning/KANBAN.md` tracks delivery status; cards stay thin and link to task items.
- `delivery-planning` proposes board changes; `kanban-maintenance` applies approved changes.
- `next-task-selection` selects accepted Kanban cards, not loose task items, and outputs a candidate score table when ranking alternatives.
- Starting from a card should use `workspace-worklist:intake-task` when local execution tracking is useful.
- `delivery-implementation` should produce or confirm an implementation plan before editing, then provide review readiness evidence before delivery review.
- Move to `Doing`, `Reviewing`, `Blocked`, `Done`, or `Cancelled` only through approved board maintenance.
- `delivery-review` is the gate before `Done` when implementation, acceptance criteria, source knowledge, or required checks changed.
- `Done` requires delivered work, relevant checks or documented skips, updated durable knowledge when needed, completed local log, review acceptance, and approved board movement.
- `readiness` is execution readiness, not delivery completion state; Kanban records `Doing`, `Reviewing`, `Blocked`, `Done`, and `Cancelled`.
- At `reviewing-ready`, report possible downstream follow-up only. After `delivery-review` accepts the task, reverse-look up tasks blocked by the completed task and propose downstream readiness or board follow-up when blockers are resolved.
