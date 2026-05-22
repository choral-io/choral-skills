# Local Execution

Use this for `WORKLIST.md`, "continue", "run next", "run loop", local logs, handoffs, worktrees, or subagents.

- Resolve the current member using the order defined in root `AGENTS.md`.
- Default to `run-next` for one item unless the user authorizes `run-loop` or `run-goal`.
- `run-loop` needs `max-items`; parallel execution also needs `parallel-work-items` and independent items.
- `run-goal` coordinates accepted Kanban/worklist tasks toward review readiness; it is not open-ended discovery. It composes `next-task-selection`, `workspace-worklist`, `delivery-implementation`, `delivery-review`, and approved `kanban-maintenance` under a confirmed run contract.
- For `run-goal` or `auto-review`, merge execution rules from skill baseline, root `AGENTS.md` `Project-Specific Rules`, and the current prompt. The skill baseline is the hard floor; project and prompt rules may narrow scope or authorize automation only inside that floor.
- `auto-review` is a Knowledge Workflow approval mode, not an Agent application or sandbox permission mode. It does not assume, require, replace, or bypass runtime permission prompts; when runtime access is broad, the workflow run contract remains the Agent's self-limiting boundary.
- If project-specific rules are missing or partial, say so before starting. In that case, broad or unspecified `auto-review` allows only low-risk automation; medium-risk work needs explicit task-level confirmation unless the prompt supplies clear temporary boundaries for this run. If the team wants repeatable automation, recommend `knowledge-workflow-admin:config`.
- Default `run-goal` source stability to focused checks: repository state, selected task context, `Sources`, `blocked_by`, required links, and likely dirty-file overlap. Use strict checks only for high-risk, unclear, protected, worker-dispatched, or user-requested cases.
- Before execution, classify selected item validity as `valid`, `already-done`, `superseded`, `blocked`, `withdrawn`, or `unclear`.
- Stop or switch skills before crossing into Kanban edits, task metadata changes, shared knowledge writes, another member's workspace, commits, publishing, deletion, dependency installation, or elevated execution.
- Keep worktrees under `<worktree_dir>/`; keep worktree contents out of git.
- Use formal shared handoff files only for cross-member, long-lived, complex, or explicitly requested handoffs.

Failure classes for local execution: `needs-user`, `blocked`, `out-of-scope`, `failed`, `done-with-warnings`. Do not recommend silent retry, unlimited retry, or continuing after high-risk or unclear failures.
