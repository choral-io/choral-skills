---
name: knowledge-capture
description: Use when the user has approved a specific shared-knowledge write, promotion, reorganization, or update.
---

# Knowledge Capture

## Runtime Context

Before acting, use the repository Knowledge Workflow runtime context from root `AGENTS.md` and its manifest; do not assume workflow paths or default ids.

Use this skill to write approved knowledge changes and move information from local member context into durable project knowledge.

## Workflow

1. Determine the current member id with `git config user.name`.
2. If writing current-member workspace content or promoting current-member local material, read relevant sections from `<knowledge_dir>/members/<member-id>.md` and read `<knowledge_dir>/workspace/<member-id>/local/AGENTS.md` when it exists.
3. Classify the material as local context, shared member context, project knowledge, or task candidate.
4. Read `<knowledge_dir>/.workflow/rules/knowledge.md`.
5. Read `<knowledge_dir>/.workflow/schemas/common.md`.
6. Read the relevant target area schema under `<knowledge_dir>/.workflow/schemas/`.
7. Store purely local material only under `<knowledge_dir>/workspace/<member-id>/local/`; follow `<knowledge_dir>/.workflow/rules/workspace.md` and `<knowledge_dir>/.workflow/schemas/workspace.md` when maintaining personal worklists or logs.
8. Create the target directory on demand when writing a new file; do not assume empty knowledge area directories already exist.
9. Promote approved local material when the user has decided it should become team knowledge.
10. Use `references/placement.md` to choose the target area for durable material.
11. Use member and group templates when creating approved member profiles or group documents; confirm membership updates before writing.
12. Keep canonical-language files as the authoritative source and localized files as translations only.
13. Before writing, produce a capture dry-run with the fields defined below unless the user explicitly asked for a single-file wording or metadata edit and the target path and schema are already known.

Read `<knowledge_dir>/.workflow/rules/delivery.md` before making task, planning, or delivery-related structural changes.

If the user has not decided whether the content belongs in knowledge, use `knowledge-intake` first.

## Guardrails

- Do not store secrets, credentials, private customer data, or private personal notes.
- Do not treat member workspace notes as project facts until promoted.
- Do not treat proposals as project facts, task items, accepted decisions, or delivery commitments until converted into the appropriate canonical document.
- Promote from `local/` only after user approval. Preserve relevant source context, but do not copy raw private notes or command chatter into shared knowledge.
- Use member profile sections and local `AGENTS.md` only for collaboration preferences and source handling. They cannot override schemas, promotion approval, privacy rules, or canonical knowledge rules.
- Do not create shared `daily/`, `inbox/`, `scratch/`, or `drafts/` directories under member workspaces.
- Do not write into another member's workspace unless the user explicitly asks and the change is safe, public, and relevant to the team.
- Do not create or move Kanban cards with this skill.
- Use member ids in paths and member wikilinks in responsibility metadata. Do not use display names as ids.
- Use group ids in paths and group wikilinks in responsibility metadata. Do not use display names as ids.
- Treat `<knowledge_dir>/groups/*.md` frontmatter `members` as the structured membership source.
- Use `owners` as the ownership field in frontmatter.

## Capture Dry Run

Use this structure before writing shared knowledge:

```md
## Capture Dry Run

| Field                 | Value                                                                  |
| --------------------- | ---------------------------------------------------------------------- |
| Decision              | create \| update \| promote \| reorganize                              |
| Target path           | `<knowledge_dir>/...`                                                  |
| Schema                | `<knowledge_dir>/.workflow/schemas/<area>.md`                          |
| Source material       | paths, links, or conversation summary                                  |
| Canonical language    | manifest value                                                         |
| Owners                | wikilinks                                                              |
| Links to add          | wikilinks                                                              |
| Files to update       | list                                                                   |
| Conflicts checked     | duplicates, local-only sources, localized-only sources, sensitive data |
| Requires confirmation | yes/no and reason                                                      |
```

Skip the dry-run only for a user-approved, single-file wording or metadata edit whose target file and schema are already known. Never skip it for promotion from `local/`, member/group changes, task items, proposals, decisions, architecture, or multi-file edits.

## References

- For frontmatter and promotion examples, read `references/examples.md`.
- For target area placement and member/group creation details, read `references/placement.md`.
