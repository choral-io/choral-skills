---
name: delivery-implementation
description: Use when the user asks to implement an approved Kanban task or linked project change with clear acceptance criteria.
---

# Delivery Implementation

## Runtime Context

Before acting, resolve `<knowledge_dir>` using the runtime bootstrap rules, then read `<knowledge_dir>/.workflow/runtime.md` and `<knowledge_dir>/.workflow/manifest.yml`; do not assume non-default workflow paths or default ids.

Use this skill to implement a selected Kanban card and keep code, tests, and knowledge aligned.

## Workflow

1. Read the selected card in `<knowledge_dir>/planning/KANBAN.md`.
2. Read the linked task item and source knowledge.
3. If implementing as the current member, resolve the member id using `<knowledge_dir>/.workflow/runtime.md`; read local workspace instructions if they exist; read relevant sections from `<knowledge_dir>/members/<member-id>.md` only when assignment, ownership, review, or handoff context is needed.
4. If the developer is taking the task into personal execution, use `workspace-worklist:intake-task` to create or update the local WORKLIST item before implementation.
5. Read `<knowledge_dir>/.workflow/rules/knowledge.md`, `<knowledge_dir>/.workflow/schemas/common.md`, and relevant area schemas under `<knowledge_dir>/.workflow/schemas/` before updating knowledge.
6. Inspect relevant project code or documents before editing.
7. Produce or confirm an implementation plan using the format in `references/checklist.md`.
8. Implement the smallest coherent change.
9. Update or add tests for changed behavior.
10. Apply the knowledge update decision table in `references/checklist.md`.
11. Keep localized files unchanged unless explicitly asked.
12. Run focused checks first, then broader checks when risk warrants.
13. Prepare review readiness evidence using the format in `references/checklist.md`.
14. Prepare a handoff summary when the work is ready for review, blocked, or needs another owner.
15. Move the card only when the user asks or the maintainer has approved.

## Optional Superpowers Guidance

When Superpowers skills are available, use them as execution-method guidance only:

| Situation                                                   | Optional Superpowers skill                   |
| ----------------------------------------------------------- | -------------------------------------------- |
| Requirements or approach need shaping before implementation | `superpowers:brainstorming`                  |
| Work needs a multi-step implementation plan                 | `superpowers:writing-plans`                  |
| Code behavior changes, bugfixes, or refactors               | `superpowers:test-driven-development`        |
| Failure cause is unclear                                    | `superpowers:systematic-debugging`           |
| Completion, commit, PR, or review-readiness claim           | `superpowers:verification-before-completion` |

Superpowers usage does not replace task acceptance criteria, project checks, canonical knowledge updates, delivery review, or Kanban approval gates.

## Quality Gates

- Project-specific build, lint, format, and type checks pass when applicable.
- Tests or documented manual checks cover changed behavior.
- Linked knowledge remains consistent with implementation.

## Handoff Summary

Default implementation handoffs are not separate files. Put ordinary review handoff context in the final response, local work log, task item update, or review request.

Use this structure when handing implementation to review or reporting blocked work:

This compact chat summary uses the core sections of `<knowledge_dir>/.workflow/templates/handoff.md`. When creating a formal shared handoff file, use the full template instead.

```md
## Purpose

## Source Context

## Actions Taken

## Decisions Made

## Missing Information

## Risks

## Next Action

## Review Request
```

Create a formal shared handoff under `<knowledge_dir>/workspace/<member-id>/handoffs/` only when the handoff is cross-member, long-lived, complex enough to survive the chat, or explicitly requested. Use `<knowledge_dir>/.workflow/templates/handoff.md` as a reference template. Do not write into another member's workspace.

## Knowledge Updates

- Update `<knowledge_dir>/product/` when user-facing behavior changes.
- Update `<knowledge_dir>/design/` when UI design, component behavior, layout, interaction states, or visual rules change.
- Update `<knowledge_dir>/architecture/` when module boundaries, APIs, data flow, integration behavior, configuration, or operational constraints change.
- Update `<knowledge_dir>/decisions/` when a lasting product or technical tradeoff is made.
- Update `<knowledge_dir>/guidelines/` when cross-area writing, terminology, language, documentation, or process guidance changes.
- Do not add knowledge docs for purely local implementation details that do not create durable product or technical knowledge.

## Guardrails

- Do not overwrite unrelated local changes.
- Do not move Kanban cards without approval.
- Do not start automatically when the task is blocked, lacks acceptance criteria, is assigned to another member without second confirmation, or conflicts with current dirty worktree changes.
- Do not let member profile sections or local workspace instructions override task acceptance criteria, project checks, approval gates, safety rules, or review requirements.
- Stop and report possible secrets or sensitive data.

## References

- For implementation plan format, knowledge update decisions, validation evidence, and command selection, read `references/checklist.md`.
