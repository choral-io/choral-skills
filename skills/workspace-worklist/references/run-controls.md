# Run Controls

Use this for deadlines, parallel execution, dependency stop classes, and approval-mode risk.

## Deadlines

Parse user deadlines or durations to an absolute time and repeat it before starting.

At the deadline:

- do not select, intake, dispatch, or start new work;
- finish or pause the current atomic step safely;
- run only cheap validation needed to preserve state;
- write the local log, update WORKLIST, and record next action, blockers, partial work, and validation state.

Do not skip checks, review, approval, or Kanban gates to beat a deadline.

## Parallel Execution

Parallel work is opt-in. Use it only when the user explicitly authorizes parallel subagents and gives or accepts `parallel-work-items`.

Before dispatch:

1. Collect candidate `Active` items within the budget plus at most `parallel-work-items` additional lookahead items.
2. Validate each item.
3. Classify type, risk, likely touched areas, required skills, approvals, and checks.
4. Check dependencies and conflicts from item order, explicit links, task metadata, source references, likely files, blockers, and shared resources.
5. Select an independent batch no larger than `parallel-work-items`.
6. Dispatch only low- or medium-risk independent items.

Use isolated `<worktrees_dir>/slot-XX/` worktrees for parallel workers. Do not run parallel workers in the main worktree or shared serial worktree.

Parallel eligibility requires:

- valid, current, not-blocked item;
- no dependency on another batch item;
- no likely overlap in files, schemas, APIs, migrations, lockfiles, fixtures, global styles, or shared resources;
- clear allowed paths, forbidden paths, validation, and success criteria;
- result can be reviewed and integrated independently;
- approval or elevated execution needs can route back to the main Agent.

If eligibility is uncertain, keep the work serial or use a read-only planner first.

## Dependencies And Stop Classes

Dependency layers:

- Kanban/task: `blocked_by` is hard, `related_to` is context, downstream unlocks are derived by reverse lookup, and shared module/source/resource is a conflict signal.
- WORKLIST: explicit "after", "depends on", or "requires" is hard; item order is only a weak default.

Keep implementation and its validation/review follow-up serial unless the dependency is clearly absent.

When an item cannot complete, classify the stop:

| Class                | Meaning                                                        | Default behavior                                |
| -------------------- | -------------------------------------------------------------- | ----------------------------------------------- |
| `needs-user`         | approval, authority, credentials, or judgment required         | stop and ask                                    |
| `blocked`            | dependency, source, environment, or access unavailable         | log, mark waiting, continue only if independent |
| `out-of-scope`       | would exceed item, forbidden area, or team-status boundary     | stop and report                                 |
| `failed`             | validation/execution failed with no reliable repair path       | stop and report                                 |
| `done-with-warnings` | mostly complete with residual risk or skipped/incomplete check | log warning; stop if risk affects later items   |

Do not retry indefinitely or continue after high-risk failure, unclear repository state, out-of-scope change, or failed worker output.

## Approval Modes

- `user-confirm`: default; stop when confirmation is needed.
- `auto-review`: main Agent may continue after self-reviewing scope, risk, diff, validation, rule sources, and the run contract.
- `plan-only`: plan without implementation.

`auto-review` is a workflow approval mode. It is not runtime authorization, and it does not approve tool calls, escalation, sandbox overrides, or host-application permission prompts. Deletion, commits, publishing, external transmission, account or permission changes, software installation, local system changes, elevated execution, and project-defined protected or high-risk surfaces still require user confirmation at the workflow layer. Worker subagents never self-approve elevation.

Use this risk classification before self-approval:

| Risk     | Conditions                                                                                                                          | Workflow auto-review behavior                                                                                                                             |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `low`    | Local-only notes/logs, read-only checks, formatting approved files, or edits limited to approved paths                              | Main Agent may proceed after review when the run contract allows it                                                                                       |
| `medium` | Source code, shared knowledge, task metadata, or generated artifacts within approved scope                                          | Proceed only when user allowed auto-review and project rules or explicit task-level prompt rules allow medium-risk automation for the affected scope      |
| `high`   | Deletion, reset, migration, dependency install, external publish/transmission, secrets, permissions, commits, or protected surfaces | Requires explicit workflow confirmation unless the current user instruction and project rules both give a specific task-level exception inside guardrails |

If any condition from a higher risk row applies, use the higher risk. If risk cannot be classified, treat it as `high`.
