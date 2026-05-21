---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - decisions
---

# Decisions Schema

Decision documents capture accepted product or technical decisions that should guide future work.

## Frontmatter

```yaml
---
scope: project
type: decision
owners: []
reviewers:
    - "[[members/Éponine]]"
tags:
    - architecture
supersedes: []
superseded_by: []
---
```

Allowed `type` values:

- `decision`
- `adr`

## Body Template

- Context
- Decision
- Consequences
- Alternatives considered
- Related knowledge
- Related tasks

## Rules

- Use `reviewers` while a decision is being reviewed.
- Use `supersedes` and `superseded_by` when decisions replace each other.
- Do not change accepted decisions silently; add a new decision when the direction changes materially.
