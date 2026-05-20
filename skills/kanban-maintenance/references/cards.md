# Kanban Card Examples

Canonical board:

```text
<knowledge_dir>/planning/KANBAN.md
```

Column order:

1. `Backlog`
2. `Ready`
3. `Doing`
4. `Reviewing`
5. `Blocked`
6. `Done`
7. `Cancelled`

Preferred card:

```md
- [ ] [[example-delivery-task|Example delivery task]]
```

Temporary scheduling metadata is allowed only when the approved dry run includes it:

```md
- [ ] [[example-delivery-task|Example delivery task]] · P1 · app · Gavroche
```

The linked task item holds durable details.

Resolve `[[example-delivery-task]]` to `<knowledge_dir>/tasks/example-delivery-task.md` by default. If multiple canonical files match the same id, report ambiguity instead of guessing.

## Move Matrix

Use this matrix before editing `<knowledge_dir>/planning/KANBAN.md`:

| Transition                       | Required evidence                                                                                                             | Metadata side effects                                                         |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `Backlog -> Ready`               | linked task has `readiness: ready`; no unresolved `blocked_by`; Ready Checklist satisfied; owners resolve                     | none required; propose metadata fixes first if not ready                      |
| `Backlog -> Doing`               | maintainer explicitly approved immediate start; assignee/current handler confirmed; Ready Checklist satisfied; owners resolve | confirm or set `assignees` through approved task metadata change              |
| `Ready -> Doing`                 | current handler confirmed; work is starting now or entering executable WORKLIST `Active`                                      | confirm or set `assignees` when missing                                       |
| `Doing -> Reviewing`             | implementation/self-check complete; review is requested                                                                       | confirm `reviewers` when expected                                             |
| `Reviewing -> Done`              | delivery-review accepted; checks passed or skips documented; downstream dependency follow-up checked                          | do not clear `assignees` or `reviewers`; record approved follow-up separately |
| `Doing -> Blocked`               | active blocker prevents continued implementation                                                                              | linked task records blocker; propose `readiness: blocked`                     |
| `Reviewing -> Blocked`           | external blocker prevents review or completion                                                                                | linked task records blocker; propose `readiness: blocked`                     |
| `Blocked -> Ready`               | blocker resolved; task satisfies Ready Checklist; no one is actively handling it                                              | propose `readiness: ready` when approved                                      |
| `Blocked -> Doing`               | blocker resolved; same handler is continuing active work                                                                      | propose `readiness: ready` when approved                                      |
| `Blocked -> Backlog`             | blocker resolution exposes missing scope, source, design, or acceptance criteria                                              | propose `readiness: needs-refinement`                                         |
| `Any active column -> Cancelled` | maintainer approved cancellation reason                                                                                       | add or preserve cancellation/supersession context in task item when needed    |

If a requested transition is not listed, stop and ask for maintainer confirmation plus the intended source and target semantics.
