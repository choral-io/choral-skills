---
name: knowledge-schema-audit
description: Use when non-task knowledge needs a read-only check for schema, frontmatter, localization, links, or consistency.
---

# Knowledge Schema Audit

## Runtime Context

Before acting, resolve `<knowledge_dir>` using the runtime bootstrap rules, then read `<knowledge_dir>/.workflow/runtime.md` and `<knowledge_dir>/.workflow/manifest.yml`; do not assume non-default workflow paths or default ids.

Use this skill to inspect non-task knowledge schema quality. This skill is read-only.

## Workflow

1. Read `<knowledge_dir>/.workflow/schemas/common.md`.
2. Read relevant area schemas under `<knowledge_dir>/.workflow/schemas/`.
3. Scan `<knowledge_dir>/**/*.md`.
4. Exclude workflow infrastructure: `<knowledge_dir>/.workflow/**` and `<knowledge_dir>/.feedback/**`.
5. Exclude delivery surfaces: `<knowledge_dir>/tasks/**` and `<knowledge_dir>/planning/KANBAN.md`; task metadata, readiness, dependencies, and Kanban consistency belong to `task-metadata-audit`.
6. Exclude local-only state: `<knowledge_dir>/workspace/*/local/**`.
7. Parse frontmatter, filenames, links, and localized-file suffixes.
8. Compare each document to the relevant area schema.
9. Report findings and dry-run fixes without editing files.

## Checks

- Missing YAML frontmatter.
- Missing or invalid `scope`, `type`, `owners`, or `tags`. Treat `owners: []` as valid syntax and report it as an ownership gap only when the document type, workflow state, or requested check requires an accountable owner.
- Ownership metadata that does not use the canonical `owners` field.
- Localized files missing `lang`, `canonical`, or `translation_of`.
- Localized files that link to other localized files by default.
- Discovery, product, or design files placed in the wrong area.
- Assets referenced from Markdown but not stored under a typed `<knowledge_dir>/assets/<asset-type>/<topic>/` directory.
- Decision files with missing supersession metadata when a replacement is obvious.
- Proposal files with missing or invalid `proposal_type`, `proposal_status`, `sources`, or target metadata.
- Member files missing `member_id` or `display_name`.
- Member files that still use legacy `groups` frontmatter instead of group documents' `members` lists.
- Group `members` entries that point to missing or ambiguous member profiles.
- Workspace notes that appear to contain project facts that should be promoted.
- Shared workspace files created under deprecated `daily/`, `inbox/`, `scratch/`, or `drafts/` directories.
- Possible secrets, credentials, private customer data, or private personal notes.

## Output

Use the standard audit output shape from `references/report.md`: `Summary`, `Findings`, `Dry-run fixes`, `Requires judgment`, `Safe after approval`, and `Sources`.

## Guardrails

- Do not edit files.
- Do not delete or archive documents.
- Do not rewrite localized content.
- Do not infer product intent, design intent, or architecture decisions.
- Stop and report possible sensitive content.

## References

- For report format and fix rules, read `references/report.md`.
