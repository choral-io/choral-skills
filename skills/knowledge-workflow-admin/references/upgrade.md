# Upgrade

Use this when the target repository's knowledge maintainer has upgraded the installed Skills and an existing Knowledge Workflow installation may need repository-side migration. If a change-specific migration note exists, follow it first; otherwise use this generic strategy.

## Rules

- Start with `check`; do not use `init` as a migration shortcut.
- Discovery is read-only. Produce a dry run and require explicit approval before writing.
- Generic migration may update support files by default: optional `.knowledge-workflow`, the root platform hint block, `<knowledge_dir>/.workflow/runtime.md`, `<knowledge_dir>/.workflow/manifest.yml`, rules, schemas, templates, workflow README text, and support ignore files.
- Project facts and local state are not automatically overwritten.
- Project facts may still receive path-level edits when needed to align with current templates, schemas, rules, or an approved migration note. List each edit in the dry run and get maintainer approval.
- Do not stage or commit local state.
- Do not fold project fact edits into a broad support-file move.

## Categories

- `current-support`: support file already matches the current baseline.
- `legacy-support`: old support file with a current-baseline target.
- `missing-support`: required current-baseline support file is absent.
- `conflict`: both legacy and current targets exist, or content differs in a way that needs review.
- `project-fact`: project knowledge, Kanban, tasks, members, groups, proposals, decisions, product, design, architecture, discovery, guidelines, concepts, or assets.
- `local-state`: SCM-excluded or member-local state such as `workspace/*/local/**`, `.feedback/**`, or worktree contents.
- `superpowers-output`: `docs/superpowers/**` specs or plans. Treat as intentional shared repository content only when the user requested that path or confirms the file belongs in the repository; otherwise report it for commit review.
- `dead-link`: internal Markdown link or wikilink that no longer resolves.
- `non-knowledge-link`: knowledge-style link that points to support files, local state, ignored paths, or files outside the knowledge boundary.

## Discovery

1. Resolve `<knowledge_dir>` using runtime bootstrap rules and locate the platform hint Knowledge Workflow block when present.
2. Read `<knowledge_dir>/.workflow/manifest.yml` when present.
3. Read `references/manifest.md` for the current baseline.
4. Inventory existing support files and current-baseline targets.
5. Inventory links in project fact files. Resolve internal Markdown links and wikilinks. Do not treat external URLs as migration failures unless the project has an explicit URL validation rule.
6. Classify paths and links with the categories above.
7. Check Git status. Report unrelated dirty files and avoid touching them.
8. If `docs/superpowers/**` exists, classify each file as `superpowers-output` and report whether it appears intentionally shared or needs user confirmation before commit.

## Strategy

- Move or copy support files only when the source is clearly part of the previous support surface.
- Preserve user-edited support files by reporting a `conflict` instead of overwriting.
- Prefer plain path references when project facts need to mention support files such as rules, schemas, templates, or manifest paths.
- Do not rewrite project fact links automatically. Propose link edits in the dry run and explain whether each edit fixes a `dead-link`, changes a knowledge link into a path reference, or removes a `non-knowledge-link`.
- Preserve existing manifest values unless the current baseline requires a new field. Use the current safe default for new optional fields.
- Keep `knowledge_dir`, `worktrees_dir`, and `canonical_language` stable unless the maintainer explicitly asks for a relocation plan.
- Update root platform hint files only inside the marked Knowledge Workflow block.

## Dry Run Shape

```md
## Upgrade Migration Dry Run

### Current Installation

- knowledge_dir: <knowledge_dir>
- worktrees_dir: <worktrees_dir>
- manifest_version: <value or missing>
- template_version: <value or missing>

### Inventory

| Status             | Existing path | Proposed target | Action                        | Reason                                                         |
| ------------------ | ------------- | --------------- | ----------------------------- | -------------------------------------------------------------- |
| current-support    | ...           | ...             | keep                          | already matches baseline                                       |
| legacy-support     | ...           | ...             | move                          | support file has new baseline location                         |
| missing-support    | -             | ...             | create                        | required support file is absent                                |
| conflict           | ...           | ...             | manual review                 | content or path conflict                                       |
| project-fact       | ...           | -               | keep or propose explicit edit | no generic overwrite                                           |
| local-state        | ...           | -               | keep untracked                | local-only state                                               |
| superpowers-output | ...           | -               | keep or request confirmation  | keep when intentionally shared; otherwise review before commit |
| dead-link          | ...           | ...             | propose explicit edit         | internal link no longer resolves                               |
| non-knowledge-link | ...           | ...             | propose explicit edit         | knowledge-style link points outside project facts              |

### Proposed Changes

- support file moves/creates: ...
- manifest changes: ...
- platform hint marked-block changes: ...
- project fact edits: ...
- link fixes: ...

### Requires Approval

- file moves or creates;
- manifest updates;
- platform hint marked-block update;
- project fact structure, link, frontmatter, or similar edits;
- conflict resolution choices.
```

## Validation

After approved writes:

1. Re-run `knowledge-workflow-admin:check`.
2. Verify current-baseline support files exist.
3. Verify legacy support paths are absent, intentionally retained, or reported for cleanup.
4. Verify project facts changed only by approved path-level edits.
5. Verify local state was not modified or staged.
6. Verify project fact files do not contain unresolved internal links or knowledge-style links to support files/local state, unless explicitly accepted by the maintainer.
7. Verify `.feedback/` is ignored when `feedback.enabled: true`.
8. Verify `<worktrees_dir>/.gitignore` excludes worktree contents while keeping its own `.gitignore` trackable.
