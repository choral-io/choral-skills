---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - discovery
---

# Discovery Schema

Discovery documents capture requirement discovery, market and business research, customer context, competitive analysis, environmental analysis, opportunity framing, and assumptions that inform product requirements and decisions.

## Frontmatter

```yaml
---
scope: project
type: market-analysis
owners: []
tags:
    - discovery
---
```

Allowed `type` values:

- `market-analysis`
- `industry-analysis`
- `competitor-analysis`
- `customer-segment`
- `user-research`
- `environment-analysis`
- `opportunity-assessment`
- `business-assumption`
- `problem-framing`

## Body Template

Use sections that fit the document:

- Purpose
- Sources
- Context
- Observations
- Assumptions
- Implications
- Related product
- Related decisions
- Open questions

## Rules

- Store discovery evidence, business analysis, market context, environmental research, and opportunity framing in `<knowledge_dir>/discovery/`.
- Store product intent, requirements, user journeys, and feature behavior in `<knowledge_dir>/product/`.
- Store accepted tradeoffs or commitments in `<knowledge_dir>/decisions/`.
- Store raw or personal research in `<knowledge_dir>/workspace/<member-id>/research/` until it is promoted into shared discovery knowledge.
- Keep public facts, field observations, and project-specific inferences clearly separated when possible.
- Link discovery documents from product requirements or decisions that depend on them.
