# Local Workflow Rules

Use these details after `workspace-worklist` has triggered.

## Local Paths

- Read relevant public sections from `<knowledge_dir>/members/<member-id>.md` when member context matters.
- Read local workspace instructions before changing the member workspace or running worklist items when they exist.
- Use `local/scratch/` for raw observations, rough notes, and inbox-style captures that are not executable.
- Use `local/drafts/` for structured personal drafts that may later be promoted and are not Superpowers spec or plan outputs.
- Use `local/superpowers/specs/` and `local/superpowers/plans/` only for Knowledge Workflow-guided Superpowers spec and plan outputs unless the user explicitly specifies another safe path; verify the local path is SCM-excluded before writing and do not commit local-only output.
- Create missing `local/`, `WORKLIST.md`, and `logs/` files on demand from `<knowledge_dir>/.workflow/templates/worklist.md`.

## Worktrees

- Use `<worktrees_dir>/shared/` as the reusable serial worker worktree when isolated worker execution is useful.
- Use `<worktrees_dir>/slot-XX/` worktrees only when the user explicitly authorizes parallel subagent execution for independent work items.
- If Superpowers worktree or subagent skills are available, align them with this workflow's runtime-resolved `<worktrees_dir>/` rules and main-Agent ownership boundaries. Do not let them choose unrelated worktree locations or bypass approval, local-only, log, review, or Kanban rules.
- If Superpowers brainstorming or writing-plans skills are available, align spec and plan output with `knowledge-assistant/references/superpowers.md` before invoking them, including explicit no-commit behavior for local-only output.

## Mode Rules

- `capture`: route a note, idea, task, reminder, or follow-up to `scratch/`, `drafts/`, or `WORKLIST.md` based on executability.
- `intake-task`: preserve links to the Kanban card, task item, requirement, or design resource in the WORKLIST item and log.
- `run-next`: run only the topmost executable `Active` item unless the user explicitly allows continuing.
- `run-loop`: use only when the user asks to continue automatically, process multiple `Active` items, or sets a loop budget.
- `run-goal`: use only for task/worklist execution goals; it is not open-ended research, discovery, or autonomous product-goal mode.
- `plan-only`: use when the user asks to plan without implementation, requests a dry run, or when implementation needs user review first.
- `groom`: suggest cleanup when `Active` has more than five items, `Waiting` lacks reasons, or `Done` is long enough to merit a summary.

## Execution Rules

- Add a Foam/Obsidian block anchor only when an item is first executed, logged, split for execution, or needs cross-day tracking.
- Default work item id format: `^wl-YYYYMMDD-xxxx`, where `xxxx` is a short lowercase alphanumeric suffix.
- Default raw captures to `scratch/`, structured personal drafts to `drafts/`, and only executable or nearly executable work to `WORKLIST.md#Later` unless the user asks to make it active.
- Treat `intake-task` as starting execution only when the work item is placed into an executable section such as `Active`; planning-only decomposition must not move the Kanban card to `Doing`.
- If intake or execution finds unresolved upstream dependencies, stop before implementation and propose task metadata or Kanban maintenance through the owning skill.
- Before running an `Active` item, check whether it is obsolete, already done elsewhere, contradicted by current project knowledge, blocked by a withdrawn requirement, or superseded by newer work. If invalid, do not implement it; move or mark it appropriately and log the reason.
- When `run-loop` cannot complete an item, classify the stop reason as `needs-user`, `blocked`, `out-of-scope`, `failed`, or `done-with-warnings`; log it, update the worklist state, and stop at unsafe boundaries.
- When a run has a deadline, stop starting new work at the deadline, finish or pause the current atomic step safely, write the local log, update WORKLIST state, and preserve enough context to resume.

## Delegation Rules

- `run-loop` is serial by default. Do not run multiple work items in parallel unless the user explicitly authorizes parallel subagent execution and a parallel budget.
- `run-goal` must delegate task selection to `next-task-selection`, board changes to `kanban-maintenance`, local intake/execution to workspace-worklist modes, and review judgment to `delivery-review`.
- Parallel execution is allowlisted, not denylisted. Before parallel execution, collect candidate `Active` items, validate each item, classify task type and risk, check dependencies and likely file/resource conflicts, then dispatch only items that meet all parallel eligibility conditions in `references/run-controls.md`.
- Treat a WORKLIST item as the main task and allow at most one subtask layer. If user text contains deeper nesting, treat deeper bullets as details of the second-level subtask.
- Planning, execution, and review subagents are optional load reducers. The main Agent decides when to use them and remains responsible for queue selection, dependency analysis, scope, approvals, integration, logs, and final decisions.
- Worker subagents must route approval or elevated-execution needs back to the main Agent. They must not self-approve elevated execution, dependency installation, deletion, publishing, commits, migrations, team-status changes, shared knowledge writes, Kanban changes, or local-only file promotion.

## Verification

- Use `superpowers:verification-before-completion` only as evidence discipline before completion, commit, PR, review-readiness, or Done claims.
- Knowledge Workflow review gates, task acceptance criteria, and Kanban approval remain authoritative even when Superpowers verification passes.
- Keep raw verification notes under the current member local workspace when they are local-only. Promote only summarized durable evidence through the owning review, task, handoff, or shared knowledge path.
