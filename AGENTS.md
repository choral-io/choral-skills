# Repository Guidelines

## Repository Purpose

This repository distributes public Agent Skills from Choral. It is not a product repository and must not become a project knowledge base.

Current Skills include a repository-backed knowledge workflow suite, but future public Choral Skills may cover other domains.

## Layout

- `skills/<skill-name>/SKILL.md` is the required entry point for each Skill.
- `skills/<skill-name>/agents/openai.yaml` stores optional OpenAI/Codex UI metadata.
- `skills/<skill-name>/references/` stores supporting instructions loaded only when needed.
- `skills/knowledge-workflow-admin/skeleton/` stores the Knowledge Workflow skeleton rendered during init.

## Skill Authoring Rules

- Each Skill must be installable and understandable from its own `SKILL.md`.
- Treat `SKILL.md` frontmatter `name` and `description` as the cross-Agent discovery contract.
- Keep `description` short, accurate, and trigger-oriented because it appears in Skill-selection context.
- Prefer references for detailed guidance and keep `SKILL.md` focused on core behavior and routing.
- Do not assume target projects use a specific runtime, package manager, shell, editor, build system, or directory layout.
- Keep platform-specific metadata optional and only add files that an actual runtime or adapter consumes.
- Do not make core behavior depend on `agents/openai.yaml`; Claude Code, Gemini CLI, Codex, and other runtimes should be able to follow the Skill from `SKILL.md` plus bundled resources.
- When changing a Skill description, apply `QUALITY.md` and consider realistic should-trigger and should-not-trigger examples so the description stays precise without becoming broad.
- For maintainer-only or manual-only Skills, keep the safety boundary in `SKILL.md` and use platform metadata only as reinforcement, such as Codex `allow_implicit_invocation: false` or Claude Code `disable-model-invocation: true`.

## Cross-Agent Portability

- Use the common Skill structure: `SKILL.md`, optional `references/`, and optional `scripts/`.
- Put mandatory routing and safety boundaries in `SKILL.md`, not platform metadata.
- Keep platform names out of procedural instructions unless the step is explicitly platform-specific.
- If a Skill needs a script or command example, make the dependency explicit and offer a manual fallback when practical.
- Keep evaluation artifacts, benchmark workspaces, generated reports, and local test outputs outside published Skill directories unless they are intentional examples.

## Public Content Boundary

- Do not add product-specific names, source package paths, customer facts, task ids, private member details, personal notes, local workspace files, or absolute machine paths.
- Keep examples generic. Use placeholder paths such as `<knowledge_dir>` and example member ids only when they are clearly examples.
- Do not add local-only files such as `.DS_Store`, `.worktrees/`, generated reports, or test worktrees.

## Knowledge Workflow Suite Rules

- `knowledge-assistant` is the ordinary team-facing help entry point. It must not modify shared knowledge or workflow state; its only write exception is explicit-only local workflow feedback under SCM-excluded `.feedback/` when manifest feedback mode is enabled.
- `knowledge-workflow-admin` is the maintainer/admin entry point for setup, manifest state, workflow checks, and approved configuration updates. It must not become ordinary team help.
- Audit Skills must remain read-only.
- Write-capable workflow Skills must preserve their approval and ownership boundaries.
- `workspace-worklist` owns current-member local execution flow and must not write into another member's workspace.

## README Sync

When adding, removing, or changing a Skill:

- Update the `README.md` Skills table.
- Prefer the Skill's frontmatter `name` and `description` for table content.
- Keep the `Audience` value concise and user-facing.

## Checks

Before committing:

- Run a formatter over changed Markdown/YAML files when one is available.
- Search `skills/` for project-specific residue.
- Verify `knowledge-workflow-admin` remains maintainer-scoped and `allow_implicit_invocation` stays disabled.
- Verify `knowledge-workflow-admin` keeps `disable-model-invocation: true` in `SKILL.md`.
- Verify `knowledge-assistant` does not modify shared knowledge or workflow state, and any local feedback path remains manifest-gated and SCM-excluded.
- Commit only intentional skill distribution changes.
