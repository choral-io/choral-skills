# Knowledge Workflow Runtime

This file is the cross-Agent runtime entry for Knowledge Workflow.

## Bootstrap

Start from the repository root.

If `.knowledge-workflow` exists, read it. Its first non-empty line is the normalized repository-relative `knowledge_dir` value. Common values are:

```text
knowledge
.
```

`knowledge` means the knowledge base lives under the default `knowledge/` directory. `.` means the repository root itself is the knowledge directory.

Ignore trailing blank lines that may be introduced by editors or formatters. Reject files with zero path lines or more than one non-empty line. Trim surrounding whitespace on the path line, convert Windows-style `\` separators to `/`, remove redundant leading `./` segments, normalize away trailing slashes, and preserve explicit root knowledge directory input as `.`. Examples: `./` -> `.`, `./knowledge/` -> `knowledge`, `knowledge/` -> `knowledge`, and `docs\knowledge\` -> `docs/knowledge`.

Reject repeated separators such as `docs//knowledge`, Windows drive paths such as `C:\knowledge`, UNC paths such as `\\server\share`, and absolute paths.

Reject empty paths, `/`, absolute paths, paths containing `..`, and paths under `.git/`, `.agents/`, `.claude/`, dependency folders, build outputs, source package directories, editor caches, or tool caches.

If `.knowledge-workflow` does not exist, use default `knowledge` only when both files exist:

```text
knowledge/.workflow/runtime.md
knowledge/.workflow/manifest.yml
```

If those files are missing, treat the repository as uninitialized and route to `knowledge-workflow-admin:init` or repair guidance. Do not search arbitrary directories for a knowledge base.

After resolving `<knowledge_dir>`, read:

1. `<knowledge_dir>/.workflow/runtime.md`
2. `<knowledge_dir>/.workflow/manifest.yml`
3. The relevant workflow rules, schemas, templates, and Skill references for the active task.

Use `manifest.yml` for installation state such as `canonical_language`, `worktrees_dir`, required Skills, feedback mode, and managed or protected workflow paths.

## Current Member

Resolve the current member id in this order:

1. Explicit member id provided by the user for the current operation.
2. `current_member.member_id` in local-only `<knowledge_dir>/.workflow/local.yml`.
3. `git config user.name` from the target repository.

Use `git config user.name` only as a member id candidate. Do not use Git email, operating system account, machine name, shell prompt, chat participant name, display name, or any other inferred identity source. Do not slugify or otherwise transform the resolved value.

If none of these sources provides a member id, stop and ask the user to provide one for the current operation, configure `current_member.member_id` in local-only `<knowledge_dir>/.workflow/local.yml`, or set the repository Git `user.name`.

After resolving a member id, verify that `<knowledge_dir>/members/<member-id>.md` exists before writing member-scoped metadata or local workspace files. If it does not exist, stop and report a diagnostic instead of writing to a guessed member path.

## Local-Only State

The following paths are local-only and must stay excluded from SCM:

- `<knowledge_dir>/.workflow/local.yml`
- `<knowledge_dir>/.feedback/`
- `<knowledge_dir>/workspace/*/local/`
- `<worktrees_dir>/`

`<knowledge_dir>/.workflow/local.yml` defaults to comments only and currently supports only the local current-member override:

```yaml
current_member:
    member_id: Gavroche
```

Local-only state may guide personal execution preferences and temporary context, but it must not override project facts, workflow rules, schemas, task acceptance criteria, safety, privacy, approval gates, or review requirements.

## Platform Hints

Root Agent instruction files may point Agents to the runtime bootstrap rules and this runtime file, but this runtime file and the workflow manifest are the source for runtime discovery.
