# Answer Examples

Use these examples only when the response shape is unclear.

## Create A Task

Question:

```text
Create a task for this requirement.
```

Answer:

```md
## Boundary

`knowledge-assistant` is read-only, so I will not create the task item or edit the Kanban board from this help request.

## Recommended Path

Use `knowledge-intake` first if the requirement still needs routing; use `knowledge-capture` only after you decide it should become a task item.

## Why

Task creation changes shared project knowledge and may affect delivery planning, so it belongs to the write-capable knowledge workflow.

## Next Prompt

"Use knowledge-intake to evaluate this requirement and recommend whether it should become product knowledge, a proposal, or a task item. If it is ready for capture, draft the exact knowledge-capture prompt."
```

## UX Issue

Question:

```text
I found a UX issue during debugging. Where should it go?
```

Answer:

```md
## Recommended Path

Use `knowledge-intake` first. Keep the raw note in the current member's `local/scratch/` unless the user already approves a canonical update.

## Why

Raw observations are not team facts until routed and approved.

## Next Prompt

"Use knowledge-intake to decide whether this UX issue should become product knowledge, design knowledge, a task item, or a local note."
```

## Kanban Card Picked

Question:

```text
I picked a card from KANBAN. What should I do now?
```

Answer:

```md
## Recommended Path

Use `workspace-worklist:intake-task`.

## Why

Kanban tracks team delivery state; WORKLIST tracks personal execution.

## Do Not Do Yet

Do not move the card to `Doing` without approved Kanban maintenance.

## Next Prompt

"Use workspace-worklist:intake-task to take this Kanban card into my local WORKLIST, check readiness and blockers, and prepare the Doing update dry-run if appropriate."
```

## TDD

Question:

```text
Should this bugfix use TDD?
```

Answer:

```md
## Recommended Path

Use `delivery-implementation` for the accepted delivery task. If Superpowers is available, use `superpowers:test-driven-development` as execution-method guidance.

## Why

Knowledge Workflow owns task context, checks, knowledge updates, and review gates. Superpowers can improve implementation discipline without replacing delivery ownership.

## Next Prompt

"Use delivery-implementation for this bugfix, and apply superpowers:test-driven-development before changing behavior when Superpowers is available."
```

## Parallel Work

Question:

```text
Can Superpowers run two work items in parallel?
```

Answer:

```md
## Recommended Path

Use `workspace-worklist:run-loop` or `workspace-worklist:run-goal` only after the user confirms a parallel budget. If Superpowers is available, use its worktree or subagent guidance as support.

## Why

Knowledge Workflow owns item selection, dependency checks, WORKLIST updates, approvals, logs, integration, and Kanban state.

## Do Not Do Yet

Do not dispatch parallel work before checking independence, file/resource conflicts, approval needs, and whether the items are accepted workflow work.
```

## Obsolete WORKLIST Item

Question:

```text
The next WORKLIST item may already be obsolete. What should I do?
```

Answer:

```md
## Recommended Path

Use `knowledge-assistant` for diagnosis, then `workspace-worklist:groom` if the item should be updated locally.

## Why

An obsolete WORKLIST item is personal execution state until it affects shared task metadata, Kanban state, or canonical knowledge.

## Example

Known: the item is in the current member's WORKLIST.
Uncertain: whether linked task, Kanban card, source requirement, or code state already resolved it.
Check: linked sources, current Kanban card, relevant task item, and likely git/code state.

## Do Not Do Yet

Do not run the item, rewrite shared facts, or move Kanban before confirming whether the work is still valid.

## Next Prompt

"Use workspace-worklist:groom to validate this WORKLIST item against its linked task, Kanban card, and current repo state, then propose whether to keep, update, move, or close it."
```

## Kanban Drift

Question:

```text
This Kanban card seems to be in the wrong column.
```

Answer:

```md
## Recommended Path

Use `task-metadata-audit` first, then `kanban-maintenance` only after an approved board-change plan.

## Why

Column drift can come from task metadata, blockers, review evidence, or an incomplete previous maintenance step. Audit is read-only; board movement is a separate approved action.

## Example

Known: the card's current column.
Uncertain: whether the linked task is ready, blocked, reviewing-ready, accepted, or cancelled.
Check: linked task item, `readiness`, `blocked_by`, acceptance evidence, review status, and current Kanban card.

## Do Not Do Yet

Do not move the card directly from help or audit output.

## Next Prompt

"Use task-metadata-audit to compare this card's column with the linked task metadata, blockers, and review evidence. If a board change is needed, prepare a kanban-maintenance dry run."
```

## Missing Auto-Review Rules

Question:

```text
Auto-review was requested, but this project has no stable auto-review rules.
```

Answer:

```md
## Recommended Path

Use conservative `workspace-worklist:run-goal` or `run-loop` behavior for this run, or ask a maintainer to define a stable auto-review rule set if the team wants reusable rules.

## Why

`auto-review` is a Knowledge Workflow approval mode. Without project rules, broad or unspecified auto-review is limited to low-risk actions such as local logs, local WORKLIST updates, read-only checks, and formatting already-approved files.

## Do Not Do Yet

Do not treat broad sandbox access as workflow approval, and do not auto-approve medium-risk edits without project rules or explicit task-level prompt rules.

## Next Prompt

"Ask a maintainer to audit the current Project-Specific Rules and propose a concise project rules dry run for auto-review."
```

## Timed Run Goal

Question:

```text
Run goal until 18:00 to advance my assigned Ready tasks to review.
```

Answer:

```md
## Recommended Path

Use `workspace-worklist:run-goal` with an explicit run contract.

## Why

`run-goal` coordinates accepted Kanban/worklist tasks toward review readiness. It is not open-ended discovery.

## Example

Candidate source: assigned `Ready` and `Doing` cards. Include `Reviewing` only for review or closest-to-Done goals.
Stop-at: deadline or review readiness.
Kanban rules: propose-only unless approved maintenance is explicitly allowed.
Review rules: delivery-review before Done.
Source stability: focused by default; strict only when risk or project rules require it.
Rule sources: skill baseline + Project-Specific Rules + this prompt.
Auto-review: low-risk only unless project rules or explicit task-level prompt rules allow medium-risk automation for the affected scope.

## Do Not Do Yet

Do not start new work after the deadline, edit Kanban without approved maintenance, run medium-risk auto-review without project rules support, or start another member's assigned task without second confirmation.

## Next Prompt

"Use workspace-worklist:run-goal for my assigned Ready/Doing tasks until 18:00. Confirm the run contract, use next-task-selection for candidates, stop at review readiness, and propose board updates instead of editing them unless I approve maintenance."
```
