# Recovery

Use this when the user asks what to do after a workflow stalls, fails, becomes stale, or appears inconsistent.

Start by identifying the state boundary:

| Situation                                               | First response                                                                  | Next owner after diagnosis                                                    |
| ------------------------------------------------------- | ------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| WORKLIST item may be obsolete, already done, or unclear | Validate against current knowledge, Kanban, git state, and linked sources.      | `workspace-worklist:groom`, `run-next`, or `knowledge-capture` after approval |
| Local execution failed or partially completed           | Classify as `needs-user`, `blocked`, `out-of-scope`, `failed`, or warning.      | `workspace-worklist:log`, `delivery-implementation`, or `delivery-review`     |
| Kanban card appears in the wrong column                 | Compare card state, linked task metadata, blockers, and review evidence.        | `task-metadata-audit` then approved maintenance                               |
| Task readiness conflicts with current facts             | Audit `readiness`, `blocked_by`, Sources, acceptance criteria, and board state. | `task-metadata-audit`; write fixes only after route                           |
| Proposal, decision, or requirement seems superseded     | Treat the newer source as a candidate update, not an automatic replacement.     | `knowledge-intake` or `knowledge-capture`                                     |
| Handoff is missing context or no longer actionable      | Ask for the missing receiver, source task, current state, and expected action.  | `knowledge-capture` for shared handoff update                                 |
| Auto-review or run-goal rules are missing during a run  | Continue only under conservative low-risk boundaries or ask for confirmation.   | `knowledge-workflow-admin:config` if reusable rules are wanted                |
| Required skill, manifest, or workflow file is missing   | Report the missing runtime context; do not guess paths as facts.                | `knowledge-assistant` or `knowledge-workflow-admin:check`                     |

Recovery answer shape:

1. State what is known and which source proves it.
2. State what is uncertain or conflicting.
3. Pick the narrowest safe next skill.
4. Name the actions that should not happen yet.
5. Give a concrete next prompt.

Do not hide recovery work inside normal execution. If the recovery changes shared facts, task metadata, Kanban state, another member's handoff, or project rules, switch to the owning skill and require the same approval gate as a normal change.
