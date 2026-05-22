---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - planning
---

# Planning Schema

Planning documents describe workflow, roadmap, sprint planning, sprint summaries, and delivery coordination.

## Frontmatter

```yaml
---
scope: project
type: process
owners: []
assignees:
    - "[[members/Gavroche]]"
reviewers:
    - "[[members/Éponine]]"
tags:
    - planning
---
```

Allowed `type` values:

- `process`
- `roadmap`
- `sprint`
- `kanban`
- `migration`

## Rules

- Keep delivery status centralized in `<knowledge_dir>/planning/KANBAN.md`.
- Use task items for durable task context.
- Keep process documents focused on rules that Agents and members can follow.
- Use `assignees` for active planning ownership, such as sprint planning or migration work.
- Use `reviewers` when a planning document needs explicit review before acceptance.

## Kanban Columns

Use this column order for `type: kanban`:

1. `Backlog`
2. `Ready`
3. `Doing`
4. `Reviewing`
5. `Blocked`
6. `Done`
7. `Cancelled`
