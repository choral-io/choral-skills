# Run Contract

Use this for `run-loop`, `run-goal`, rule sources, and approval-mode boundaries.

Before a long-running `run-goal`, present and confirm:

```text
goal:
scope:
current-member:
candidate-source: Reviewing | Doing | Ready | Backlog | mixed
max-tasks:
max-items:
deadline:
parallel-work-items:
approval-mode:
isolation:
stop-at:
rule-sources:
project-rules-status:
runtime-permission-model:
git-sync-rules:
kanban-rules:
review-rules:
source-stability-rules:
allowed-paths:
forbidden-actions:
protected-surfaces:
validation-strategy:
medium-risk-auto-review:
confirmation-required:
```

Before `run-loop`, present the same contract without `goal`, `candidate-source`, `max-tasks`, `kanban-rules`, and `review-rules`. If any contract field is unclear, use `plan-only`.

Contract field values:

| Field                    | Allowed values                                                                     |
| ------------------------ | ---------------------------------------------------------------------------------- |
| `approval-mode`          | `user-confirm`, `auto-review`, `plan-only`                                         |
| `isolation`              | `main-worktree`, `shared-worktree`, `slot-worktree`                                |
| `stop-at`                | `item-done`, `reviewing-ready`, `budget-used`, `deadline`, `blocked`, `needs-user` |
| `git-sync-rules`         | `no-sync`, `pull-before-start`, `ask-before-sync`                                  |
| `kanban-rules`           | `no-board-edits`, `propose-only`, `approved-maintenance`                           |
| `review-rules`           | `self-check`, `delivery-review`, `reviewer-subagent-if-needed`                     |
| `source-stability-rules` | `lightweight`, `focused`, `strict`                                                 |

`approval-mode` is a Knowledge Workflow concept, not a runtime permission concept. It does not assume, require, replace, or bypass any Agent application, sandbox, or tool-host permission model. When runtime permissions are broader than the run contract, follow the run contract. When runtime permissions are stricter, obey the runtime boundary and report the block.

## Rule Sources And Merge

Build `run-loop` and `run-goal` execution rules from three sources:

1. Skill baseline rules: this skill, workflow rules, and repository safety rules. This is the hard floor.
2. Project rules: root `AGENTS.md` -> `Project-Specific Rules`.
3. Prompt rules: the current user instruction for this run.

Merge rules:

- Skill baseline cannot be weakened.
- Project rules may refine or tighten the baseline, and may authorize medium-risk auto-review only inside baseline guardrails.
- Prompt rules may narrow scope and enable automation inside the baseline and project rules. If project rules are missing or partial, explicit task-level prompt rules may supply temporary boundaries for the current run.
- If rules conflict, choose the more conservative rule or stop and ask.
- If project rules are missing or partial, warn before starting; the prompt may supplement this run, but reusable rules should be proposed through maintainer workflow administration.

Assume runtime permissions may be broad or automatically approved. Use project rules as the self-limiting contract that decides what the Agent should do, even when the environment technically allows more.

Before `auto-review` or `run-goal`, check whether project rules define:

- allowed paths or selection rules;
- protected or high-risk change surfaces;
- actions that require confirmation;
- validation strategy;
- whether medium-risk auto-review is allowed.

If project rules do not define enough execution boundaries, broad or unspecified `auto-review` is limited to low-risk actions. Medium-risk work requires explicit task-level confirmation unless the prompt supplies clear temporary boundaries for this run.
