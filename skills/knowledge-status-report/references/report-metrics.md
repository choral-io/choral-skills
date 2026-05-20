# Report Metrics

Use these metric ids when the user asks for common status statistics:

| Metric id                        | Scope         | Basis                     | Source                                                             |
| -------------------------------- | ------------- | ------------------------- | ------------------------------------------------------------------ |
| `kanban.cards_by_column`         | delivery-only | board-based               | `planning/KANBAN.md`                                               |
| `tasks.by_readiness`             | delivery-only | field-based               | `tasks/*.md`                                                       |
| `tasks.blocked_unresolved`       | delivery-only | field-based               | `blocked_by` plus referenced task state                            |
| `tasks.ready_unassigned`         | delivery-only | field-based + board-based | Ready cards and `assignees`                                        |
| `reviews.pending`                | delivery-only | board-based + field-based | Reviewing cards and `reviewers`                                    |
| `proposals.by_status`            | project-wide  | field-based               | `proposals/**/*.md`                                                |
| `proposals.accepted_unconverted` | project-wide  | field-based + link check  | accepted proposals and target docs                                 |
| `knowledge.source_trace_missing` | project-wide  | field-based + inferred    | source-derived docs without `sources` or source notes              |
| `knowledge.orphaned_docs`        | project-wide  | link-based + inferred     | canonical docs with no inbound/outbound durable links              |
| `knowledge.link_gaps`            | project-wide  | link-based + schema check | requirements, decisions, designs, and tasks missing expected links |
| `decisions.by_status`            | project-wide  | field-based or inferred   | `decisions/**/*.md`                                                |
| `requirements.with_delivery`     | product-only  | link-based                | product docs, task items, Done cards                               |
| `ownership.by_area`              | ownership     | field-based               | `owners`, `assignees`, `reviewers`                                 |
| `knowledge.by_area`              | project-wide  | path-based + field-based  | knowledge area directories                                         |
| `local.excluded`                 | project-wide  | path-based                | `workspace/*/local/**` count only when explicitly requested        |

If a request matches one of these metrics, use the metric id in `Counts.Area`. If no metric id fits, keep the nearest scope and add `Filter` or `Facet` in the report.

Exclude `schemas/**` and `templates/**` from project fact, health, orphan, link-gap, ownership, and knowledge-by-area counts unless the user explicitly asks about workflow infrastructure. Schema and template files are workflow infrastructure, not product, design, architecture, decision, proposal, task, or member knowledge.
