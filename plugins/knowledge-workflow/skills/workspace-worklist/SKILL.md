---
name: workspace-worklist
description: Use when the current member asks to manage or run their local WORKLIST, including run-next, run-loop, run-goal, plan-only, grooming, or logs.
---

# Workspace Worklist

## Runtime Context

Before acting, resolve `<knowledge_dir>` using the runtime bootstrap rules, then read `<knowledge_dir>/.workflow/runtime.md` and `<knowledge_dir>/.workflow/manifest.yml`; do not assume non-default workflow paths or default ids.

Use this skill for personal, local member work under `<knowledge_dir>/workspace/<member-id>/local/`.

## Core Rules

- Resolve the current member id using `<knowledge_dir>/.workflow/runtime.md`.
- Use `<knowledge_dir>/workspace/<member-id>/local/WORKLIST.md` as the local worklist for executable or nearly executable personal work.
- Use `<knowledge_dir>/workspace/<member-id>/local/logs/YYYY-MM-DD.md` as the local daily execution log.
- Treat `local/` as local-only personal state. Never stage or commit it.
- Treat `<worktrees_dir>/` as local-only worktree state. Never stage or commit worktree contents.
- Do not write into another member's `local/` directory.
- Do not use `local/` content as team planning input unless it is first summarized or promoted into shared knowledge.
- Use `knowledge-capture`, `delivery-planning`, `kanban-maintenance`, `delivery-implementation`, or review skills when the selected item crosses into their ownership.
- For directory use, worktree use, and mode-specific rules, read `references/local-workflow.md`.

## Modes

Select the mode from the user's wording:

- `capture`: route a note, idea, task, reminder, or follow-up to `scratch/`, `drafts/`, or `WORKLIST.md` based on executability.
- `intake-task`: convert an assigned or selected accepted Kanban card into local WORKLIST execution items.
- `run-next`: continue, run the next item, or start work from the worklist.
- `run-loop`: process multiple executable `Active` items under an explicit loop budget; may use parallel subagents only when the user explicitly authorizes parallel execution.
- `run-goal`: coordinate existing task/worklist skills to advance one or more accepted Kanban tasks toward review readiness within an explicit goal, scope, budget, and approval mode.
- `plan-only`: validate and plan selected work items without applying changes.
- `groom`: organize, clean up, split, merge, or prioritize the worklist.
- `resume`: restore context from the worklist and recent logs.
- `log`: record started, progress, paused, completed, blocked, or follow-up notes.

For mode details, read `references/local-workflow.md`.

## Workflow

1. Resolve the current member id using `<knowledge_dir>/.workflow/runtime.md`.
2. Read relevant sections from `<knowledge_dir>/members/<member-id>.md` if public member context is needed. Avoid full-file reads unless editing, auditing, or resolving ambiguity.
3. Read local workspace instructions if they exist. Treat it as subordinate to workflow runtime, rules, schemas, task acceptance criteria, safety, privacy, approval, local-only, and review rules.
4. Ensure the local worklist exists.
5. Read `<knowledge_dir>/README.md`, `<knowledge_dir>/.workflow/rules/workspace.md`, and `<knowledge_dir>/.workflow/schemas/workspace.md`, then load the relevant reference:
    - `references/worklist-format.md` for worklist edits.
    - `references/log-format.md` for execution logs.
    - `references/routing.md` for deciding whether to stay local, promote, or intake a team task.
    - `references/run-overview.md` for `run-next`, `run-loop`, `run-goal`, and narrower execution references.
    - `references/run-contract.md`, `references/run-selection.md`, `references/run-controls.md`, or `references/worker-protocol.md` when the selected mode needs that detail.
    - `references/worktree-lifecycle.md` before using `<worktrees_dir>/shared/`.
6. For `run-next`, `run-loop`, and `run-goal`, classify selected work item or Kanban task validity before implementation.
7. Briefly report the selected item and validity result before making substantial changes.
8. Make the smallest local worklist/log edit needed for the mode.
9. If the work should become team knowledge or a formal task, propose the promotion path instead of hiding it in `local/`.
10. Before any staging or commit, verify `local/` files and worktree contents under `<worktrees_dir>/` are not staged, except the managed `<worktrees_dir>/.gitignore`.

## Guardrails

- Keep `WORKLIST.md` lightweight. Put execution detail in logs, not item metadata.
- Do not intake another member's work without explicit confirmation.
- Validate an item before implementation; if obsolete, blocked, superseded, or assigned elsewhere, do not implement it.
- `run-loop` and `run-goal` require explicit user intent and budget; default to serial execution.
- Parallel execution is allowlisted and must follow `references/run-controls.md` and `references/worker-protocol.md`.
- Log key events only. Avoid recording every command, file read, search, or transient thought.
- If an item affects team Kanban, formal task items, schema, commits, or another member's workspace, stop for confirmation or route to the owning skill.
- If a worker subagent edits outside the approved scope, fails validation, or leaves state unclear, stop the loop and ask for user direction.
- For detailed guardrails, read `references/local-workflow.md`.

## References

- Worklist format: `references/worklist-format.md`
- Local workflow rules and modes: `references/local-workflow.md`
- Log format: `references/log-format.md`
- Routing and promotion: `references/routing.md`
- Run overview: `references/run-overview.md`
- Run contract and rule merge: `references/run-contract.md`
- Run selection and source stability: `references/run-selection.md`
- Deadlines, parallelism, stop classes, approval risk: `references/run-controls.md`
- Worker protocol, handoff, scratch: `references/worker-protocol.md`
- Shared worktree lifecycle: `references/worktree-lifecycle.md`
