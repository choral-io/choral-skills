# Manifest

The target repository stores installation state at:

```text
<knowledge_dir>/.workflow/manifest.yml
```

## Required Fields

```yaml
template_id: knowledge-workflow
template_version: 1
manifest_version: 1
knowledge_dir: <knowledge_dir>
worktree_dir: <worktree_dir>
canonical_language: "<bcp47>"
feedback:
    enabled: false
agent_skills:
    required: []
installed_at: "<iso8601>"
updated_at: "<iso8601>"
append_blocks: []
managed:
    version: 1
    paths: []
protected: []
local_overrides: []
skipped_patterns: []
```

`knowledge_dir`, `worktree_dir`, and `canonical_language` are stable installation keys after manifest creation.
`feedback.enabled` records whether `knowledge-assistant` may write local workflow feedback under `<knowledge_dir>/.feedback/`; fresh init defaults it to `false`.
`agent_skills.required` records the required Skill names this installation expects as external runtime capabilities.

## Managed Files

Use grouped strategy sections, not one record per file:

```yaml
template_id: knowledge-workflow
template_version: 1
manifest_version: 1
knowledge_dir: <knowledge_dir>
worktree_dir: <worktree_dir>
canonical_language: "<bcp47>"
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
installed_at: "<iso8601>"
updated_at: "<iso8601>"

append_blocks:
    - path: AGENTS.md
      block: knowledge-workflow
      version: 1

managed:
    version: 1
    paths:
        - <knowledge_dir>/.gitignore
        - <worktree_dir>/.gitignore
        - <knowledge_dir>/README.md
        - <knowledge_dir>/.workflow/rules/knowledge.md
        - <knowledge_dir>/.workflow/rules/delivery.md
        - <knowledge_dir>/.workflow/rules/workspace.md
        - <knowledge_dir>/.workflow/schemas/README.md
        - <knowledge_dir>/.workflow/schemas/architecture.md
        - <knowledge_dir>/.workflow/schemas/common.md
        - <knowledge_dir>/.workflow/schemas/concepts.md
        - <knowledge_dir>/.workflow/schemas/decisions.md
        - <knowledge_dir>/.workflow/schemas/design.md
        - <knowledge_dir>/.workflow/schemas/discovery.md
        - <knowledge_dir>/.workflow/schemas/groups.md
        - <knowledge_dir>/.workflow/schemas/guidelines.md
        - <knowledge_dir>/.workflow/schemas/members.md
        - <knowledge_dir>/.workflow/schemas/planning.md
        - <knowledge_dir>/.workflow/schemas/product.md
        - <knowledge_dir>/.workflow/schemas/proposals.md
        - <knowledge_dir>/.workflow/schemas/sprints.md
        - <knowledge_dir>/.workflow/schemas/tasks.md
        - <knowledge_dir>/.workflow/schemas/workspace.md
        - <knowledge_dir>/.workflow/templates/group.md
        - <knowledge_dir>/.workflow/templates/member.md
        - <knowledge_dir>/.workflow/templates/proposal.md
        - <knowledge_dir>/.workflow/templates/worklist.md
        - <knowledge_dir>/.workflow/templates/handoff.md
        - <knowledge_dir>/.workflow/templates/task.md

protected:
    - <knowledge_dir>/planning/KANBAN.md
    - <knowledge_dir>/planning/**
    - <knowledge_dir>/tasks/**
    - <knowledge_dir>/workspace/**
    - <knowledge_dir>/workspace/*/local/**
    - <knowledge_dir>/members/**
    - <knowledge_dir>/groups/**
    - <knowledge_dir>/proposals/**
    - <knowledge_dir>/discovery/**
    - <knowledge_dir>/product/**
    - <knowledge_dir>/design/**
    - <knowledge_dir>/architecture/**
    - <knowledge_dir>/concepts/**
    - <knowledge_dir>/decisions/**
    - <knowledge_dir>/guidelines/**

local_overrides: []
skipped_patterns: []
```

Use rendered target paths, not placeholder paths, in the manifest. Required Skills are runtime capabilities but not managed project files. Render `<worktree_dir>` to the selected local-only worktree directory. `canonical_language` records the explicit BCP 47 language tag for canonical knowledge files.

Skeleton file `knowledge/_gitignore` renders to target `<knowledge_dir>/.gitignore`; the manifest records the rendered target path.
Skeleton file `worktrees/_gitignore` renders to target `<worktree_dir>/.gitignore`; the manifest records the rendered target path.

`skipped_patterns` is only for workflow-scope paths that the workflow deliberately excludes during init. Do not use it to record arbitrary unrelated repository files, untracked artifacts, editor scratch files, build outputs, or project files outside the selected knowledge workflow surface.

Existing product notes, scratch files, or task items should not create new manifest patterns unless the pattern is part of the project rules or the user explicitly asks for it.

Recommended strategies:

- `managed`: owned by the workflow; create from rendered skeleton files during init after dry-run confirmation.
- `append_block`: only a marked block may be inserted or updated.
- `protected`: never replace from workflow skeleton files during init.
- `local-override`: user-owned local version; skip unless the user explicitly asks for a manual merge.

## Fresh Init Values

Fresh init writes these baseline manifest values:

```yaml
template_version: 1
manifest_version: 1
knowledge_dir: <knowledge_dir>
worktree_dir: <worktree_dir>
canonical_language: "<bcp47>"
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
    - path: AGENTS.md
      block: knowledge-workflow
      version: 1
managed:
    version: 1
```

## Marked AGENTS Block

Root `AGENTS.md` must be handled as `append_block`. Only this marked block is managed:

```text
<!-- knowledge-workflow:start -->
...
<!-- knowledge-workflow:end -->
```

Never modify text outside this block.
