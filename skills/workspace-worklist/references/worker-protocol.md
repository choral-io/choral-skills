# Worker Protocol

Use this for planning, worker dispatch output, worker review, handoff, and scratch state.

## Planning And Execution

Choose the lightest safe path:

- direct main-Agent plan for work that fits one file or one tightly scoped change and has no unresolved dependency;
- read-only planner for unclear requirements, multi-file scope, dependency checks, risk assessment, or context pressure;
- worker for bounded execution;
- shared worktree for serial isolation;
- slot worktree only for authorized parallel batches.

Planner output:

```md
## Plan

## Scope

## Proposed Subtasks

## Allowed Paths

## Risks

## Required Checks

## Confirmation Needed

## Suggested Execution Mode

direct | worker | shared-worktree
```

Treat one WORKLIST item as the main task. It may have one subtask layer; deeper bullets are details, not independent execution levels.

## Worker Protocol

Worker receives summary, item id, batch mode, approved plan, allowed/forbidden paths, dependency assumptions, validation requirements, execution mode, and worktree path.

Worker may create local commits inside the assigned worktree for review. Worker must not edit `WORKLIST.md`, logs, local scratch state, `KANBAN.md`, another member workspace, main repository history, or shared delivery state; must not push, rebase, merge, reset, clean, spawn subagents, or expand scope.

Worker output:

```md
## Result

completed | blocked | failed | needs-review

## Changed Files

## Worker Commit

none | <local commit sha and subject>

## Scope Check

## Validation

## Follow-ups

## Risk

low | medium | high

## Worklog Draft
```

The main Agent reviews changed files, worker commits, allowed paths, relevant diff, validation, risks, and follow-ups before integrating changes or updating WORKLIST/logs. Use reviewer subagents only for large diffs, workflow/schema/Skill changes, subtle regressions, or failed-worker follow-up.

If a worker is blocked, fails, leaves dirty state, or reports unusable state, make one bounded non-destructive recovery decision. If recovery would need reset, clean, rebase, merge, delete, rebuild, credentials, business judgment, or scope change, stop or use `references/worktree-lifecycle.md`.

## Handoff And Scratch

Default run handoffs belong in the final response, local log, or current worklist item. Create a shared handoff file only when team-relevant, cross-member, long-lived, complex enough to survive chat, or explicitly requested.

Use `workspace/<member-id>/local/runs/<work-id>/` only for temporary loop coordination. Rebuild stale scratch from `WORKLIST.md`, copy important unlogged information to today's log, and clean scratch after durable logs and worklist updates are written.
