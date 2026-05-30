# Repository Guidelines

## Repository Purpose

This repository distributes public Agent Skills from Choral. It is not a product repository and must not become a project knowledge base.

Current Skills include a repository-backed workflow suite and tool-focused Skills, but this repository is a general public Skills collection.

## Layout

- `skills/<skill-name>/SKILL.md` is the required entry point for each Skill.
- `skills/<skill-name>/agents/openai.yaml` stores optional OpenAI/Codex UI metadata.
- `skills/<skill-name>/references/` stores supporting instructions loaded only when needed.
- `skills/<skill-name>/scripts/`, templates, skeletons, or other bundled resources are optional and must be documented by that Skill.
- `.agents/plugins/marketplace.json` exposes repository plugins to Codex.
- `plugins/<plugin-name>/` stores installation-ready Codex plugin packages.
- `plugins/plugin-sync.txt` declares which root Skills are materialized into each plugin package.
- `scripts/sync-codex-plugin-skills.sh` and `scripts/sync-codex-plugin-skills.ps1` refresh or check plugin Skill copies without assuming Python.

## Skill Authoring Rules

- Each Skill must be installable and understandable from its own `SKILL.md`.
- Treat `SKILL.md` frontmatter `name` and `description` as the cross-Agent discovery contract.
- Keep `description` short, accurate, and trigger-oriented because it appears in Skill-selection context.
- Prefer references for detailed guidance and keep `SKILL.md` focused on core behavior and routing.
- Do not assume target projects use a specific runtime, package manager, shell, editor, build system, or directory layout.
- Keep platform-specific metadata optional and only add files that an actual runtime or adapter consumes.
- Do not make core behavior depend on `agents/openai.yaml`; Claude Code, Gemini CLI, Codex, and other runtimes should be able to follow the Skill from `SKILL.md` plus bundled resources.
- When changing a Skill description, apply `QUALITY.md` and consider realistic should-trigger and should-not-trigger examples so the description stays precise without becoming broad.
- For maintainer-only or manual-only Skills, keep the safety boundary in `SKILL.md` and use platform metadata only as reinforcement, such as Codex `allow_implicit_invocation: false`. Avoid hard-disabling model invocation in distributable Skills unless the Skill is truly human-only and should not be packaged for Agent execution.

## Cross-Agent Portability

- Use the common Skill structure: `SKILL.md`, optional `references/`, and optional `scripts/`.
- Put mandatory routing and safety boundaries in `SKILL.md`, not platform metadata.
- Keep platform names out of procedural instructions unless the step is explicitly platform-specific.
- If a Skill needs a script or command example, make the dependency explicit and offer a manual fallback when practical.
- Keep evaluation artifacts, benchmark workspaces, generated reports, and local test outputs outside published Skill directories unless they are intentional examples.

## Public Content Boundary

- Do not add product-specific names, source package paths, customer facts, task ids, private member details, personal notes, local workspace files, or absolute machine paths.
- Keep examples generic. Use placeholder paths and ids only when they are clearly examples.
- Do not add local-only files such as `.DS_Store`, generated reports, or test worktrees.

## Suite Boundaries

- Keep suite-specific behavior in the owning Skill docs; `AGENTS.md` only preserves repository-wide release boundaries.
- Maintainer-only or manual-only Skills must remain clearly separated from ordinary team help.
- Read-only Skills must stay read-only.
- Write-capable Skills must keep their approval, ownership, and local-only boundaries.

## README Sync

When adding, removing, or changing a Skill:

- Update the `README.md` Skills table.
- Prefer the Skill's frontmatter `name` and `description` for table content.
- Keep the `Audience` value concise and user-facing.

## Codex Plugin Maintenance

When changing a Skill that is listed in `plugins/plugin-sync.txt`:

- Treat `skills/<skill-name>/` as the canonical source.
- Refresh the materialized plugin copy with `./scripts/sync-codex-plugin-skills.sh <plugin-name>` or `.\scripts\sync-codex-plugin-skills.ps1 <plugin-name>`.
- Run the corresponding check mode before finishing: `./scripts/sync-codex-plugin-skills.sh --check <plugin-name>` or `.\scripts\sync-codex-plugin-skills.ps1 -Check <plugin-name>`.
- Do not use symlinks inside `plugins/<plugin-name>/skills/`; Codex plugin installation caches materialized files and can drop linked Skill contents.

When adding, removing, or renaming a Codex plugin:

- Update `.agents/plugins/marketplace.json`.
- Update `plugins/plugin-sync.txt` when the plugin packages root Skills.
- Update the Codex Plugin Installation section in `README.md`.
- Validate the plugin manifest before handoff with the plugin validator when available.

## Checks

Before committing:

- Run a formatter over changed Markdown/YAML files when one is available.
- Search `skills/` for project-specific residue.
- If plugin-packaged Skills changed, run the plugin sync check for affected plugins.
- For suite-level changes, re-check that maintainer-only, read-only, write-capable, and local-only boundaries still hold.
- Commit only intentional skill distribution changes.
