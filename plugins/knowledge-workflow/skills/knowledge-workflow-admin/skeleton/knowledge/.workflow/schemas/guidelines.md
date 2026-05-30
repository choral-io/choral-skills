---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - guidelines
---

# Guidelines Schema

Guideline documents define cross-area writing, terminology, language, documentation, and process guidance for the knowledge base.

## Frontmatter

```yaml
---
scope: project
type: guideline
owners: []
tags:
    - knowledge
    - documentation
---
```

Allowed `type` values:

- `guideline`
- `terminology`
- `documentation`
- `process-guideline`

## Body Template

Use sections that fit the document:

- Purpose
- Scope
- Core rules
- Examples
- Avoid
- Related knowledge

## Rules

- Use `guidelines/` for rules that apply across multiple knowledge areas.
- Keep durable workflow mechanics in `.workflow/rules/delivery.md` when they define delivery process gates.
- Keep area-specific writing contracts in `.workflow/schemas/`.
- Keep product, design, architecture, concept, decision, and task facts in their owning areas.
- Link to the relevant schema or workflow document when a guideline explains how to apply an existing rule.
