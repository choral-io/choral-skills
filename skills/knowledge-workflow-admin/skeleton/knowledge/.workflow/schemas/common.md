---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - knowledge
---

# Common Knowledge Schema

This schema defines common metadata and document rules for the repository knowledge base.

## Loading Rules

Agents writing or reorganizing knowledge must:

1. Read `<knowledge_dir>/README.md`.
2. Read this common schema.
3. Read the relevant area schema under `<knowledge_dir>/.workflow/schemas/`.
4. Follow the area schema when it is more specific than this file.

## Audit And Fix Flow

Schema audit skills are read-only. Use this flow for metadata and schema cleanup:

```text
audit -> findings and dry-run fixes -> maintainer approval -> apply selected fixes -> audit again
```

Use `task-metadata-audit` for task items and Kanban-related task consistency. Use `knowledge-schema-audit` for non-task knowledge pages.

Dry-run fixes must be directly applicable. Include the file path, field or section, old value, new value, rationale, confidence, and whether the fix is auto-fixable after approval.

After approval:

- Apply document metadata and schema fixes with `knowledge-capture`.
- Apply Kanban board moves with `kanban-maintenance`.
- Apply implementation-related knowledge updates with `delivery-implementation`.

### Auto-Fixable After Approval

- Normalize ownership metadata to the `owners` frontmatter field when the value is clear.
- Add missing `tags` when they can be derived from the directory and filename.
- Add localized metadata when the canonical file is unambiguous.
- Normalize BCP 47 localized suffix casing.
- Normalize relationship metadata that uniquely resolves in its expected relationship scope.
- Normalize Markdown formatting.

### Requires Maintainer Judgment

- Setting or raising `priority` or `value`.
- Promoting `readiness` to `ready`.
- Task splitting, merging, cancellation, or assignment.
- Deciding whether blockers are resolved.
- Moving tasks into or out of `Blocked`.
- Changing product requirements, acceptance criteria, design intent, architecture decisions, or member responsibilities.
- Deleting, archiving, or merging documents.
- Handling possible sensitive information.
- Translating or synchronizing localized content.

## Common Frontmatter

Use YAML frontmatter for durable knowledge files:

```yaml
---
scope: project
type: task
owners:
    - "[[members/Gavroche]]"
assignees:
    - "[[members/Gavroche]]"
reviewers:
    - "[[members/Éponine]]"
tags:
    - app
    - chat
---
```

## Common Fields

- `scope`: `project` or `member`.
- `type`: document type. Area schemas define allowed values.
- `owners`: member or group wikilinks; use a list even for one owner. Use `owners: []` when no owner has been assigned yet.
- `assignees`: member wikilinks for people currently responsible for moving the work forward; use only when a document represents active work.
- `reviewers`: member wikilinks for current or expected reviewers; use only when review responsibility matters.
- `tags`: searchable keywords; use lowercase kebab-case.
- `sources`: evidence or origin links for knowledge derived from external documents, shared workspace material, handoffs, research, proposals, task items, decisions, or other canonical pages. Use a list even for one source.

Use `owners` consistently as the durable ownership field.

## Responsibility Fields

- `owners` is durable. It means who maintains the knowledge, domain, or document.
- `assignees` is temporary. It means who is currently moving the work forward.
- `reviewers` is temporary. It means who should review the work before acceptance or completion.

Do not use `assignees` to mirror Kanban status. Delivery status belongs in `<knowledge_dir>/planning/KANBAN.md`.

## Metadata And Body Boundaries

Frontmatter exists for filtering, routing, ownership, planning, and Agent automation. The Markdown body exists for context, reasoning, product intent, design intent, decisions, and acceptance criteria.

Do not use metadata as a substitute for durable explanation. Complex blockers, product behavior, design rationale, architectural consequences, and acceptance criteria belong in the body even when related metadata exists.

## Source Traceability

Use `sources` frontmatter for evidence or origin, not for loose topical relationships. Use `related_to` or body links for contextual references that are not evidence.

Source-derived documents should record structured source traceability in frontmatter `sources`. A `## Source Notes` section explains evidence boundaries; it does not replace frontmatter `sources`.

Add or preserve source traceability when a document is derived from:

- external URLs, uploaded documents, market research, customer feedback, QA reports, support notes, or meeting notes;
- shared workspace `summaries/`, `handoffs/`, or `research/`;
- proposals converted into canonical knowledge, decisions, or task items;
- task items, decisions, architecture notes, product requirements, or design resources that justify downstream work.

Do not invent sources. If source material is private, sensitive, unavailable, or local-only, summarize only safe public context and record the safe source boundary instead of copying private content.

When source evidence is complex, add a short `## Source Notes` or equivalent body section explaining what the source supports, what remains inferred, and any conflict with existing canonical knowledge.

## Knowledge Scope

Use this precedence when reading multiple knowledge scopes:

```text
repository workflow runtime and repository safety rules
> schemas, workflow rules, and accepted decisions
> canonical project knowledge and code
> shared workspace summaries, handoffs, and research
> personal local notes, worklists, logs, and local workspace instructions
> current conversation
```

Precedence depends on the kind of question. Safety, privacy, ownership, approval, and review rules come from higher-scope governance. Project facts come from canonical project knowledge and code. Shared workspace material is team-visible context or evidence, not automatically an approved fact. Personal local material can shape the current member's execution context, but it cannot override project rules, accepted decisions, or canonical facts.

If sources conflict and the conflict affects facts, delivery scope, permissions, review, ownership, or another member, report the conflict and ask for clarification before writing or acting.

## Identity

Use member or group wikilinks in responsibility metadata, such as `[[members/Gavroche]]` or `[[groups/review-board]]`. Manual short wikilinks such as `[[Gavroche]]` are valid only when they resolve uniquely in the expected member or group scope. Empty `owners: []` means ownership is intentionally not assigned yet; it is allowed for draft or unowned knowledge, but it is an ownership gap at workflow gates that require accountability.

Agents must resolve the current member id using `<knowledge_dir>/.workflow/runtime.md`. Do not infer member identity from Git identity, operating system account, machine name, shell prompt, chat participant name, or display name.

When matching `owners`, `assignees`, or `reviewers`, normalize member and group wikilinks before comparing. For example, `[[members/Gavroche]]`, `[[Gavroche]]`, and `[[Gavroche|Gavroche Thenardier]]` can all match id `Gavroche` when the target is unambiguous.

## Localization

Canonical-language files are the authoritative source. This repository records `canonical_language: <bcp47>` in `<knowledge_dir>/.workflow/manifest.yml`. Localized files must use BCP 47 suffix casing, such as `.zh-CN.md`.

Localized files should include:

```yaml
lang: zh-CN
canonical: ./agent.md
translation_of: agent
```

Localized files must not introduce new facts, decisions, requirements, or delivery status.

## Linking

- Use Foam wikilinks for knowledge references when they improve navigation.
- Use path-qualified wikilinks for tool-written knowledge references, such as `owners: ["[[members/Gavroche]]"]` or `related_to: ["[[tasks/example-note]]"]`.
- Manual short wikilinks are acceptable only when they resolve uniquely in the expected relationship scope.
- Use workspace-relative paths, not wikilinks, for file, resource, and configuration path fields such as localized `canonical` paths.
- Preserve existing Obsidian/Foam wikilinks unless the task explicitly includes link normalization or document migration.
- When adding new links in durable README, decision, schema, or process documents, prefer standard Markdown links when they are practical and stable.
- Do not use heading or block wikilinks in structured relationship metadata.
- Do not use display titles as ids in metadata.
- Do not add an `id` field unless a document must survive frequent renames.
- Do not use frontmatter fields starting with `_`; those are reserved for external tools such as Tolaria.

## Editing

- Preserve existing rationale, context, and change notes unless the task explicitly asks to clean, promote, archive, or rewrite the document.

## Sensitive Content

Do not store secrets, credentials, private customer data, or private personal notes in the knowledge base.

## Directories

Knowledge area directories are created on demand. Do not rely on empty directories being present in a fresh checkout. When writing a new knowledge file or asset, create the target directory first if it does not exist.
