---
name: knowledge-workflow-admin
description: Use when a maintainer explicitly needs Knowledge Workflow setup, checks, manifest work, or approved configuration updates.
disable-model-invocation: true
---

# Knowledge Workflow Admin

Use this maintainer skill to install or administer the knowledge workflow in a target repository when a maintainer explicitly selects it.

This maintainer skill should run from an external installed copy. It supports fresh init, checks, manifest work, and approved configuration management.

## References

Read only the reference needed for the active mode:

- `references/help.md`: maintainer help for this Skill.
- `references/install.md`: skeleton rendering, render inventory, init, and workflow checks.
- `references/manifest.md`: manifest fields and managed-file tracking.
- `references/config.md`: configuration design and approved update workflow.

## Modes

- `help`: explain this maintainer skill's modes, boundaries, and safe next setup step.
- `init`: create a new workflow installation.
- `check`: run read-only workflow checks, including required Skill availability.
- `config`: design, update, or save approved configuration in the manifest or root `AGENTS.md`.

Infer the mode from the user's request. If ambiguous, state the assumed mode before acting. If the user asks ordinary workflow help, routing, onboarding, or recovery questions, recommend `knowledge-assistant` instead of using this maintainer skill.

## Help Workflow

Use `help` only for questions about this maintainer skill itself, such as when to initialize, how to run checks, how the manifest is managed, or how maintainer configuration updates should be handled.

1. Read `references/help.md`.
2. If the question concerns an already initialized repository, read root `AGENTS.md` and `<knowledge_dir>/.workflow/manifest.yml` before answering.
3. Give the safest maintainer next step and name whether the operation is read-only, dry-run-only, or write-capable after approval.
4. Route ordinary team workflow usage, content placement, recovery, and skill routing questions to `knowledge-assistant`.

## Ordinary Help Boundary

Use `knowledge-assistant` for ordinary team-facing help, onboarding, skill routing, content placement, read-only project rules explanation, and recovery diagnosis.

This skill may answer setup/admin questions needed to run `init`, `check`, or approved `config` work. It must not become the ordinary distributed help surface for team members.

## Config Workflow

Use `config` only when the user explicitly asks to define, update, or save configuration. Read `references/config.md`, summarize current configuration first, produce a dry run, and require approval before writing the manifest or root `AGENTS.md`.

## Init Workflow

Use `init` only for a maintainer-approved workflow installation. Read `references/install.md`, resolve required parameters, build a dry run, require approval, then write files and validate the completed installation. Do not silently default canonical language.

## Check Workflow

Use `check` when the user asks to verify workflow setup, manifest consistency, managed/protected paths, root `AGENTS.md` workflow context, or required Skill availability. Read `references/install.md`; report missing Skills with installation advice. Do not copy Skills into the target repository.

## Guardrails

- Do not copy business drafts, member-specific notes, editor settings, package scripts, or project-specific build commands into the workflow skeleton.
- Do not record unrelated repository files, dirty worktree artifacts, or untracked project files in the manifest.
- Do not add protected or skipped patterns just because matching project documents currently exist. Add them only when they are part of the project rules or the user explicitly configures them.
- Keep `<worktree_dir>/` local-only. It holds reusable worktrees and should contain a `.gitignore` that ignores worktree contents.
- Require the installed manifest to record an explicit `canonical_language`; do not infer it from current skeleton language or local user locale.
- Keep the installed workflow Markdown-first, Foam-compatible, and Obsidian-readable without plugin-only syntax.
- For full installation guardrails, read `references/install.md`.
