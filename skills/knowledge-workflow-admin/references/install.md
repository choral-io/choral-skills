# Installation Rules

Use this reference for `knowledge-workflow-admin:init` and `knowledge-workflow-admin:check`.

## Skeleton

Workflow skeleton files live in `skeleton/`.

Render text skeleton files by replacing `{{knowledge_dir}}`, `{{worktree_dir}}`, and `{{canonical_language}}`. Normalize directory values without trailing slashes before writing the manifest or rendering placeholders.

Skeleton mapping:

- `knowledge/` path segment -> selected `<knowledge_dir>/`.
- `knowledge/_gitignore` -> `<knowledge_dir>/.gitignore`.
- `worktrees/_gitignore` -> `<worktree_dir>/.gitignore`.
- Root skeleton `AGENTS.md` -> marked root `AGENTS.md` append block.

Treat skeleton rendering as an inventory operation:

- Build a complete source-to-target inventory before writing files or reporting the dry run.
- Include parent directories required by rendered files.
- Render every knowledge and AGENTS skeleton file individually; do not use wildcard copy commands.
- Do not create empty knowledge area directories during init; create them on demand when writing files later.

## On-Demand Knowledge Directories

Knowledge area directories such as `<knowledge_dir>/architecture/`, `<knowledge_dir>/product/`, `<knowledge_dir>/design/`, `<knowledge_dir>/tasks/`, `<knowledge_dir>/assets/<asset-type>/`, and `<knowledge_dir>/planning/sprints/` are created on demand. Do not rely on empty directories existing in a fresh checkout.

## Required Skills

```text
knowledge-assistant
delivery-implementation
delivery-planning
delivery-review
kanban-maintenance
knowledge-capture
knowledge-intake
knowledge-schema-audit
knowledge-status-report
next-task-selection
task-metadata-audit
workspace-worklist
```

All listed Skills must be available to the current Agent through the Agent runtime's Skill installation mechanism. The workflow does not copy Skills into target repositories.

## Init Parameters

### Knowledge Directory

Default directory: `knowledge/`.

For `init`, use a user-named directory when present. If no directory is named, ask whether to use `knowledge/` or another repo-relative path. Reject absolute paths, `..`, `.git/`, `.agents/`, `.claude/`, source package directories, build outputs, dependency folders, editor caches, and tool caches.

### Canonical Language

Use a user-named BCP 47 language tag such as `en`, `zh-CN`, or `ja-JP`. If no language is named, ask. Do not silently default the language. Record the selected value as `canonical_language`.

### Agent Skills

The workflow uses required Skills as external runtime capabilities only.

For `init`, check the required Skills by name. Missing Skills do not block initialization. Report missing Skill names in the dry run and final validation, and tell the maintainer they may initialize the workflow without using those Skills for ongoing maintenance.

### Worktree Directory

Default local worktree directory: `.worktrees/`.

Use a user-named worktree directory when present; otherwise use `.worktrees/`. Reject absolute paths, `..`, `.git/`, `.agents/`, `.claude/`, the selected knowledge directory, source package directories, build outputs, dependency folders, editor caches, or tool caches.

## Init Workflow

1. Resolve and validate `knowledge_dir`, `worktree_dir`, and `canonical_language`.
2. Precheck the skeleton tree: root AGENTS block, `knowledge/_gitignore`, `worktrees/_gitignore`, and required workflow files.
3. Check required Skills by name; record missing Skills as validation findings, not blockers.
4. Build a complete render inventory covering rendered file parent directories, managed knowledge files, `<worktree_dir>/.gitignore`, root AGENTS append block, and manifest file.
5. Build a dry run showing `create`, `mkdir`, `append`, `skip`, and `conflict`.
6. Create rendered file parent directories separately from file rendering.
7. Never overwrite an existing Kanban board, member profile, member workspace, task item, or business knowledge file.
8. Append the marked knowledge workflow block to root `AGENTS.md`; do not replace existing project engineering instructions.
9. Include the final `### Project-Specific Rules` heading inside the marked block. Ask for project-specific rules only when the user mentions them or wants customization.
10. Render `<worktree_dir>/.gitignore` so worktree contents are ignored while the directory's `.gitignore` remains trackable.
11. After user confirmation, write files and create `<knowledge_dir>/.workflow/manifest.yml`.
12. Validate rendered workflow files, root AGENTS block, `<knowledge_dir>/.gitignore`, `<worktree_dir>/.gitignore`, manifest fields, and required Skill availability.
13. Treat editor settings as optional unmanaged convenience; do not edit `.vscode/settings.json` or `.zed/settings.json` unless explicitly asked.
14. Report created directories, created files, missing required Skills, skipped/protected paths, conflicts, and validation findings.

## Init Dry Run Shape

Before writing files, output:

```md
## Init Dry Run

### Parameters

- knowledge_dir: <knowledge_dir>
- worktree_dir: <worktree_dir>
- canonical_language: <bcp47>

### Render Inventory

| Action   | Source             | Target               | Ownership             |
| -------- | ------------------ | -------------------- | --------------------- |
| create   | skeleton path      | target path          | managed               |
| append   | skeleton/AGENTS.md | AGENTS.md block      | append_block          |
| skip     | target path        | existing file reason | protected             |
| conflict | target path        | reason               | requires confirmation |

### Required Skills

- available: ...
- missing: ...

### Validation Planned

- manifest fields
- root AGENTS marked block
- <knowledge_dir>/.gitignore
- <worktree_dir>/.gitignore
- required Skill availability
```

Missing required Skills are warnings, not blockers. Conflicts in managed target files require maintainer confirmation before writing.

## Check Workflow

1. Read root `AGENTS.md` to find the explicit knowledge directory.
2. Read `<knowledge_dir>/.workflow/manifest.yml`.
3. Validate required manifest fields, managed/protected path shapes, and the marked root `AGENTS.md` workflow block.
4. Read `agent_skills.required`.
5. Check whether each required Skill is available to the current Agent runtime.
6. Report available and missing Skills. For missing Skills, tell the maintainer to install the corresponding `skills/<skill-name>/` directory from the Choral Skills distribution into the Agent runtime's Skill directory or with a cross-Agent Skill manager such as `npx skills`.
7. Do not copy Skill files into the target repository and do not update the manifest unless the required Skill list itself is intentionally changed.

## Check Report Shape

```md
## Workflow Check

### Summary

- status: pass | warnings | blocked
- knowledge_dir: <knowledge_dir>
- worktree_dir: <worktree_dir>
- canonical_language: <bcp47>

### Findings

| Severity | Area   | Finding                | Suggested next action    |
| -------- | ------ | ---------------------- | ------------------------ |
| warning  | skills | missing required Skill | install in Agent runtime |

### Required Skills

- available: ...
- missing: ...

### Sources

- root AGENTS.md
- <knowledge_dir>/.workflow/manifest.yml
- <knowledge_dir>/.gitignore
- <worktree_dir>/.gitignore
```

Use `blocked` only when workflow context, manifest, or managed baseline files cannot be resolved. Missing required Skills are `warning` findings.
