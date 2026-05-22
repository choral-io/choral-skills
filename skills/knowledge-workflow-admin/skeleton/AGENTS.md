<!-- knowledge-workflow:start -->

## Knowledge Workflow

This repository uses Knowledge Workflow.

Resolve `<knowledge_dir>` from repository root `.knowledge-workflow` when present. If it is absent, use default `knowledge` only when `knowledge/.workflow/runtime.md` and `knowledge/.workflow/manifest.yml` both exist. Then read `<knowledge_dir>/.workflow/runtime.md` before workflow work. Runtime, manifest, rules, schemas, and Skill instructions are the source of truth.

Core boundaries:

- Do not guess workflow paths, current member id, or local-only paths.
- Do not write shared knowledge, Kanban, task metadata, or workflow state without the owning Skill and required approval.
- Keep `<knowledge_dir>/.workflow/local.yml`, `<knowledge_dir>/.feedback/`, `<knowledge_dir>/workspace/*/local/`, and worktree contents under `<worktrees_dir>/` local-only.
- Use `knowledge-assistant` for workflow help, routing, recovery, and project rules explanation; otherwise use the specific Skill whose description matches the request.
- Use `knowledge-workflow-admin` only for explicit maintainer setup, check, migration, manifest, or approved configuration work.

### Project-Specific Rules

Project-specific rules may specialize workflow behavior, but they must not weaken runtime, safety, ownership, privacy, local-only, approval, or review rules.

<!-- knowledge-workflow:end -->
