# Project Guidance

Use this for status reports, project rules, installation help, and unsafe shortcut warnings.

## Status Reports

For project status, delivery progress, decisions, requirements, ownership, or risks, recommend `knowledge-status-report`.

Ask it to choose the narrowest useful scope, state `Reliability: high | medium | low`, label counts as `field-based`, `board-based`, `git-based`, or `inferred`, and list source paths. If the user asks to report and fix, report first; route approved fixes to the owning skill.

Use predefined report templates for weekly delivery, knowledge health, proposal/decision queue, member workload, and blocked work reports.

## Project Rules

Use `knowledge-assistant` to understand or audit project-specific rules in root `AGENTS.md`. Ask a maintainer to use `knowledge-workflow-admin:config` only to define, update, or save project rules.

Rule topics include auto-review, approval gates, protected surfaces, validation baseline, Kanban automation, git/worktree automation, source stability, and parallel/subagent execution.

Project rules answers are read-only. Do not ask teams to configure auto-review unless they request auto-review or another workflow discovers that auto-review rules are missing and the user chooses to define a stable rule set.

## Premature Actions

Call out these unsafe jumps:

- raw idea directly to Kanban
- proposal treated as fact, accepted decision, task item, or delivery commitment
- local notes used as team planning source
- localized file used as canonical source
- board edit without approved maintenance
- work assigned to another member started without second confirmation
- multi-item or parallel execution without explicit budget
- Done move without review when delivery changed
- changing `knowledge_dir`, `agent_skills.required`, `worktree_dir`, or `canonical_language` after init

## Installation Help

For workflow installation questions, answer read-only and route maintainer work to `knowledge-workflow-admin`:

- Maintainer workflow administration creates or checks a Knowledge Workflow installation.
- Init records the required Skills and checks whether the current Agent can load the complete required set.
- Missing required Skills should be installed through the Agent runtime's Skill installation mechanism, not copied into the target repository.
- Root `AGENTS.md` receives only the marked workflow block.
- The final `### Project-Specific Rules` heading inside that block is protected local project space.
- The manifest is workflow state created by init.
- For validation, use a fresh test repository or explicit manual cleanup instead of rewriting an existing installation from help mode.
- Supported Markdown knowledge text extensions are `.md` and `.mdx`.
- Files under `templates/` are Markdown templates, not project facts, task inputs, delivery candidates, or graph nodes.
- Editor settings are optional and unmanaged. If the user asks for editor setup, recommend excluding `templates/` from Foam graph scanning when possible and configuring any available Markdown formatter such as Prettier for Markdown files.
