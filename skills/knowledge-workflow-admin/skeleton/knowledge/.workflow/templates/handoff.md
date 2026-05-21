---
scope: member
type: handoff
owners:
    - "[[members/Gavroche]]"
assignees:
    - "[[members/Éponine]]"
reviewers: []
tags:
    - workspace
    - handoff
---

<!--
Use this template for durable shared handoffs under:

{{knowledge_dir}}/workspace/<from-member-id>/handoffs/<short-topic>.md

This is a lightweight reference template, not a lifecycle system.

The frontmatter above uses only the common workspace document fields from
{{knowledge_dir}}/.workflow/schemas/workspace.md.

Field notes:
- owners: member wikilinks for people responsible for maintaining this handoff document.
- assignees: member wikilinks for expected current handlers when known; leave empty for team or pool handoffs.
- reviewers: member wikilinks for expected reviewers when review is part of the handoff.

Do not use handoff metadata as a replacement for a task item, Kanban status,
or the receiving member's personal WORKLIST.md.

If a handoff needs lightweight routing hints, prefer writing them in Source
Context or Next Action. If the project explicitly accepts extra frontmatter,
these optional fields are common candidates:

from: "[[members/Gavroche]]"
to:
    - "[[members/Éponine]]"
handoff_status: open
related_task:
related_kanban:
-->

# Handoff Title

## Purpose

Explain why this handoff exists and who should continue from it.

## Source Context

Link the task item, Kanban card, source knowledge, worklist item, log entry, or other context needed to continue.

## Materials

- Link or list relevant files, artifacts, branches, screenshots, reports, or notes.

## Actions Taken

- Summarize completed work.

## Decisions Made

- Capture decisions that affect the next handler.

## Missing Information

- List unresolved questions, missing access, unavailable sources, or unclear scope.

## Risks

- List risks, sensitive areas, assumptions, or review concerns.

## Next Action

- State the next concrete action the receiver should take.

## Acceptance Criteria

- Describe what would make this handoff complete or ready to close.

## Response

- Receiver notes, acceptance, decline reason, or follow-up links.
