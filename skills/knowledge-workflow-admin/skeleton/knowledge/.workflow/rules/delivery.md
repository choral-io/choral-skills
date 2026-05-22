---
scope: project
type: process
owners: []
tags:
    - delivery
    - workflow
    - kanban
---

# Delivery Rules

This document defines task, readiness, Kanban, implementation, review, blocked, and Done rules.

The default workflow assumes a software product development loop across product, design, architecture, task delivery, implementation review, and accumulated project experience.

## Required Reads

- Before changing delivery cards, read this document and `<knowledge_dir>/.workflow/schemas/tasks.md`.
- Before updating durable knowledge during delivery, read `<knowledge_dir>/.workflow/rules/knowledge.md`.
- Before using member-local execution state, read `<knowledge_dir>/.workflow/rules/workspace.md`.
- Resolve the current member id using `<knowledge_dir>/.workflow/runtime.md`.

## Operating Model

```text
member workspace -> project knowledge -> task item -> Kanban -> implementation -> review -> updated knowledge
```

| Area                  | Source of truth                             | Notes                                            |
| --------------------- | ------------------------------------------- | ------------------------------------------------ |
| Project facts         | `<knowledge_dir>/` canonical files and code | Canonical-language files are authoritative.      |
| Personal work context | `<knowledge_dir>/workspace/<member-id>/`    | Context, not team consensus.                     |
| Delivery status       | `<knowledge_dir>/planning/KANBAN.md`        | Board edits require approved Kanban maintenance. |
| Task context          | `<knowledge_dir>/tasks/*.md`                | Kanban cards should link to task items.          |
| Workflow rules        | `<knowledge_dir>/.workflow/rules/*.md`      | Operational rules, not project facts.            |

## Flow

1. Route durable material through `knowledge-intake`; write only approved shared or canonical updates through `knowledge-capture`.
2. Shape delivery candidates as task items with clear sources, scope, acceptance criteria, readiness, and ownership metadata.
3. Use `delivery-planning` for dry-run board proposals and `kanban-maintenance` only after explicit approval.
4. Use `next-task-selection` for accepted Kanban cards; loose task items are planning candidates, not selected work.
5. Use `workspace-worklist` when a member takes accepted work into local execution.
6. Use `delivery-implementation` for code, tests, and required knowledge updates.
7. Use `delivery-review` before `Done` when implementation, acceptance criteria, source knowledge, or checks changed.

## Task Items

Task items live directly under `<knowledge_dir>/tasks/` and follow `<knowledge_dir>/.workflow/schemas/tasks.md`.

Use task items for durable delivery context:

- goal, sources, scope, and non-goals;
- acceptance criteria;
- implementation notes, risks, and open questions;
- priority, value, effort, module, readiness, ownership, assignment, review, blockers, and relationships.

Allowed planning inputs:

```text
<knowledge_dir>/discovery/**
<knowledge_dir>/product/**
<knowledge_dir>/design/**
<knowledge_dir>/concepts/**
<knowledge_dir>/architecture/**
<knowledge_dir>/decisions/**
<knowledge_dir>/guidelines/**
<knowledge_dir>/planning/**
<knowledge_dir>/tasks/*.md
<knowledge_dir>/workspace/*/{summaries,handoffs,research}/** only when selected
```

Do not plan from `.workflow/**`, `.feedback/**`, `workspace/*/local/**`, localized files, raw personal notes, secrets, or private material.

Use `blocked_by` and `related_to` with task wikilinks instead of a generic dependency field when the relationship is known. Tool-written values should prefer path-qualified wikilinks such as `[[tasks/example-task]]`; manual short task wikilinks are valid only when they resolve uniquely. A missing or unclear blocker is a metadata issue; do not silently ignore it.

## Readiness

Use `readiness: needs-refinement` for vague or incomplete task items. Use `readiness: blocked` when a blocker, decision, external condition, or required access prevents work.

Use `readiness: ready` only when the task satisfies the Ready Checklist in `<knowledge_dir>/.workflow/schemas/tasks.md`. In summary:

- `## Goal`, `## Sources`, `## In scope`, `## Out of scope`, and `## Acceptance criteria` sections are present;
- acceptance criteria are observable pass/fail criteria;
- source links point to stable product, design, architecture, decision, planning, task, or asset context;
- issue, bug, or defect tasks include required issue sections;
- no unresolved `blocked_by` entries;
- `owners` is non-empty and every owner resolves to an existing member or group;
- `module`, `effort`, `priority`, and `value` are present;
- required source material is committed, and pushed to the default remote when one exists;
- execution does not depend on local-only, localized-only, secret, or private context.

Readiness is not delivery status:

- `readiness: needs-refinement` belongs in `Backlog`, not `Ready`, unless a maintainer explicitly keeps the card elsewhere for cleanup.
- `readiness: ready` can appear in `Backlog` or `Ready`; `Ready` is the default candidate pool.
- `readiness: blocked` can appear in `Backlog` when the blocker is a planned dependency for work that has not entered the delivery flow.
- `Blocked` is a Kanban column for work that was expected to proceed or already started, but cannot continue because the blocker is currently active.
- `Done` and `Cancelled` do not require changing `readiness`; Kanban records completion or cancellation.

Agents may propose readiness changes in dry-run output. Writing `readiness: ready` should happen only after maintainer approval or as part of an approved metadata dry run.

## Kanban

- `<knowledge_dir>/planning/KANBAN.md` tracks delivery status.
- Board movement requires explicit approved `kanban-maintenance`.
- `Backlog` and `Ready` are candidate pools; `Doing`, `Reviewing`, `Blocked`, `Done`, and `Cancelled` have explicit state meaning here.
- `Done` requires delivered work, relevant checks or documented skips, updated durable knowledge when needed, local execution closure, delivery review acceptance, and approved board movement.

Cards stay thin and link to task items:

```md
- [ ] [[tasks/example-delivery-task|Example delivery task]]
```

The linked task item holds context and acceptance criteria. Prefer path-qualified task wikilinks in tool-written links and metadata. If a short manual link is ambiguous, report it instead of guessing.

Kanban and task metadata must stay coherent:

- Moving `Ready -> Doing` confirms or sets `assignees` when the current handler is known.
- Moving to `Reviewing` confirms `reviewers` when review responsibility is expected.
- Planned dependencies recorded in `blocked_by` do not automatically require the card to be in `Blocked`; newly accepted dependent tasks remain in `Backlog` until selected for near-term execution.
- A card in `Ready` must not have unresolved `blocked_by` entries or `readiness: blocked`.
- Move to `Blocked` only when work that was expected to proceed or already started cannot continue; record the active blocker in the linked task item.
- Do not clear `assignees` or `reviewers` just because the task is `Done`; update them only when responsibility changes or metadata was wrong.
- Do not use `assignees`, `reviewers`, or `readiness` as substitutes for Kanban status.

## Planning And Selection

Create or update a Kanban card only when the linked task item has `## Goal`, `## Sources`, `## In scope`, `## Out of scope`, and `## Acceptance criteria`, valid non-empty `owners`, plus no local-only source dependency.

When a requirement is decomposed into several accepted tasks with planned dependency order, add the dependent tasks to `Backlog` unless one is ready for immediate execution. Use `blocked_by` and `readiness: blocked` to express unresolved planned dependencies; reserve the `Blocked` column for tasks that stall after entering or approaching active delivery.

Before any Kanban write, produce a dry-run table and wait for explicit approval:

| Title                 | Sources                                          | Module | Priority | Sprint   | Owners                 | Blockers | Target |
| --------------------- | ------------------------------------------------ | ------ | -------- | -------- | ---------------------- | -------- | ------ |
| Example delivery task | `<knowledge_dir>/tasks/example-delivery-task.md` | app    | P1       | Sprint 1 | `[[members/Gavroche]]` | None     | Ready  |

Use `next-task-selection` to recommend accepted Kanban cards. Selection is read-only by default:

- select only cards from the board, not loose task items;
- require linked Ready or active tasks to have non-empty owners that resolve to existing member or group documents;
- prefer assigned current-member tasks, then unassigned tasks;
- starting another member's assigned task requires a second explicit confirmation;
- exclude unresolved blockers and non-ready tasks from automatic start;
- before automatic start or `Doing`, verify readiness, acceptance criteria, committed source material, remote freshness when relevant, clean worktree fit, and approval level.

## Delivery Updates

Review order:

1. Move or propose `Doing -> Reviewing` through approved `kanban-maintenance`.
2. Run `delivery-review` while the card is in `Reviewing`.
3. If accepted, check downstream dependency follow-up needs, then move or propose `Reviewing -> Done` through approved `kanban-maintenance`.
4. Keep the card in `Reviewing` for `minor-fix`, move back to `Doing` for `rework-required`, move to `Blocked` for unresolved external blockers, or move to `Cancelled` when the task should not continue.

Definition of Done:

- acceptance criteria are satisfied or explicitly revised;
- implementation, documentation, and tests are complete for the scope;
- focused validation passed, or skipped checks are documented with a reason;
- required review is complete or residual risk is accepted by the maintainer;
- durable product, discovery, design, architecture, decision, guideline, or task knowledge was updated when the work changed it;
- downstream task readiness and Kanban follow-up were checked for tasks that reference this task in `blocked_by`;
- local WORKLIST item and local log are closed;
- approved Kanban maintenance moved the card to `Done`.

Done tasks may still receive metadata, link, or wording cleanup, but do not silently change delivered scope after completion. If new work is discovered after Done, create a follow-up task or proposal unless the maintainer explicitly reopens or revises the original task.

When a task reaches `Done`, scan task items for downstream tasks whose `blocked_by` entries reference the completed task before closing the delivery update.

Do not mechanically remove resolved `blocked_by` entries. They record dependency history and let Agents derive downstream unlocks by reverse lookup.

When available, `superpowers:verification-before-completion` may support validation before completion, commit, PR, or Done-readiness claims. It does not replace `delivery-review` or approved Kanban maintenance.

## Knowledge Updates During Delivery

Update durable knowledge when delivery changes it:

- user-facing behavior -> `product/`
- market, customer, competitor, business, or assumptions -> `discovery/`
- UI, interaction, layout, visual, or design system behavior -> `design/`
- module boundaries, APIs, data flow, integrations, configuration, or operations -> `architecture/`
- lasting product or technical tradeoff -> `decisions/`
- cross-area writing, terminology, language, documentation, or process -> `guidelines/`

No knowledge update is required for purely local implementation details that create no durable product or technical knowledge.

## Review Triggers

Use `delivery-review` before Done for:

- workflow, schema, or Skill changes;
- authentication, authorization, security, privacy, or data handling changes;
- cross-package interfaces, public APIs, persistence schemas, or migration behavior;
- user-visible product behavior or UI interaction changes;
- large refactors, broad file movement, or changes touching multiple modules;
- worker output after a failed or out-of-scope attempt;
- changed source knowledge after implementation.

## Blocked Or Cancelled Work

When blocked, move or propose the card to `Blocked`, set or propose `readiness: blocked`, and record the blocker in the linked task item.

Do not move a newly planned dependent task to `Blocked` just because it has `blocked_by`. Keep it in `Backlog` until it is selected for near-term execution or was expected to proceed.

Move out of `Blocked` only when the blocker is resolved and the next state is clear:

- use `Blocked -> Ready` when the task satisfies readiness criteria and is not actively being handled;
- use `Blocked -> Doing` when the task was already in progress and the current handler is ready to continue;
- use `Blocked -> Backlog` with `readiness: needs-refinement` when blocker removal exposes missing scope, sources, design, or acceptance criteria.

When cancelled, move or propose the card to `Cancelled` and add a short cancellation reason if context would otherwise be unclear. Do not delete source knowledge unless it is wrong or obsolete and the user approves correction.

`Cancelled` means intentionally dropped, replaced, duplicated, invalid, or no longer valuable. It is not `Done` and should not be treated as delivered. When a task is superseded, link the replacement task, proposal, or decision with `related_to`.
