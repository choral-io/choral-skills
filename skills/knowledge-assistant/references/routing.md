# Routing

Use this when the user asks which Skill owns a request, what to do next, or how to phrase the next prompt.

## Quick Router

Check that the recommended Skill is loadable by the current Agent before saying it is available. If a required Skill is missing, route installation to the Agent runtime's Skill installation mechanism rather than repository-local copies.

| User asks about                                                                                     | Recommend                                                  | Boundary                                                                                                                      |
| --------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Workflow usage or onboarding                                                                        | `knowledge-assistant`                                      | Explain only.                                                                                                                 |
| New installation                                                                                    | `knowledge-workflow-admin:init`                            | Ask for canonical language; dry-run first.                                                                                    |
| Project-specific rules                                                                              | `knowledge-assistant`                                      | Explain or audit read-only; writes require maintainer config workflow.                                                        |
| Explicit request to record workflow friction or improvement feedback                                | `knowledge-assistant`                                      | Explicit-only; explain privacy and local-only behavior first; if disabled, confirm enablement before routing manifest update. |
| Auto-review rules setup                                                                             | `knowledge-workflow-admin:config`                          | Only needed when the team wants repeatable auto-review automation.                                                            |
| Where information belongs                                                                           | `knowledge-intake`                                         | Write only after capture approval.                                                                                            |
| Approved knowledge write or promotion                                                               | `knowledge-capture`                                        | Use schemas before writing.                                                                                                   |
| Add a project member                                                                                | `knowledge-capture`                                        | Confirm member id, public profile, and group membership updates.                                                              |
| Add a group, team, board, or working group                                                          | `knowledge-capture`                                        | Confirm group id, scope, owners, and members.                                                                                 |
| Non-task knowledge quality                                                                          | `knowledge-schema-audit`                                   | Read-only findings.                                                                                                           |
| Task metadata or readiness                                                                          | `task-metadata-audit`                                      | Read-only findings.                                                                                                           |
| Project, delivery, decisions, or risk status                                                        | `knowledge-status-report`                                  | Read-only report with sources.                                                                                                |
| Weekly delivery, knowledge health, proposal/decision queue, member workload, or blocked work report | `knowledge-status-report`                                  | Use the matching predefined report template.                                                                                  |
| Delivery planning                                                                                   | `delivery-planning`                                        | Dry-run Kanban changes only.                                                                                                  |
| Sprint planning document                                                                            | `knowledge-capture`                                        | Store in `planning/sprints/`; use delivery-planning for board changes.                                                        |
| Schema, guideline, or workflow rule change                                                          | `knowledge-capture`                                        | Shared workflow knowledge; audit first when impact is unclear.                                                                |
| Pick next accepted task                                                                             | `next-task-selection`                                      | Recommend; do not start by default.                                                                                           |
| Approved board edit                                                                                 | `kanban-maintenance`                                       | Requires explicit maintainer approval.                                                                                        |
| Take a card into personal work                                                                      | `workspace-worklist:intake-task`                           | Current member local workspace only.                                                                                          |
| Continue one local item                                                                             | `workspace-worklist:run-next`                              | One executable item.                                                                                                          |
| Run several local items                                                                             | `workspace-worklist:run-loop`                              | Needs explicit budget; parallel needs budget.                                                                                 |
| Advance accepted tasks toward review                                                                | `workspace-worklist:run-goal`                              | Stop at review readiness by default.                                                                                          |
| Implement selected delivery work                                                                    | `delivery-implementation`                                  | Code, tests, and knowledge together.                                                                                          |
| Review before Done                                                                                  | `delivery-review`                                          | Required before Done when delivery changed.                                                                                   |
| Scope or source conflict                                                                            | `knowledge-assistant`, then owning skill after user choice | Report conflicts; do not silently choose.                                                                                     |
| Stuck, failed, obsolete, or unclear current work                                                    | `knowledge-assistant`, then owning skill after diagnosis   | Diagnose state first; do not retry, move cards, or rewrite facts yet.                                                         |

## Core Flow

Use this compact flow when explaining idea-to-delivery:

```text
raw/local note
-> knowledge-intake
-> optional proposal
-> canonical knowledge or task item
-> task-metadata-audit
-> delivery-planning dry run
-> approved kanban-maintenance
-> workspace-worklist intake/execution
-> delivery-implementation
-> delivery-review
-> approved Done move
```

Do not skip conversion steps: proposals are not facts, loose task items are not accepted work, and Kanban edits need explicit approval.

## Optional Superpowers Guidance

Recommend Superpowers only as execution-method support when available. It is not a managed workflow dependency, manifest state, or replacement for Knowledge Workflow ownership.

| Workflow need                                                 | Optional Superpowers skill                                                   |
| ------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| Shape unclear feature, product, design, or implementation     | `superpowers:brainstorming`                                                  |
| Write a multi-step implementation plan                        | `superpowers:writing-plans`                                                  |
| Implement feature, bugfix, refactor, or behavior change       | `superpowers:test-driven-development`                                        |
| Investigate a bug or unclear failure                          | `superpowers:systematic-debugging`                                           |
| Verify before completion, commit, PR, or Done-readiness claim | `superpowers:verification-before-completion`                                 |
| Isolate work or run authorized parallel Agents                | `superpowers:using-git-worktrees`, `superpowers:subagent-driven-development` |

Knowledge Workflow still owns knowledge placement, task items, Kanban state, WORKLIST routing, approval gates, and delivery review. Put personal Superpowers plans under `<knowledge_dir>/workspace/<member-id>/local/drafts/` unless the user approves promotion to task items or proposals.
