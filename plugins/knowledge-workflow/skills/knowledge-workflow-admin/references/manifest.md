# Manifest

The target repository stores installation state at:

```text
<knowledge_dir>/.workflow/manifest.yml
```

## Required Fields

Manifest examples use concrete sample values. Installed manifests must contain normalized concrete values, not angle-bracket placeholders. Replace these sample values with maintainer-selected values during init.

```yaml
template_id: knowledge-workflow
template_version: 1
manifest_version: 2
knowledge_dir: knowledge # normalized repo-relative knowledge dir
worktrees_dir: .worktrees # normalized repo-relative local worktrees dir
canonical_language: "en" # selected BCP 47 tag
installed_at: "2026-05-22T00:00:00Z" # ISO 8601 UTC
updated_at: "2026-05-22T00:00:00Z" # ISO 8601 UTC

feedback:
    enabled: false

agent_skills:
    required: []

append_blocks: []

managed:
    version: 2
    repository: []
    knowledge: []
    worktrees: []

protected:
    knowledge: []

local_only:
    knowledge: []
    worktrees: []

local_overrides: []
skipped_patterns: []
```

`knowledge_dir`, `worktrees_dir`, and `canonical_language` are stable installation keys after manifest creation.
`feedback.enabled` records whether `knowledge-assistant` may write local workflow feedback under `<knowledge_dir>/.feedback/`; fresh init defaults it to `false`.
`agent_skills.required` records the required Skill names this installation expects as external runtime capabilities.

## Managed Files

Use grouped strategy sections, not one record per file:

```yaml
template_id: knowledge-workflow
template_version: 1
manifest_version: 2
knowledge_dir: knowledge # normalized repo-relative knowledge dir
worktrees_dir: .worktrees # normalized repo-relative local worktrees dir
canonical_language: "en" # selected BCP 47 tag
installed_at: "2026-05-22T00:00:00Z" # ISO 8601 UTC
updated_at: "2026-05-22T00:00:00Z" # ISO 8601 UTC

feedback:
    enabled: false

agent_skills:
    required:
        - knowledge-assistant
        - knowledge-intake
        - knowledge-capture
        - knowledge-schema-audit
        - task-metadata-audit
        - knowledge-status-report
        - workspace-worklist
        - delivery-planning
        - next-task-selection
        - kanban-maintenance
        - delivery-implementation
        - delivery-review

append_blocks:
    - path: <platform_hint_file>
      block: knowledge-workflow
      version: 1

managed:
    version: 2
    repository: []
    knowledge:
        - README.md
        - .gitignore
        - .workflow/runtime.md
        - .workflow/rules/knowledge.md
        - .workflow/rules/delivery.md
        - .workflow/rules/workspace.md
        - .workflow/schemas/**
        - .workflow/templates/**
    worktrees:
        - .gitignore

protected:
    knowledge:
        - planning/**
        - tasks/**
        - workspace/**
        - members/**
        - groups/**
        - proposals/**
        - discovery/**
        - product/**
        - design/**
        - architecture/**
        - concepts/**
        - decisions/**
        - guidelines/**

local_only:
    knowledge:
        - .workflow/local.yml
        - .feedback/**
        - workspace/*/local/**
    worktrees:
        - "**"

local_overrides: []
skipped_patterns: []
```

Use concrete values only for path anchors and repository-root paths that cannot be derived from an anchor. Required Skills are runtime capabilities but not managed project files. In the generic examples above, `<platform_hint_file>` stands for the installed root platform hint file when one is managed; the actual manifest must record the concrete file path. `canonical_language` records the explicit BCP 47 language tag for canonical knowledge files.

`managed.knowledge`, `protected.knowledge`, and `local_only.knowledge` entries are relative to `knowledge_dir`. `managed.worktrees` and `local_only.worktrees` entries are relative to `worktrees_dir`. `managed.repository` entries are repository-root-relative paths. Default `knowledge_dir: knowledge` installations use `managed.repository: []`; non-default installations record `.knowledge-workflow` under `managed.repository`.

Skeleton file `.knowledge-workflow` writes repository root `.knowledge-workflow` only for non-default `knowledge_dir` values. When created, it contains one non-empty line: the repository-relative `knowledge_dir` value without a trailing slash. Trailing blank lines are allowed.
Skeleton file `knowledge/_gitignore` copies to target `<knowledge_dir>/.gitignore`; the manifest records it as `.gitignore` under `managed.knowledge`.
Skeleton file `worktrees/_gitignore` copies to target `<worktrees_dir>/.gitignore`; the manifest records it as `.gitignore` under `managed.worktrees`.
Skeleton file `knowledge/.workflow/runtime.md` copies to target `<knowledge_dir>/.workflow/runtime.md`; the manifest records it as `.workflow/runtime.md` under `managed.knowledge`. Keep `<knowledge_dir>` and `<worktrees_dir>` placeholders in the copied file.
Skeleton file `knowledge/.workflow/local.yml` copies to target `<knowledge_dir>/.workflow/local.yml` as a local-only comment template; the manifest does not record it as managed, and `<knowledge_dir>/.gitignore` must exclude it from SCM.

`skipped_patterns` is only for workflow-scope paths that the workflow deliberately excludes during init. Do not use it to record arbitrary unrelated repository files, untracked artifacts, editor scratch files, build outputs, or project files outside the selected knowledge workflow surface.

Existing product notes, scratch files, or task items should not create new manifest patterns unless the pattern is part of the project rules or the user explicitly asks for it.

Recommended strategies:

- `managed`: owned by the workflow; create from copied skeleton files during init after dry-run confirmation.
- `append_block`: only a marked block may be inserted or updated.
- `protected`: never replace from workflow skeleton files during init.
- `local-override`: user-owned local version; skip unless the user explicitly asks for a manual merge.

## Fresh Init Values

Fresh init writes these baseline manifest values:

```yaml
template_id: knowledge-workflow
template_version: 1
manifest_version: 2
knowledge_dir: knowledge # normalized repo-relative knowledge dir
worktrees_dir: .worktrees # normalized repo-relative local worktrees dir
canonical_language: "en" # selected BCP 47 tag
installed_at: "2026-05-22T00:00:00Z" # ISO 8601 UTC
updated_at: "2026-05-22T00:00:00Z" # ISO 8601 UTC

feedback:
    enabled: false

agent_skills:
    required:
        - knowledge-assistant
        - knowledge-intake
        - knowledge-capture
        - knowledge-schema-audit
        - task-metadata-audit
        - knowledge-status-report
        - workspace-worklist
        - delivery-planning
        - next-task-selection
        - kanban-maintenance
        - delivery-implementation
        - delivery-review

append_blocks:
    - path: <platform_hint_file>
      block: knowledge-workflow
      version: 1

managed:
    version: 2
    repository: []
    knowledge:
        - README.md
        - .gitignore
        - .workflow/runtime.md
        - .workflow/rules/knowledge.md
        - .workflow/rules/delivery.md
        - .workflow/rules/workspace.md
        - .workflow/schemas/**
        - .workflow/templates/**
    worktrees:
        - .gitignore

protected:
    knowledge:
        - planning/**
        - tasks/**
        - workspace/**
        - members/**
        - groups/**
        - proposals/**
        - discovery/**
        - product/**
        - design/**
        - architecture/**
        - concepts/**
        - decisions/**
        - guidelines/**

local_only:
    knowledge:
        - .workflow/local.yml
        - .feedback/**
        - workspace/*/local/**
    worktrees:
        - "**"
```

## Marked Platform Hint Block

Root platform hint files must be handled as `append_block`. Only this marked block is managed:

```text
<!-- knowledge-workflow:start -->
...
<!-- knowledge-workflow:end -->
```

Never modify text outside this block.
