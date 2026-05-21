---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - concepts
---

# Concepts Schema

Concept documents define reusable project terms, domain concepts, and shared vocabulary.

## Frontmatter

```yaml
---
scope: project
type: concept
owners: []
tags:
    - agent
---
```

Allowed `type` values:

- `concept`
- `term`
- `glossary`

## Body Template

- Definition
- Context
- Related concepts
- Related product or architecture documents

## Rules

- Keep concepts stable and reusable.
- Do not use concept files as delivery status mirrors.
- Promote implementation-impacting conclusions to decisions when needed.
