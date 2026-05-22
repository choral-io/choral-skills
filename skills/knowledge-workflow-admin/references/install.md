# Installation Rules

Use this reference for `knowledge-workflow-admin:init` and `knowledge-workflow-admin:check`.

## Skeleton

Workflow skeleton files live in `skeleton/`.

Normalize `knowledge_dir` and `worktrees_dir` values before writing state files. Trim surrounding whitespace, convert Windows-style `\` separators to `/`, remove redundant leading `./` segments, and remove trailing slashes. Preserve explicit root knowledge directory input as `.`. Examples: `./` -> `.`, `./knowledge/` -> `knowledge`, `knowledge/` -> `knowledge`, and `docs\knowledge\` -> `docs/knowledge`.

Reject repeated separators such as `docs//knowledge`, Windows drive paths such as `C:\knowledge`, UNC paths such as `\\server\share`, and absolute paths.

Do not render explanatory placeholders inside copied workflow documents. Rules, schemas, templates, README text, runtime instructions, and platform hint blocks should keep `<knowledge_dir>`, `<worktrees_dir>`, and similar angle-bracket placeholders so Agents resolve them from runtime bootstrap rules and `manifest.yml` at use time.

Only state-bearing outputs use concrete values:

- `.knowledge-workflow` is created only when `knowledge_dir` is not the default `knowledge`. When present, it contains the selected repository-relative `knowledge_dir`.
- `<knowledge_dir>/.workflow/manifest.yml` records concrete anchor values and repository-root append block paths. Knowledge and worktree managed/protected/local-only entries stay relative to their anchors. Do not copy example comments from `references/manifest.md` into the installed manifest.
- File and directory targets use the selected concrete `knowledge_dir` and `worktrees_dir`.

Skeleton mapping:

- `.knowledge-workflow` -> repository root `.knowledge-workflow` only for non-default `knowledge_dir` values.
- `knowledge/` path segment -> selected `<knowledge_dir>/`.
- `knowledge/_gitignore` -> `<knowledge_dir>/.gitignore`.
- `knowledge/.workflow/runtime.md` -> `<knowledge_dir>/.workflow/runtime.md`.
- `knowledge/.workflow/local.yml` -> local-only `<knowledge_dir>/.workflow/local.yml`.
- `worktrees/_gitignore` -> `<worktrees_dir>/.gitignore`.
- Root platform hint skeleton -> marked platform hint append block.

Treat skeleton installation as an inventory operation:

- Build a complete source-to-target inventory before writing files or reporting the dry run.
- Include parent directories required by target files.
- Copy every skeleton file individually; do not use wildcard copy commands.
- Preserve angle-bracket placeholders in copied workflow documents. Do not replace `<knowledge_dir>` or `<worktrees_dir>` with concrete paths inside explanatory Markdown/YAML files.
- Create `<knowledge_dir>/.workflow/local.yml` from the comment-only skeleton when absent, keep it SCM-ignored, and do not record it as a managed manifest path.
- For default `knowledge_dir: knowledge`, do not create `.knowledge-workflow`; runtime bootstrap falls back to `knowledge` only when `knowledge/.workflow/runtime.md` and `knowledge/.workflow/manifest.yml` both exist.
- For non-default `knowledge_dir` values, create `.knowledge-workflow` as a committed repository-relative pointer without a trailing slash. It should contain one non-empty path line; trailing blank lines are allowed.
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

For `init`, use a user-named directory when present. If no directory is named, ask whether to use `knowledge/` or another repo-relative path. Use `.` only when the maintainer explicitly wants the repository root itself to be the knowledge directory, such as "install at repo root" or "this repository is only a knowledge base." Do not infer `.` from silence.

Reject empty values, `/`, absolute paths, `..`, `.git/`, `.agents/`, `.claude/`, source package directories, build outputs, dependency folders, editor caches, and tool caches.

### Canonical Language

Use a user-named BCP 47 language tag such as `en`, `zh-CN`, or `ja-JP`. If no language is named, ask. Do not silently default the language. Record the selected value as `canonical_language`.

### Agent Skills

The workflow uses required Skills as external runtime capabilities only.

For `init`, check the required Skills by name. Missing Skills do not block initialization. Report missing Skill names in the dry run and final validation, and tell the maintainer they may initialize the workflow without using those Skills for ongoing maintenance.

### Worktrees Directory

Default local worktrees directory: `.worktrees/`.

Use a user-named worktrees directory when present; otherwise use `.worktrees/`. Normalize the value with the same relative-path rules as `knowledge_dir`, but reject `.` because worktrees must not be rooted at the repository root. Reject empty values, `/`, absolute paths, `..`, `.git/`, `.agents/`, `.claude/`, the selected knowledge directory, source package directories, build outputs, dependency folders, editor caches, or tool caches.

### Feedback Mode

Default feedback mode: disabled.

Fresh init writes `feedback.enabled: false` in `<knowledge_dir>/.workflow/manifest.yml`. Maintainers may later enable it with `knowledge-workflow-admin:config` when the team wants `knowledge-assistant` to write local workflow feedback under `<knowledge_dir>/.feedback/`.

## Init Workflow

1. Resolve and validate `knowledge_dir`, `worktrees_dir`, and `canonical_language`.
2. Precheck the skeleton tree: optional `.knowledge-workflow`, platform hint block, `knowledge/_gitignore`, `worktrees/_gitignore`, and required workflow files.
3. Check required Skills by name; record missing Skills as validation findings, not blockers.
4. Build a complete install inventory covering target file parent directories, optional `.knowledge-workflow`, managed knowledge files, local-only `<knowledge_dir>/.workflow/local.yml`, `<worktrees_dir>/.gitignore`, platform hint append block, and manifest file.
5. Build a dry run showing `create`, `mkdir`, `append`, `skip`, and `conflict`.
6. Create target file parent directories separately from file writes.
7. Never overwrite an existing Kanban board, member profile, member workspace, task item, or business knowledge file.
8. Append the marked knowledge workflow block to the root platform hint file; do not replace existing project engineering instructions.
9. Include the final `### Project-Specific Rules` heading inside the marked block. Ask for project-specific rules only when the user mentions them or wants customization.
10. Write `<worktrees_dir>/.gitignore` so worktree contents are ignored while the directory's `.gitignore` remains trackable.
11. After user confirmation, write files and create `<knowledge_dir>/.workflow/manifest.yml` with concrete values and no example comments.
12. Validate optional `.knowledge-workflow`, copied workflow files, platform hint block, `<knowledge_dir>/.gitignore`, ignored local-only `<knowledge_dir>/.workflow/local.yml`, `<worktrees_dir>/.gitignore`, manifest fields, and required Skill availability.
13. Treat editor settings as optional unmanaged convenience; do not edit `.vscode/settings.json` or `.zed/settings.json` unless explicitly asked.
14. Report created directories, created files, missing required Skills, skipped/protected paths, conflicts, and validation findings.

## Init Dry Run Shape

Before writing files, output:

```md
## Init Dry Run

### Parameters

- knowledge_dir: <knowledge_dir>
- worktrees_dir: <worktrees_dir>
- canonical_language: <bcp47>
- feedback.enabled: false

### Install Inventory

| Action   | Source              | Target               | Ownership             |
| -------- | ------------------- | -------------------- | --------------------- |
| create   | skeleton path       | target path          | managed               |
| append   | skeleton hint block | platform hint block  | append_block          |
| skip     | target path         | existing file reason | protected             |
| conflict | target path         | reason               | requires confirmation |

### Required Skills

- available: ...
- missing: ...

### Validation Planned

- manifest fields
- .knowledge-workflow when `knowledge_dir` is not `knowledge`
- platform hint marked block
- <knowledge_dir>/.gitignore
- <worktrees_dir>/.gitignore
- required Skill availability
```

Missing required Skills are warnings, not blockers. Conflicts in managed target files require maintainer confirmation before writing.

## Check Workflow

1. Resolve `<knowledge_dir>` using runtime bootstrap rules: read repository root `.knowledge-workflow` when present; otherwise use default `knowledge` only when `knowledge/.workflow/runtime.md` and `knowledge/.workflow/manifest.yml` both exist.
2. Read `<knowledge_dir>/.workflow/runtime.md` and `<knowledge_dir>/.workflow/manifest.yml`.
3. Validate required manifest fields, grouped managed/protected/local-only shapes, current baseline entries, and the marked platform hint block.
4. Read `agent_skills.required`.
5. If `feedback.enabled` is `true`, verify `<knowledge_dir>/.gitignore` excludes `.feedback/`.
6. Check whether each required Skill is available to the current Agent runtime.
7. If an existing installation has old workflow support paths, missing current baseline paths, or manifest paths that no longer match the installed Skill baseline, read `references/upgrade.md` and report a migration-needed finding with the safest next maintainer prompt.
8. Report available and missing Skills. For missing Skills, tell the maintainer to install the corresponding `skills/<skill-name>/` directory from the Choral Skills distribution into the Agent runtime's Skill directory or with a cross-Agent Skill manager such as `npx skills`.
9. Do not copy Skill files into the target repository and do not update the manifest unless the required Skill list itself is intentionally changed.

## Check Report Shape

```md
## Workflow Check

### Summary

- status: pass | warnings | blocked
- knowledge_dir: <knowledge_dir>
- worktrees_dir: <worktrees_dir>
- canonical_language: <bcp47>
- feedback.enabled: true | false

### Findings

| Severity | Area     | Finding                                              | Suggested next action                                        |
| -------- | -------- | ---------------------------------------------------- | ------------------------------------------------------------ |
| warning  | skills   | missing required Skill                               | install in Agent runtime                                     |
| warning  | feedback | enabled but `.feedback/` is not ignored              | update `<knowledge_dir>/.gitignore` or disable feedback mode |
| warning  | upgrade  | installed support files differ from current baseline | run approved migration dry run                               |

### Required Skills

- available: ...
- missing: ...

### Sources

- .knowledge-workflow when present
- root platform hint block
- <knowledge_dir>/.workflow/manifest.yml
- <knowledge_dir>/.workflow/runtime.md
- <knowledge_dir>/.gitignore
- <worktrees_dir>/.gitignore
```

Use `blocked` only when workflow context, manifest, or managed baseline files cannot be resolved. Missing required Skills are `warning` findings.
