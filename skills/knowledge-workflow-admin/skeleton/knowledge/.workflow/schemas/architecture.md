---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - architecture
---

# Architecture Schema

Architecture documents describe system structure, module boundaries, data flow, integration behavior, and technical constraints.

## Frontmatter

```yaml
---
scope: project
type: architecture
owners: []
tags:
    - api
---
```

Allowed `type` values:

- `architecture`
- `technical-design`
- `integration`
- `data-flow`

## Body Template

- Context
- Goals
- Non-goals
- Current architecture
- Proposed architecture
- Interfaces and contracts
- Data flow
- Operational concerns
- Related decisions
- Related tasks

## Rules

- Capture durable technical knowledge, not transient delivery status.
- Link accepted decisions that constrain implementation.
- Update architecture documents when implementation changes durable technical behavior, module boundaries, interfaces, data flow, integration contracts, configuration, or operational constraints.
