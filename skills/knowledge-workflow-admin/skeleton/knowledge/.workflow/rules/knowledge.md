---
scope: project
type: process
owners: []
tags:
    - knowledge
    - workflow
---

# Knowledge Rules

This document defines source precedence, knowledge placement, schema use, assets, localization, and shared-knowledge write rules.

## Required Reads

- Before writing knowledge, read `<knowledge_dir>/.workflow/schemas/common.md` and the target area schema.
- Before changing delivery status, read `<knowledge_dir>/.workflow/rules/delivery.md`.
- Before using member-local material, read `<knowledge_dir>/.workflow/rules/workspace.md`.

## Source Of Truth

| Area                  | Source of truth                             | Notes                                            |
| --------------------- | ------------------------------------------- | ------------------------------------------------ |
| Project facts         | `<knowledge_dir>/` canonical files and code | Canonical-language files are authoritative.      |
| Workflow rules        | `<knowledge_dir>/.workflow/rules/*.md`      | Operational rules, not project facts.            |
| Schemas               | `<knowledge_dir>/.workflow/schemas/*.md`    | Writing contracts, not project facts.            |
| Templates             | `<knowledge_dir>/.workflow/templates/*.md`  | Starting points, not project facts.              |
| Delivery status       | `<knowledge_dir>/planning/KANBAN.md`        | Board edits require approved Kanban maintenance. |
| Personal work context | `<knowledge_dir>/workspace/<member-id>/`    | Context, not team consensus.                     |

When sources conflict, apply precedence from `<knowledge_dir>/.workflow/schemas/common.md`. Local notes and current conversation can trigger updates, but they do not replace canonical knowledge until approved capture or maintenance happens.

## Workflow Stages

1. Capture raw personal context in the current member's `local/` workspace. Do not store secrets, private notes, or customer-sensitive data.
2. Route durable material through `knowledge-intake`; write only approved shared or canonical updates through `knowledge-capture`.
3. Use `proposals/` for valuable but unconfirmed knowledge, task, or decision candidates. Accepted proposals must be converted before they become facts or delivery inputs.
4. Put durable project material in the matching canonical area: `discovery/`, `product/`, `design/`, `concepts/`, `architecture/`, `decisions/`, `guidelines/`, `planning/`, or `tasks/`.

## Knowledge Areas

| Area            | Use for                                                                  |
| --------------- | ------------------------------------------------------------------------ |
| `discovery/`    | market, customer, competitor, business, assumption, and research context |
| `product/`      | product behavior, requirements, flows, prototypes, and IA                |
| `design/`       | UI design, interaction states, layout, visual rules, design systems      |
| `assets/`       | supporting files organized by asset type, such as `assets/design/`       |
| `concepts/`     | glossary terms, domain concepts, and shared mental models                |
| `architecture/` | modules, APIs, data flow, integrations, configuration, operations        |
| `decisions/`    | accepted product or technical tradeoffs and supersessions                |
| `guidelines/`   | cross-area writing, terminology, language, documentation, process        |
| `proposals/`    | optional review buffer for unconfirmed candidates                        |
| `planning/`     | roadmap, sprint planning, sprint summaries, and delivery status          |
| `tasks/`        | durable delivery task context and acceptance criteria                    |
| `workspace/`    | member-scoped shared summaries, handoffs, research, and local state      |

## Workflow Support Files

Files under `.workflow/` are workflow infrastructure:

- `.workflow/manifest.yml`: installation and runtime state;
- `.workflow/rules/`: workflow rules;
- `.workflow/schemas/`: writing and audit contracts;
- `.workflow/templates/`: reusable starting points.

Do not treat `.workflow/**` files as project facts, graph nodes, delivery candidates, task inputs, product/design/architecture knowledge, or status report subject documents unless the user explicitly asks about workflow infrastructure.

`.feedback/` is local-only feedback about the workflow itself. It is not shared project knowledge, task context, delivery state, or accepted process change.

## Assets

Store binary or exported supporting materials under `<knowledge_dir>/assets/<asset-type>/<topic>/`, for example `<knowledge_dir>/assets/design/<feature-name>/`, and link to them from Markdown files.

`assets/design/` is only an example asset-type path. The project may organize assets under `assets/` by asset type, such as `design`, `image`, `export`, `research`, or another clear type.

## Localized Versions

`canonical_language: <bcp47>` in `<knowledge_dir>/.workflow/manifest.yml` is the source language for canonical knowledge. Localized files may help readers but must declare translation metadata and must not introduce new facts, decisions, requirements, or delivery status.

## Agent Rules

Agents working in this workflow must:

- preserve repository safety and workflow runtime instructions;
- use schemas before writing knowledge;
- use delivery rules before delivery changes;
- keep `workspace/<member-id>/local/` and worktree contents under `<worktrees_dir>/` local-only, except the managed `<worktrees_dir>/.gitignore`;
- avoid localized files and local-only notes as planning inputs;
- stop and report secrets, sensitive data, or scope conflicts;
- update durable product, discovery, design, architecture, decision, or guideline knowledge when delivery changes it.
