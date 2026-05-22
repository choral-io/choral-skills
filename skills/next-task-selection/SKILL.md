---
name: next-task-selection
description: Use when the user asks which accepted Kanban task to work on next and dependencies or readiness may affect the answer.
---

# Next Task Selection

## Runtime Context

Before acting, use the repository Knowledge Workflow runtime context from root `AGENTS.md` and its manifest; do not assume workflow paths or default ids.

Use this skill to recommend the next accepted delivery task from `<knowledge_dir>/planning/KANBAN.md`. This skill is read-only by default.

## Workflow

1. Resolve the current member id using the order defined in root `AGENTS.md`.
2. Read `Responsibilities` and `Focus Areas` from `<knowledge_dir>/members/<member-id>.md` when present; read `Availability` only when the user asks for capacity-aware selection.
3. Read `<knowledge_dir>/workspace/<member-id>/local/AGENTS.md` only when the user asks for automatic start, personal execution preferences, or a member-personal recommendation. Use it only as a preference signal.
4. Read `<knowledge_dir>/planning/KANBAN.md`.
5. Read `<knowledge_dir>/.workflow/rules/delivery.md`.
6. Read `<knowledge_dir>/.workflow/schemas/tasks.md`.
7. Prefer `Ready` cards over `Backlog` cards.
8. Open each candidate's linked task item.
9. Exclude localized files, local-only notes, archived notes, cards in `Blocked`, and tasks with unresolved `blocked_by` entries.
10. Partition eligible candidates by assignment:
    - tasks where `assignees` includes the current member id
    - tasks with missing or empty `assignees`
    - tasks assigned only to other members
11. Build a lightweight dependency view from `blocked_by` and `related_to`; derive downstream unlock potential by reverse-looking up tasks blocked by each candidate.
12. Score candidates with the selection table in `references/scoring.md`.
13. Recommend one next task from the first non-empty partition.
14. Report blockers, missing metadata, any `Ready` card that still has unresolved blockers, and any task that looks ready but is not in `Ready`.

Normalize member and group wikilinks in `owners`, `assignees`, and `reviewers` before matching. For example, `[[Gavroche]]` and `[[Gavroche|Display Name]]` both match id `Gavroche`.

## Selection Rules

- Select only accepted Kanban cards from `<knowledge_dir>/planning/KANBAN.md`.
- Do not recommend loose task items from `<knowledge_dir>/tasks/*.md` that are not linked from a Kanban card.
- If the user asks to rank task items, backlog candidates, or work not yet on the Kanban board, route to `delivery-planning` instead of selecting it for implementation.
- Do not start implementation unless the user explicitly asks.
- Do not move cards; use `kanban-maintenance` after maintainer approval.
- Treat `blocked_by` as a hard blocker unless all referenced tasks are `Done` or the blocker is documented as resolved.
- Treat a `Ready` card with unresolved `blocked_by` or `readiness: blocked` as a board/task consistency problem, not as an eligible candidate.
- Treat group assignees as team-pool assignment rather than assignment to the current member.
- Treat `owners` as durable responsibility, not current assignment.
- Do not let member profile sections or local `AGENTS.md` override task metadata, dependencies, readiness, approval, safety, or review rules.
- For source stability, assignment partitions, downstream value, and status-column details, read `references/selection-rules.md`.

## Auto-Start Rules

- If the user explicitly says the Agent may automatically start, the Agent may start the recommended task from `assigned-to-current-member` or `unassigned` according to the user's stated mode.
- Tasks in `assigned-to-others` always require a second explicit user confirmation before starting, even when the user allowed automatic start.
- Automatic start is allowed only when the selected task has `readiness: ready`, no unresolved `blocked_by` entries, observable acceptance criteria, committed and remote-synced source material when a default remote exists, and no conflict with current dirty worktree changes.
- Automatic start must stop if the task appears to require secrets, private customer data, or private personal information.
- If automatic start is allowed and the selected card must move to `Doing`, propose or apply the move only under the approval rules in `kanban-maintenance`.
- If the user's automatic-start permission is ambiguous, recommend the task and ask before starting implementation.

## Output

- Recommended next task with source link.
- Short rationale.
- Candidate score table.
- Assignment partition used: `assigned-to-current-member`, `unassigned`, or `assigned-to-others`.
- Auto-start decision: `started`, `needs confirmation`, or `recommendation only`.
- Blocked or metadata-problem tasks.
- Suggested board move, if any, as a proposal only.
- Source stability status: `verified`, `needs verification`, or `not ready`.

## References

- For scoring and metadata examples, read `references/scoring.md`.
- For detailed selection, source stability, and auto-start rules, read `references/selection-rules.md`.
