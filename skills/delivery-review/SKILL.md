---
name: delivery-review
description: Use when delivery work needs review, a PR or local diff needs validation, or Done readiness is in question.
---

# Delivery Review

## Runtime Context

Before acting, use the repository Knowledge Workflow runtime context from root `AGENTS.md` and its manifest; do not assume workflow paths or default ids.

Use this skill to independently review delivery work after implementation and before completion. Review normally happens while the Kanban card is in `Reviewing`.

## Workflow

1. Read the selected card in `<knowledge_dir>/planning/KANBAN.md`.
2. Read the linked task item and source knowledge.
3. Read `<knowledge_dir>/.workflow/rules/knowledge.md`, `<knowledge_dir>/.workflow/schemas/common.md`, and relevant area schemas under `<knowledge_dir>/.workflow/schemas/` for changed knowledge.
4. Inspect the local diff or pull request changes.
5. Compare implementation against acceptance criteria, out-of-scope notes, and related decisions.
6. Check that tests cover meaningful behavior changes.
7. When reviewer assignment, handoff expectations, or member responsibilities matter, read only the relevant sections from `<knowledge_dir>/members/<member-id>.md`.
8. Check that canonical knowledge was updated when product, architecture, configuration, or decisions changed.
9. Run focused checks when practical, or report which checks were not run.
10. Report findings first, ordered by severity.
11. Say clearly whether the work is accepted, needs changes, or is blocked.
12. Include a handoff summary when the review returns work, blocks completion, or asks another owner to continue.

## Optional Superpowers Evidence

When available, `superpowers:verification-before-completion` output can be used as validation evidence. Still inspect the diff, tests, acceptance criteria, and knowledge updates directly; Superpowers evidence supports delivery review but does not replace it.

## Kanban State

- Preferred flow: implementation complete -> approved `Doing` to `Reviewing` move -> `delivery-review` -> approved `Reviewing` to `Done` move.
- If the card is still in `Doing`, this skill may run a pre-review, but pre-review does not replace the `Reviewing -> Done` acceptance gate.
- If review result is `minor-fix`, recommend keeping the card in `Reviewing` while fixes are applied.
- If review result is `rework-required`, recommend moving the card back to `Doing` through `kanban-maintenance`.
- If review finds an unresolved external blocker, recommend moving the card to `Blocked` and recording blocker details in the linked task item.
- Before recommending `Reviewing -> Done`, reverse-look up downstream tasks whose `blocked_by` entries reference the completed task and check whether they require readiness or Kanban follow-up proposals.

## Handoff Summary

Default review handoffs are not separate files. Put ordinary return-to-implementation or acceptance context in the review report, local work log, task item update, or Kanban maintenance request.

Create a formal shared handoff under `<knowledge_dir>/workspace/<member-id>/handoffs/` only when the review handoff is cross-member, long-lived, complex enough to survive the chat, or explicitly requested. Use `<knowledge_dir>/.workflow/templates/handoff.md` as a reference template. Do not write into another member's workspace.

## Guardrails

- Do not move the Kanban card unless the maintainer explicitly asks.
- Do not fix implementation issues during review unless explicitly asked.
- Do not use localized files as acceptance sources.
- Do not read member `local/AGENTS.md` for objective delivery acceptance.
- Treat workflow, schema, AGENTS, Skill, security, data handling, cross-package API, user-visible behavior, broad refactor, and failed-worker follow-up changes as review-required.
- Stop and report possible secrets or sensitive data.
- Keep review comments tied to concrete files, task criteria, or knowledge documents.

## References

- For acceptance checks, result classification, handoff structure, and output details, read `references/checklist.md`.
