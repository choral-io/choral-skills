---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - design
---

# Design Schema

Design documents define UI visual design, component behavior, screen composition, responsive layout, and design system guidance.

## Frontmatter

```yaml
---
scope: project
type: design
owners: []
assignees:
    - "[[members/Gavroche]]"
reviewers:
    - "[[members/Éponine]]"
tags:
    - ui
    - design
---
```

Allowed `type` values:

- `design`
- `ui-spec`
- `component-guideline`
- `design-system`

## Body Template

Use sections that fit the document:

- Purpose
- Related product document
- Screens or states
- Layout
- Components
- Interaction states
- Responsive behavior
- Accessibility notes
- Assets
- Related tasks

## Rules

- Use `assignees` when a design document is actively being developed.
- Use `reviewers` when design review is needed before implementation.
- Remove stale `assignees` when the design becomes accepted reference knowledge.
- Use `<knowledge_dir>/product/` for product intent, user journeys, feature behavior, information architecture, and product-level prototypes.
- Use `<knowledge_dir>/design/` for visual design, component behavior, screen composition, responsive layout, and implementation-facing UI guidance.

## Assets

Store screenshots, sketches, exported mockups, Figma exports, and reference images under a typed asset directory:

```text
<knowledge_dir>/assets/<asset-type>/<topic>/
```

Store design assets under `<knowledge_dir>/assets/<asset-type>/<topic>/`, choosing an asset type such as `design`, `image`, or `export` to match the content. Link assets from Markdown instead of leaving them at the repository root.
