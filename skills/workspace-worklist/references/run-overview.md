# Run Overview

Start here for `run-next`, `run-loop`, `run-goal`, worker dispatch, and loop stop decisions. Load narrower references only when needed.

## Reference Router

| Need                                         | Reference                       |
| -------------------------------------------- | ------------------------------- |
| mode defaults, run contract, rule merge      | `references/run-contract.md`    |
| selection checkpoints, source stability      | `references/run-selection.md`   |
| deadlines, parallelism, stop classes, risk   | `references/run-controls.md`    |
| planning, worker output, handoff and scratch | `references/worker-protocol.md` |

## Modes

`run-next`: execute one topmost valid `Active` item.

```text
read WORKLIST -> select item -> validate -> plan -> execute -> review -> log -> update WORKLIST
```

`run-loop`: process multiple valid `Active` items only when the user explicitly gives or confirms a finite loop budget.

Unbounded wording such as "until the queue is empty" is not a finite budget. In that case, propose a finite contract and wait for confirmation, or use `plan-only`.

Default loop contract:

```text
max-items: 3
deadline: none
parallel-work-items: 1
approval-mode: user-confirm
isolation: shared-worktree
```

`run-goal`: advance accepted Kanban/worklist tasks toward review readiness. It is not open-ended product discovery or autonomous creation of new team work.

Default goal contract:

```text
max-tasks: 1
max-items: 3
deadline: none
parallel-work-items: 1
approval-mode: user-confirm
stop-at: reviewing-ready
```

`run-goal` composes existing workflow owners:

- task selection: `next-task-selection`
- board changes: `kanban-maintenance`
- local intake and execution: `workspace-worklist:intake-task`, `run-next`, `run-loop`
- review readiness: `delivery-review`

Use the default contract only after the user has confirmed that a loop or goal run should start. Do not treat missing values or unbounded wording as implicit approval to execute.
