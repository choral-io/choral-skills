---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - planning
    - sprint
---

# Sprints Schema

Sprint documents describe time-boxed planning, coordination, review, or retrospective context.

## Frontmatter

```yaml
---
scope: project
type: sprint
owners: []
assignees:
    - "[[members/Gavroche]]"
reviewers:
    - "[[members/Éponine]]"
tags:
    - planning
    - sprint
sprint: Sprint 1
start_date: 2026-04-01
end_date: 2026-04-14
related_to: []
---
```

## Rules

- Use `type: sprint`.
- Use sprint documents for goals, coordination notes, capacity assumptions, known risks, review summaries, and retrospective notes.
- Keep detailed task scope and acceptance criteria in task items.
- Keep current delivery status in `<knowledge_dir>/planning/KANBAN.md`.
