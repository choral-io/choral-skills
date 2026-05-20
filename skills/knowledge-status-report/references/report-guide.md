# Report Guide

Start here for report metric basis, scope, reliability, and output shape. Load narrower references only when needed.

## Reference Router

| Need                                      | Reference                                 |
| ----------------------------------------- | ----------------------------------------- |
| metric basis, scope, reliability, counts  | `references/report-metrics.md`            |
| weekly, health, queue, workload templates | `references/report-templates.md`          |
| reportable areas, risk lists, examples    | `references/report-areas-and-examples.md` |

## Metric Basis

Label each reported metric by how it was derived:

| Basis         | Meaning                                                        |
| ------------- | -------------------------------------------------------------- |
| `field-based` | Counted from explicit frontmatter or schema-defined fields.    |
| `board-based` | Counted from `planning/KANBAN.md` columns or linked cards.     |
| `git-based`   | Counted from committed file history or recent changed files.   |
| `inferred`    | Estimated from prose, links, headings, or partial conventions. |

Prefer `field-based` and `board-based` metrics. Use `inferred` only when the user needs a directional report and the limitation is clearly stated.

## Scope

Use the narrowest useful scope:

| Scope             | Use when                                                                               |
| ----------------- | -------------------------------------------------------------------------------------- |
| `project-wide`    | The user asks broadly how the project or knowledge base is doing.                      |
| `discovery-only`  | The user asks about research, analysis, assumptions, opportunities, or market context. |
| `delivery-only`   | The user asks about Kanban, tasks, blockers, review, or Done work.                     |
| `product-only`    | The user asks about requirements, product scope, or delivered product behavior.        |
| `member-specific` | The user names a member, assignee, reviewer, owner, or handoff recipient.              |
| `sprint-specific` | The user names a sprint, milestone, planning period, or date-bounded delivery window.  |
| `module-specific` | The user names a module, component, feature area, or knowledge area.                   |

Default to `project-wide` only when the user does not imply a narrower scope.

For non-standard statistics, keep the nearest scope and add a filter or facet:

| Request                              | Scope             | Filter or facet                             |
| ------------------------------------ | ----------------- | ------------------------------------------- |
| "design resource status"             | `project-wide`    | `knowledge-area: design`                    |
| "architecture debt"                  | `project-wide`    | `risk-area: architecture`                   |
| "handoff items"                      | `project-wide`    | `workspace-area: handoffs`                  |
| "open proposals"                     | `project-wide`    | `proposal_status: proposed or reviewing`    |
| "accepted but unconverted proposals" | `project-wide`    | `proposal_status: accepted`                 |
| "knowledge health"                   | `project-wide`    | source, ownership, link, and proposal risks |
| "orphaned docs" or "isolated docs"   | `project-wide`    | canonical docs with weak or missing links   |
| "external dependency blockers"       | `delivery-only`   | `blocked_by: external-dependency`           |
| "review load for one component"      | `module-specific` | `facet: reviewers`                          |

## Reliability

Assign one report-level reliability:

| Reliability | Meaning                                                                                                      |
| ----------- | ------------------------------------------------------------------------------------------------------------ |
| `high`      | Core metrics use explicit fields, Kanban columns, stable links, or git history.                              |
| `medium`    | Most metrics are explicit, but some important areas use inference or incomplete schemas.                     |
| `low`       | The report depends heavily on prose inference, missing metadata, local-only material, or inconsistent links. |

Explain the main reason when reliability is `medium` or `low`.
