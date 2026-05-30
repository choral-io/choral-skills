---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - product
---

# Product Schema

Product documents define product intent, requirements, user-facing behavior, product-level prototypes, user journeys, and information architecture.

## Frontmatter

```yaml
---
scope: project
type: product
owners: []
tags:
    - product
---
```

Allowed `type` values:

- `product`
- `product-brief`
- `user-flow`
- `prototype`

## Body Template

Use sections that fit the document:

- Goal
- Users
- User journey
- Behavior
- In scope
- Out of scope
- Related design
- Related tasks
- Open questions

## Rules

- Store product-level prototypes, user flows, and information architecture in `<knowledge_dir>/product/`.
- Store requirement discovery, market and business analysis, customer context, environmental research, opportunity framing, and assumptions in `<knowledge_dir>/discovery/`.
- Store implementation-facing UI design in `<knowledge_dir>/design/`.
- Link related task items instead of duplicating delivery status.
