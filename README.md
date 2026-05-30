# Choral Skills

Public Agent Skills from [Choral](https://github.com/choral-io).

This repository is not tied to a specific product repository. Each directory under `skills/` is a reusable Skill that can be installed into an Agent runtime that supports local Skills.

## Skill Groups

### Knowledge Workflow Skills

This series supports repository-backed knowledge governance: setup, guidance, intake, capture, audits, status reporting, delivery planning, implementation, review, and local execution. See [Knowledge Workflow Skills Overview](docs/knowledge-workflow-skills.md) for the knowledge model, recommended Skill sets, setup guidance, boundaries, and upgrade guidance.

| Skill                      | Description                                                                                                                                                                                               | Audience           |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| `knowledge-workflow-admin` | Use when a maintainer explicitly asks for Knowledge Workflow setup, checks, upgrade migration, manifest work, or approved configuration updates.                                                          | Maintainer         |
| `knowledge-assistant`      | Use when a user asks how to use Knowledge Workflow in a repository, where content belongs, which skill applies, what project rules mean, how to recover safely, or how to record local workflow feedback. | Team               |
| `knowledge-intake`         | Use when an idea, requirement, feedback, research note, decision, or fact may become shared knowledge but the target is not yet approved.                                                                 | Team               |
| `knowledge-capture`        | Use when the user has approved a specific shared-knowledge write, promotion, reorganization, or update.                                                                                                   | Team               |
| `knowledge-schema-audit`   | Use when non-task knowledge needs a read-only check for schema, frontmatter, localization, links, or consistency.                                                                                         | Read-only          |
| `task-metadata-audit`      | Use when task items or Kanban links need a read-only check for readiness, dependencies, issues, acceptance, or board consistency.                                                                         | Read-only          |
| `knowledge-status-report`  | Use when the user asks for a read-only summary of knowledge health, delivery progress, decisions, queues, ownership, blockers, or risks.                                                                  | Read-only          |
| `delivery-planning`        | Use when delivery work needs a proposal before editing task candidates, Kanban cards, backlog shape, or board changes.                                                                                    | Delivery           |
| `next-task-selection`      | Use when the user asks which accepted Kanban task to work on next and dependencies or readiness may affect the answer.                                                                                    | Delivery           |
| `kanban-maintenance`       | Use when the user has approved adding, moving, or updating cards on the repository Kanban board.                                                                                                          | Delivery           |
| `delivery-implementation`  | Use when the user asks to implement an approved Kanban task or linked project change with clear acceptance criteria.                                                                                      | Delivery           |
| `delivery-review`          | Use when delivery work needs review, a PR or local diff needs validation, or Done readiness is in question.                                                                                               | Delivery, review   |
| `workspace-worklist`       | Use when the current member asks to manage or run their local WORKLIST, including run-next, run-loop, run-goal, plan-only, grooming, or logs.                                                             | Personal execution |

### Tool Skills

| Skill            | Description                                                                                                                              | Audience |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| `markitdown-cli` | Use when converting local document files such as PDFs, Office documents, HTML, text, or other MarkItDown-supported inputs into Markdown. | Team     |

## Skill Installation

Install or copy the needed `skills/<skill-name>/` directories into the Skill location supported by your Agent runtime. This repository does not assume a specific Agent program, package manager, editor, shell, or runtime.

Recommended options:

- Use the Vercel Labs Skills CLI for cross-Agent installation from a Git repository:

    ```bash
    npx skills add <owner>/<repo>
    ```

    The Skills CLI and [skills.sh](https://skills.sh/) are part of the [vercel-labs/skills](https://github.com/vercel-labs/skills) project.

- Use your Agent runtime's native Skill or plugin manager when available.
- For runtimes without a manager, manually copy the needed `skills/<skill-name>/` directories into the runtime's configured Skill directory.

Treat third-party Skill managers and downloaded Skills as code: inspect `SKILL.md`, scripts, and bundled assets before installing.

## Plugin Installation

Agent runtimes with plugin support can install packaged plugins from this repository's marketplace.

Add the marketplace once:

| Runtime     | Command                                                 |
| ----------- | ------------------------------------------------------- |
| Claude Code | `claude plugin marketplace add choral-io/choral-skills` |
| Codex       | `codex plugin marketplace add choral-io/choral-skills`  |

Then install the plugin you need:

| Runtime     | Command                                             |
| ----------- | --------------------------------------------------- |
| Claude Code | `claude plugin install <plugin-name>@choral-skills` |
| Codex       | `codex plugin add <plugin-name>@choral-skills`      |

Available plugins:

| Plugin               | Runtimes           | Description                                                  |
| -------------------- | ------------------ | ------------------------------------------------------------ |
| `knowledge-workflow` | Claude Code, Codex | Knowledge Workflow governance Skills packaged as one plugin. |

After installing or updating the plugin, start a new Agent session so the newly installed Skills are loaded.

To refresh marketplace metadata and reinstall an existing plugin:

Claude Code:

```bash
claude plugin marketplace update
claude plugin install <plugin-name>@choral-skills
```

Codex:

```bash
codex plugin marketplace upgrade
codex plugin add <plugin-name>@choral-skills
```

For local development from a checkout:

Claude Code:

```bash
claude plugin marketplace add /path/to/choral-skills
claude plugin install <plugin-name>@choral-skills
```

Codex:

```bash
codex plugin marketplace add /path/to/choral-skills
codex plugin add <plugin-name>@choral-skills
```

Plugin contents under `plugins/` are installation-ready. When a plugin packages selected Skills from the root `skills/` directory, update the canonical Skill files first and then refresh the plugin copy before release. Plugin Skill membership is declared in `plugins/plugin-sync.txt`.

```bash
./scripts/sync-plugin-skills.sh knowledge-workflow
./scripts/sync-plugin-skills.sh --check knowledge-workflow
```

On Windows PowerShell:

```powershell
.\scripts\sync-plugin-skills.ps1 knowledge-workflow
.\scripts\sync-plugin-skills.ps1 -Check knowledge-workflow
```

Sparse checkout installs only need the marketplace metadata and selected plugin wrapper:

```bash
claude plugin marketplace add choral-io/choral-skills \
    --sparse .claude-plugin plugins/knowledge-workflow

codex plugin marketplace add choral-io/choral-skills \
    --sparse .agents \
    --sparse plugins/knowledge-workflow
```

## Cross-Agent Compatibility

`SKILL.md` is the portable contract. Each Skill keeps its required `name` and `description` frontmatter plus concise Markdown instructions in the Skill body. Platform-specific files are optional enhancements:

- `agents/openai.yaml` is OpenAI/Codex UI metadata.
- Claude Code, Gemini CLI, and other Agent runtimes should be able to use each Skill from `SKILL.md` plus optional bundled resources such as `references/`.
- Keep runtime-specific guidance in docs, references, or runtime adapters instead of making the core Skill depend on one Agent program.

## Maintainers

Use [QUALITY.md](QUALITY.md) before changing Skill descriptions or preparing a public release.
