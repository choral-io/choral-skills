# Routing

## Stay Local

Keep work local when it is:

- personal execution state
- temporary investigation
- local debugging flow
- a reminder or follow-up
- a small next action for an existing task
- not yet suitable for team review

Use local areas by maturity:

| Material                  | Local target               |
| ------------------------- | -------------------------- |
| Raw idea or observation   | `local/scratch/`           |
| Inbox-style rough capture | `local/scratch/`           |
| Structured personal draft | `local/drafts/`            |
| Executable next action    | `local/WORKLIST.md`        |
| Execution progress        | `local/logs/YYYY-MM-DD.md` |

## Validate Before Run

Before executing a selected `Active` item, do a lightweight validity check:

- Search for linked task ids, work item ids, or obvious title keywords in project knowledge and code.
- Check whether linked task items, decisions, requirements, or Kanban cards still exist and are not cancelled, archived, superseded, or contradicted.
- Check whether the requested change already appears implemented in the code or knowledge base.
- Check whether the item depends on another member, an unresolved blocker, or a withdrawn requirement.
- Classify the item using the Validity Classification table below.

Keep this check proportional. Do not run a full repository audit for every small local item unless the user asks for strict verification.

## Validity Classification

Use exactly one validity value before implementation:

| Validity       | Conditions                                                               | Default action                                              |
| -------------- | ------------------------------------------------------------------------ | ----------------------------------------------------------- |
| `valid`        | Current, not blocked, not contradicted, and still useful                 | Implement or continue according to mode                     |
| `already-done` | The requested result already exists in code, knowledge, or board state   | Move local item to `Done`; log evidence; do not implement   |
| `superseded`   | A newer task, decision, requirement, or implementation replaces it       | Move local item to `Waiting`; log replacement link          |
| `blocked`      | Unresolved dependency, access, environment, decision, or upstream task   | Move local item to `Waiting`; log blocker; do not implement |
| `withdrawn`    | Linked requirement, task, decision, or maintainer instruction cancels it | Move local item to `Done`; log withdrawal source            |
| `unclear`      | Evidence is insufficient or conflicting                                  | Stop and ask the user before changing project files         |

Use `valid` only when no other row matches. Do not treat `unclear` as permission to proceed.

## Promote Or Summarize

Suggest promotion when work becomes useful to the team:

| Signal                          | Target                                                            |
| ------------------------------- | ----------------------------------------------------------------- |
| Edited personal work summary    | `<knowledge_dir>/workspace/<member-id>/summaries/`                |
| Handoff for another member      | `<knowledge_dir>/workspace/<member-id>/handoffs/`                 |
| Shareable investigation         | `<knowledge_dir>/workspace/<member-id>/research/`                 |
| Product requirement or behavior | `<knowledge_dir>/product/`                                        |
| UI or interaction guidance      | `<knowledge_dir>/design/`                                         |
| Domain term                     | `<knowledge_dir>/concepts/`                                       |
| Technical structure             | `<knowledge_dir>/architecture/`                                   |
| Decision or tradeoff            | `<knowledge_dir>/decisions/`                                      |
| Cross-area writing or language  | `<knowledge_dir>/guidelines/`                                     |
| Executable team work            | `<knowledge_dir>/tasks/`                                          |
| Delivery status                 | `<knowledge_dir>/planning/KANBAN.md` through `kanban-maintenance` |

Summary extraction is flexible. Use daily summaries for routine reporting, weekly summaries for trend and planning review, and ad hoc summaries for milestones, interrupted work, investigations, or handoffs. Ask the user to adjust scope when the intended audience or period is unclear.

## Task Intake

Use `intake-task` when a developer receives, selects, or starts an accepted team task from `<knowledge_dir>/planning/KANBAN.md`.

Intake is a bridge from team planning to personal execution. It writes only the current member's local `WORKLIST.md` and `logs/YYYY-MM-DD.md` unless the user explicitly asks to update team planning.

Task items are durable task context, not accepted execution queue items by themselves. Do not intake a loose task item as team delivery work unless it is linked from a Kanban card. If the user wants to turn a task item into accepted team work, route to `delivery-planning` first.

Before intake:

- Resolve the current member id using the order defined in root `AGENTS.md`.
- Read the Kanban card and linked task, requirement, design, or decision documents.
- Confirm the task is assigned to the current member, unassigned, or explicitly selected by the user.
- If the task is assigned to another member, ask before taking it.
- Check blockers, dependencies, readiness, and whether the task is already done or cancelled.

When creating the local item:

- Preserve source links to the Kanban card, task item, and important supporting resources.
- Keep the Kanban task as the delivery unit and the WORKLIST item as the personal execution unit.
- Split into at most one layer of subtasks.
- Put it under `Active` only when the user says to start or take it now; otherwise put it under `Later`.
- Log the intake event with source links and the next concrete step.

Do not update Kanban status during intake unless the user explicitly asks. Use `kanban-maintenance` for approved board updates.

## Handoff Intake

Do not scan every team handoff on every `run-next`. Look for handoffs when:

- the user asks what to pick up from others
- the user's `Active` list is empty and they ask to continue team work
- a selected work item or task item links to a handoff
- a task is assigned to the current member and references `workspace/*/handoffs/`
- a maintainer asks to triage handoffs

Before taking a handoff:

- Confirm it is intended for the current member or the team.
- Check whether there is a linked task item or Kanban card.
- If there is no formal task but the work is substantive, propose creating or updating a task item first.
- Do not modify another member's handoff unless explicitly asked; create follow-up notes in the current member's `local/WORKLIST.md` or the formal task.

## Do Not Use Worklist For

- assigning work to another member
- bypassing task item or Kanban approval
- storing secrets or private customer data
- replacing project knowledge documents
- recording long execution transcripts
- staging or committing local-only files
