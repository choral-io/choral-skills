---
scope: project
type: process
owners: []
tags:
    - workspace
    - workflow
---

# Workspace Rules

This document defines member workspace, local-only execution, worklists, logs, handoffs, and worktree boundaries.

## Required Reads

- Before changing member-local execution state, read this document and `<knowledge_dir>/.workflow/schemas/workspace.md`.
- Before taking accepted delivery work into local execution, read `<knowledge_dir>/.workflow/rules/delivery.md`.
- When member context matters, resolve the current member id using `<knowledge_dir>/.workflow/runtime.md`.

## Member Workspace

`<knowledge_dir>/workspace/<member-id>/` is member-scoped context. It may contain shared summaries, handoffs, research, and local-only execution state under `local/`.

Stable member identity, responsibilities, focus areas, and public collaboration context belong in `<knowledge_dir>/members/<member-id>.md`, not in local workspace files.

Personal Agent collaboration preferences may live in local workspace instructions. Those instructions are local-only and must not override workflow runtime, rules, schemas, task acceptance criteria, safety, privacy, approval, local-only, or review rules.

## Local-Only State

Treat `<knowledge_dir>/workspace/<member-id>/local/` and worktree contents under `<worktrees_dir>/` as local-only state; never stage or commit them. The managed `<worktrees_dir>/.gitignore` may be tracked.

Local-only paths include:

- `workspace/<member-id>/local/WORKLIST.md`
- `workspace/<member-id>/local/logs/`
- `workspace/<member-id>/local/runs/`
- `workspace/<member-id>/local/scratch/`
- `workspace/<member-id>/local/drafts/`
- `<worktrees_dir>/shared/`
- `<worktrees_dir>/slot-XX/`

## Personal Execution

Use `workspace-worklist` when a member takes accepted work into local execution.

- `intake-task` writes only the current member's `local/WORKLIST.md` and local logs.
- Intake should preserve links to the card, task item, and important source knowledge.
- Move or propose the card to `Doing` through approved `kanban-maintenance` at intake time or before the item becomes `Active`.
- Do not create detailed local execution items if the developer is not actually starting the task.
- Use `run-goal` only for accepted Kanban/worklist tasks and a user-approved scope; default stop point is review readiness or approved `Doing -> Reviewing`.

## Handoffs

Create a formal shared handoff under `<knowledge_dir>/workspace/<member-id>/handoffs/` only when the handoff is cross-member, long-lived, complex enough to survive the chat, or explicitly requested. Use `<knowledge_dir>/.workflow/templates/handoff.md` as a reference template. Do not write into another member's workspace.

## Optional Superpowers Guidance

When Superpowers skills are available, use them only as optional execution-method support:

| Workflow need                                           | Optional Superpowers skill                                                   |
| ------------------------------------------------------- | ---------------------------------------------------------------------------- |
| shape unclear work                                      | `superpowers:brainstorming`                                                  |
| write implementation plan                               | `superpowers:writing-plans`                                                  |
| feature, bugfix, refactor, or behavior change           | `superpowers:test-driven-development`                                        |
| unclear failure                                         | `superpowers:systematic-debugging`                                           |
| verify completion, commit, PR, or Done-readiness claims | `superpowers:verification-before-completion`                                 |
| isolated or authorized parallel Agent execution         | `superpowers:using-git-worktrees`, `superpowers:subagent-driven-development` |

Knowledge Workflow remains authoritative for knowledge placement, task items, Kanban state, WORKLIST ownership, approval gates, and delivery review. Superpowers specs and plans are personal execution aids by default and should use `<knowledge_dir>/workspace/<member-id>/local/superpowers/specs/` or `<knowledge_dir>/workspace/<member-id>/local/superpowers/plans/` unless the user explicitly specifies another safe path. These paths do not replace `local/drafts/` for general structured personal drafts. Apply the Superpowers integration rules before writing or committing output. Superpowers worktrees must use runtime-resolved `<worktrees_dir>/`. Superpowers subagents cannot self-approve, change Kanban, write shared knowledge, commit local-only output, or promote local-only files. Verification-before-completion is evidence discipline; delivery review and Kanban gates remain authoritative.
