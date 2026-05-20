# Shared Worktree Lifecycle

Use this reference when `workspace-worklist` chooses `shared-worktree` or `slot-worktree` execution.

The serial shared worker worktree is:

```text
<worktree_dir>/shared/
```

Parallel worker slot worktrees are:

```text
<worktree_dir>/slot-01/
<worktree_dir>/slot-02/
...
```

It is local worktree state. Worktree contents must not be staged from the main worktree, linked from knowledge documents, or treated as project facts.

## When To Use

Use the shared worktree when isolated worker execution is useful and the task is still serial:

- worker subagent may need to experiment
- the main worktree has user edits that should not be touched
- the task is larger than a direct edit
- `run-loop` is processing multiple items over time

Use direct execution for single-file documentation edits, single-file metadata updates, or one-file changes with an explicit target path and validation step.

Use slot worktrees only when `run-loop` or `run-goal` has explicit user authorization for parallel subagent execution and the main Agent has selected independent work items.

## Preconditions

Before dispatching a worker:

1. Confirm `<worktree_dir>/.gitignore` exists and ignores worktree contents.
2. Confirm the selected worktree is not already in use.
3. Check main worktree status.
4. Check whether the selected item may conflict with existing dirty files.
5. Check whether the shared worktree exists.
6. If it exists, verify it is clean enough to reuse.
7. If it is dirty or stale and the safe reset path is unclear, stop and ask the user.

Do not install dependencies or run setup commands in the shared worktree unless the user has authorized that for this worktree.

## Git Sync Rules

Use git conservatively. The main Agent owns git synchronization decisions. Worker subagents may create local commits inside their assigned worktree for review. Worker subagents must not pull, push, rebase, merge, reset, clean, or commit to main repository history unless that exact git task was assigned.

Before selecting new Kanban work, starting `run-goal`, or syncing a worker worktree:

1. Inspect current branch, upstream/default remote, and worktree status.
2. If there is no default remote or upstream, skip remote freshness checks and record that limitation.
3. If the main worktree has unrelated dirty user changes, do not pull or switch base automatically.
4. If freshness matters and the worktree is clean, propose `git pull` in `user-confirm`; in `auto-review`, pull only when the operation is classified as `low` risk by `references/run-controls.md` and no local worker result is pending.
5. If pull would create conflicts, require credentials, change submodules, update lockfiles unexpectedly, or alter unrelated user work, stop and ask the user.
6. After a successful pull, re-read `KANBAN.md`, linked task items, and any source files used for selection.

Do not use remote sync as a hidden side effect of task selection. Mention it in the run contract or checkpoint result.

## Branch And Slot Model

Use stable worktree paths:

```text
<worktree_dir>/shared/
<worktree_dir>/slot-01/
<worktree_dir>/slot-02/
```

If a worktree needs a branch, prefer stable local branch names such as:

```text
codex/worklist-shared
codex/worklist-slot-01
codex/worklist-slot-02
```

Do not create a new random worktree per item by default. Reuse `shared/` for serial worker isolation and reusable `slot-XX/` paths for explicitly authorized parallel work.

Do not automatically reset, clean, rebase, delete, or recreate a worktree to make it reusable. If a worktree is dirty, stale, or points at an unclear base, stop and ask the user unless the maintenance action was explicitly approved.

## Create Or Sync

Creation and sync are implementation details for the main Agent, but the result must be:

- selected worktree points at the intended base revision
- selected worktree has no unreviewed leftover worker changes
- worker receives the worktree path and approved scope

If the project requires dependency installation in the shared worktree, do it as a separate user-approved setup step and record that in the work log.

## Worker Rules

Worker runs inside the assigned worktree path.

Worker must:

- stay within allowed paths
- produce a patch or local commit for review
- keep any local commit confined to the assigned worktree and branch
- report changed files and validation results
- report if dependency setup or elevated execution is needed

Worker must not:

- edit the main worktree
- edit `WORKLIST.md`, `local/logs/`, `local/runs/`, `KANBAN.md`, or other member workspaces
- create final project commits in the main worktree or push worker commits
- spawn subagents
- reset or clean the shared worktree unless the main Agent explicitly assigned that maintenance task
- read or modify another worker slot

## Main-Agent Review

After worker completion:

1. Inspect worker status and changed files.
2. Reject or stop if changes are outside allowed paths.
3. Review the diff or worker commit. Treat worker commits as review artifacts, not accepted project history.
4. Run or evaluate required validation.
5. Apply accepted changes to the main worktree by patch, cherry-pick, or another reviewable method appropriate to the risk.
6. For parallel slots, integrate only one accepted worker result at a time.
7. Update `WORKLIST.md` and logs from the main worktree only.

If the worker result is unsafe, unclear, or conflicts with user edits, stop and ask for direction.

Do not merge an entire worker branch blindly. Review changed files, allowed paths, validation, lockfile or schema changes, and knowledge-update needs before integration. A worker local commit may be cherry-picked only after that review.

Accepted worker changes must be integrated back into the main worktree before WORKLIST or Kanban state is marked complete. If integration is postponed, keep the item active or waiting and record the worker result location.

## Recovery Decision

If a worker worktree is dirty, stale, blocked, or otherwise unusable, the main Agent makes a bounded recovery decision before retrying:

1. Inspect status, changed files, branch/base, and worker report.
2. Decide whether the issue can be handled without destructive cleanup or scope expansion.
3. If recoverable without worktree maintenance, provide a corrected prompt, missing context, approved setup step, or safe sync action.
4. Re-dispatch only when the allowed paths, base, and validation requirements are still clear.
5. Record the recovery decision in the local work log.

The main Agent treats worker worktree repair as controlled maintenance. Stop or use the maintenance rules below when recovery would require reset, clean, rebase, merge, delete, rebuild, unrelated dirty-file handling, user credentials, business judgment, or changing the task scope.

## Worktree Maintenance

Worktree maintenance is a controlled operation, separate from normal worker recovery. The main Agent may delete, rebuild, reset, or reset a worker worktree to a specific revision only when the safety conditions and approval requirements below are satisfied.

Safety conditions:

- The target path is under `<worktree_dir>/shared/` or `<worktree_dir>/slot-XX/`.
- The target is not the main worktree.
- No worker is currently using the target.
- There are no unintegrated worker results, or they are recorded and explicitly abandoned or already integrated.
- The main Agent has inspected status, changed files, branch, and base revision.
- The target revision is explicit, such as `HEAD`, `origin/main`, the current main-worktree commit, or a user-provided commit.
- The operation will not affect unrelated user changes or project history.

Risk levels:

- Low risk: inspect state, mark a slot unusable, create a missing slot, or fast-forward/sync a clean worker worktree to an approved base.
- Medium risk: delete and recreate a clean worker worktree, reset a clean or explicitly disposable worker branch to an approved revision, or clean recorded disposable leftovers.
- High risk: reset/clean a dirty worktree, delete a worktree with uncommitted changes, resolve merge/rebase conflicts, discard unintegrated worker output, or change the main worktree branch/base.

Approval rules:

- `user-confirm`: present the maintenance dry-run and wait for approval.
- `auto-review`: only `low` risk maintenance may proceed automatically when the run contract allowed it.
- High-risk maintenance always requires explicit user confirmation.

Maintenance flow:

1. Identify the target worktree and intended base revision.
2. Show the planned operation, risk level, current status, and what will be preserved or discarded.
3. Get approval when required.
4. Execute the maintenance.
5. Verify the target is clean and at the expected revision.
6. Record the maintenance result in the local log or loop summary.

## Cleanup

After accepted or rejected worker output:

- Leave the main worktree as the only place where accepted changes exist.
- Reset or prepare the worker worktree for the next item only when the main Agent can do so safely.
- If cleanup fails, mark that worktree as unusable in the current loop and stop before dispatching another worker to it.

Never use broad destructive operations in the main worktree to recover from shared worktree problems.
