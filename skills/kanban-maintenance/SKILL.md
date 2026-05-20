---
name: kanban-maintenance
description: Use when the user has approved adding, moving, or updating cards on the repository Kanban board.
---

# Kanban Maintenance

## Runtime Context

Before acting, use the repository Knowledge Workflow runtime context from root `AGENTS.md` and its manifest; do not assume workflow paths or default ids.

Use this skill to apply approved changes to `<knowledge_dir>/planning/KANBAN.md`.

## Preconditions

- A maintainer has explicitly approved the Kanban change.
- The proposed card links to project knowledge or a task item.
- The card is not a duplicate of an active card.

## Workflow

1. Read `<knowledge_dir>/planning/WORKFLOW.md`.
2. Open `<knowledge_dir>/planning/KANBAN.md`.
3. Resolve card wikilinks to task items by task id or file basename.
4. Check the requested transition against the Move Matrix in `references/cards.md`.
5. Apply only the approved board changes.
6. Keep cards thin and linked.
7. Preserve the column order.
8. For `Reviewing -> Done`, report whether dependency follow-up was approved, deferred, or not applicable.
9. For new accepted tasks with planned dependencies, place cards in `Backlog` unless the approved dry run explicitly selects `Ready`.
10. Report exact cards moved, added, changed, or removed.

## Guardrails

- Do not edit unrelated cards.
- Do not use localized files as card sources.
- Do not duplicate acceptance criteria or long discussion in the board.
- Stop and report ambiguity if a card link can match multiple canonical files.
- When moving a card to `Blocked`, keep the board card thin and ensure blocker details live in the linked task item.
- Do not move a new dependent task to `Blocked` only because it has `blocked_by`; use `Backlog` plus task readiness metadata until the work was expected to proceed.
- Move out of `Blocked` only to the approved next state: `Ready` when no one is actively handling it, `Doing` when the current handler is continuing it, or `Backlog` when it still needs refinement.
- Do not move `Reviewing -> Done` while known dependency follow-up is unresolved unless the maintainer explicitly defers it.
- Stop if the requested change conflicts with the Kanban workflow.

## References

- For card and column examples, read `references/cards.md`.
