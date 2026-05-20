---
scope: project
type: index
owners: []
tags:
    - knowledge
---

# Project Knowledge

This directory is the project knowledge base for this project. It stores shared facts, decisions, product context, and task planning material that should live with the code.

The bundled profile is optimized for software product development teams. Its default areas and workflow rules focus on product knowledge, design notes, architecture decisions, delivery tasks, implementation review, and reusable product development experience.

Read [schemas/common.md](schemas/common.md) before writing or reorganizing knowledge files. Then read the relevant area schema under [schemas/](schemas/).

## Where To Start

Use `knowledge-assistant` when the next process step is unclear.

- New idea, feedback, or observation: use `knowledge-intake` before writing shared knowledge.
- Approved knowledge update: use `knowledge-capture`.
- Personal executable work: use `workspace-worklist`.
- Selected Kanban card: use `workspace-worklist:intake-task` before implementation when local execution tracking is useful.
- Unsure what to work on next: use `next-task-selection`.
- Approved Kanban board change: use `kanban-maintenance`.
- Completed implementation that may be ready for Done: use `delivery-review`.

## Areas

- `members/`: team member profiles, responsibilities, focus areas, and public collaboration context.
- `groups/`: non-person responsibility subjects such as teams, review boards, maintainer groups, and working groups.
- `workspace/`: member-scoped shared summaries, handoffs, research, and local-only worklists/logs/personal Agent preferences under `local/`.
- `discovery/`: requirement discovery, market and business research, customer context, environmental analysis, opportunity framing, and assumptions.
- `product/`: product requirements, feature definitions, and user-facing behavior.
- `concepts/`: domain terms and reusable conceptual notes.
- `architecture/`: technical design and module-level architecture.
- `decisions/`: accepted product or technical decisions.
- `guidelines/`: cross-area writing, terminology, language, documentation, and process guidelines.
- `planning/`: roadmap, sprint planning, and sprint summaries.
- `proposals/`: optional review buffer for valuable but unconfirmed knowledge, task, or decision candidates.
- `tasks/`: durable delivery task context and acceptance criteria.
- `schemas/`: writing contracts for knowledge metadata, body structure, naming, and link rules.
- `templates/`: reusable Markdown templates for task, proposal, member, group, handoff, and worklist files.

## Schemas

Use these schema files when writing or auditing knowledge:

| Target              | Schema                                             |
| ------------------- | -------------------------------------------------- |
| Any knowledge file  | [schemas/common.md](schemas/common.md)             |
| `discovery/`        | [schemas/discovery.md](schemas/discovery.md)       |
| `product/`          | [schemas/product.md](schemas/product.md)           |
| `design/`           | [schemas/design.md](schemas/design.md)             |
| `architecture/`     | [schemas/architecture.md](schemas/architecture.md) |
| `concepts/`         | [schemas/concepts.md](schemas/concepts.md)         |
| `decisions/`        | [schemas/decisions.md](schemas/decisions.md)       |
| `guidelines/`       | [schemas/guidelines.md](schemas/guidelines.md)     |
| `planning/`         | [schemas/planning.md](schemas/planning.md)         |
| `planning/sprints/` | [schemas/sprints.md](schemas/sprints.md)           |
| `proposals/`        | [schemas/proposals.md](schemas/proposals.md)       |
| `tasks/`            | [schemas/tasks.md](schemas/tasks.md)               |
| `members/`          | [schemas/members.md](schemas/members.md)           |
| `groups/`           | [schemas/groups.md](schemas/groups.md)             |
| `workspace/`        | [schemas/workspace.md](schemas/workspace.md)       |

Schema files are workflow rules, not product facts or delivery candidates.

Knowledge documents use `.md` or `.mdx`. Files under `templates/` are reusable starting points and are not knowledge documents, graph nodes, task inputs, or delivery candidates.

Editors may treat template files as Markdown for editing and formatting, while Foam should exclude `templates/` from the knowledge graph.

## Source Of Truth

- Project facts live in `{{knowledge_dir}}/` and code.
- Delivery status lives in `{{knowledge_dir}}/planning/KANBAN.md`.
- Proposals are candidates for review; they are not project facts, accepted decisions, task items, or delivery commitments until converted into the appropriate canonical document.
- Member workspace notes can inform project knowledge, but they do not become project facts until promoted into a project-scoped document.
- Member `local/` directories are local-only personal state and must not be committed.
- External editor features, including Foam graph and backlinks, are navigation aids rather than sources of truth.

## Scope And Precedence

Use the narrowest context that is sufficient for the task, but apply stronger governance first when sources conflict:

```text
root AGENTS.md and repository safety rules
> knowledge schemas, workflow rules, and accepted decisions
> canonical project knowledge and code
> shared workspace summaries, handoffs, and research
> personal local notes, worklists, logs, and local AGENTS.md
> current conversation
```

This order is not a blind merge rule. Safety, privacy, ownership, approval, and review rules must not be weakened by lower-scope material. Project facts should come from canonical project knowledge and code. Shared workspace material may provide evidence or context, but it is not automatically a project fact. Personal local material may guide execution preferences and temporary context for the current member, but it must not override project facts, schemas, workflow rules, or accepted decisions.

When two sources conflict and the answer affects facts, delivery scope, permissions, review, or other members, stop and report the conflict instead of silently choosing one source.

## Terminology And Language

Use `guidelines/` for cross-area guidance that applies to multiple knowledge areas. Keep area-specific writing contracts in `schemas/`, delivery process gates in `planning/WORKFLOW.md`, reusable starting points in `templates/`, and product/design/architecture/concept/decision facts in their owning areas.

Name guideline files with a clear topic phrase in kebab case. Avoid vague names such as `guidelines.md`, `rules.md`, or `notes.md`.

## Foam-Compatible Wikilinks

This knowledge base uses Foam-compatible wikilinks such as `[[note-id]]` for lightweight bidirectional navigation.

`{{knowledge_dir}}/` is Obsidian-readable, Foam-compatible, and Markdown-first.

Foam is an optional human-facing editor experience for VS Code. Team members may use Foam for graph view, backlinks, placeholders, and wikilink navigation, but the project does not require Foam, Foam CLI, Foam templates, or Foam Janitor.

Obsidian can also open `{{knowledge_dir}}/` as a normal Vault through core Markdown, frontmatter, wikilinks, backlinks, graph, and tags. The project must not rely on Obsidian-only plugin features such as Dataview, Obsidian Kanban settings, Templater, or plugin-specific syntax.

Agents should treat plain Markdown files, `{{knowledge_dir}}/schemas/*.md`, repository skills, and `{{knowledge_dir}}/planning/KANBAN.md` as the operational rules. Agents must not rely on the Foam VS Code extension or any external Foam tool to understand or update project knowledge.

Project wikilink rules:

- Use wikilinks for knowledge references, such as member, group, task, decision,
  and related-knowledge fields.
- Use workspace-relative paths, not wikilinks, for file, resource, and
  configuration path fields.
- Manual short wikilinks such as `[[note-id]]` are valid only when they resolve
  uniquely in the expected relationship scope.
- Tool-written links and examples should prefer path-qualified wikilinks such as
  `[[groups/review-board]]` or `[[tasks/example-delivery-task]]`.
- Use display aliases only for human-readable labels, such as `[[tasks/example-delivery-task|Example delivery task]]`.
- Kanban card wikilinks resolve to `{{knowledge_dir}}/tasks/<task-id>.md` by default.
- If a wikilink can resolve to multiple canonical files, report the ambiguity instead of guessing.
- Check for broken or ambiguous wikilinks after renaming, moving, or deleting Markdown files.

## Workflow

The full collaboration and delivery workflow is defined in `{{knowledge_dir}}/planning/WORKFLOW.md`.

Summary:

```text
member workspace -> project knowledge -> task item -> Kanban -> pull request -> updated knowledge
```

## Localized Versions

Canonical-language files are the authoritative source for project knowledge. This repository records `canonical_language: {{canonical_language}}` in `{{knowledge_dir}}/.workflow/manifest.yml`. Localized files may exist for reading, onboarding, or customer-facing preparation, but they must not introduce new project facts, decisions, requirements, or task status.

Use a language suffix next to the canonical file:

```text
{{knowledge_dir}}/concepts/agent.md
{{knowledge_dir}}/concepts/agent.zh-CN.md
{{knowledge_dir}}/concepts/agent.ja-JP.md
```

Localized files must:

- Use `lang` to identify the locale.
- Use `canonical` to link to the canonical file.
- Use `translation_of` to identify the canonical note id.
- Link only to their canonical file by default.
- Avoid links to other localized files.
- Avoid participation in Kanban planning.

Localized files may become stale. If freshness matters, add `translated_at` and `canonical_revision` frontmatter.

## Current User

Agents must determine the current member from the local Git identity:

```sh
git config user.name
```

Use that value as the member id to select the matching member profile in `{{knowledge_dir}}/members/` and the matching workspace in `{{knowledge_dir}}/workspace/<member-id>/`. The member id does not need to match the display name. Do not infer the current user from the operating system account, machine name, shell prompt, or chat participant name.

When member context matters, prefer section-scoped reads from `{{knowledge_dir}}/members/<member-id>.md`. Read the full member file only when editing, auditing, or resolving ambiguity. Personal Agent collaboration preferences may live in `{{knowledge_dir}}/workspace/<member-id>/local/AGENTS.md`; that file is local-only and must not override project workflow rules.

Use `{{knowledge_dir}}/templates/member.md` when adding a project-visible member profile. Confirm membership manually or by matching responsibilities to existing groups, then update the confirmed group documents' `members` lists.

Use `{{knowledge_dir}}/templates/group.md` when adding a project-visible group, team, review board, or working group. Confirm members manually or by matching group responsibilities to existing member profiles before writing `members`. Treat `groups/*.md` frontmatter `members` as the structured membership source.
