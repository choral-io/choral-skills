<!-- knowledge-workflow:start -->

## Knowledge Workflow

### Required Context

- Knowledge directory: `{{knowledge_dir}}/`.
- Read `{{knowledge_dir}}/.workflow/manifest.yml` before workflow work; use its `knowledge_dir`, `agent_skills.required`, `worktree_dir`, and `canonical_language: {{canonical_language}}` values.
- Determine the current member id with `git config user.name`; do not infer it from OS, machine, shell, or chat names.
- Before writing knowledge, read `{{knowledge_dir}}/schemas/common.md` and the relevant `{{knowledge_dir}}/schemas/*.md`; before changing delivery cards, read `{{knowledge_dir}}/planning/WORKFLOW.md`.
- When member context matters, prefer section-scoped reads from `{{knowledge_dir}}/members/<member-id>.md`; read `{{knowledge_dir}}/workspace/<member-id>/local/AGENTS.md` when acting on that member's local workspace, worklist, or personal execution style.

### Boundaries

- Treat `{{knowledge_dir}}/` and code as project facts; treat `{{knowledge_dir}}/planning/KANBAN.md` as delivery status.
- Apply scope precedence from `{{knowledge_dir}}/schemas/common.md`; stop and report conflicts that affect facts, delivery scope, permissions, review, ownership, or another member.
- Treat `{{knowledge_dir}}/proposals/` as a review buffer, not as facts, decisions, task items, or delivery commitments until converted.
- Keep localized files as translations only; never store secrets or private notes in `{{knowledge_dir}}/`.
- Treat `{{knowledge_dir}}/workspace/<member-id>/local/` and worktree contents under `{{worktree_dir}}/` as local-only state; never stage or commit them. The managed `{{worktree_dir}}/.gitignore` may be tracked.
- Share member workspace material through `summaries/`, `handoffs/`, and `research/`; keep raw captures and personal drafts under `local/`.
- Do not assign work by writing into another member's workspace. Use task items with `assignees` and approved Kanban updates.

### Skill Usage

- Use the platform Skill loader. Required Skills are external runtime capabilities listed in manifest `agent_skills.required`; do not copy or manage Skill files inside this repository.
- Use `knowledge-assistant` for workflow help, routing, recovery, and project rules explanation; otherwise use the specific Skill whose description matches the request.
- Use `knowledge-intake` before unapproved knowledge writes, `knowledge-capture` only after approval, audit skills read-only, and `knowledge-workflow-admin` only by explicit maintainer choice.

### Delivery And Local Execution

- Accepted delivery work is tracked by thin cards in `{{knowledge_dir}}/planning/KANBAN.md` linked to task items under `{{knowledge_dir}}/tasks/`.
- Use `delivery-planning` for proposed task/card changes, `kanban-maintenance` only after approval, and `delivery-review` before moving changed delivery work to Done.
- Use `workspace-worklist:intake-task` when taking a Kanban card into the current member's local execution flow.
- `run-goal` coordinates accepted Kanban/worklist tasks toward review readiness; it is not open-ended product discovery.
- `auto-review` is a workflow approval mode, not a sandbox or host-permission mode. If project rules are missing or partial, keep broad or unspecified auto-review to low-risk actions and ask a maintainer to define a stable rule set.
- Optional execution-method tools, including Superpowers, may help with planning, TDD, debugging, verification, worktrees, or authorized parallel agents, but they do not replace Knowledge Workflow ownership, gates, or review.

### Formatting, Git, And Safety

- The workflow must not depend on a specific runtime, language, package manager, shell, or script file.
- When doing actual project work, Agents may detect and use tools already available in the project or environment.
- For knowledge-only changes, use or suggest the project's available Markdown formatter/checker for supported knowledge and template files: `{{knowledge_dir}}/**/*.md` and `{{knowledge_dir}}/**/*.mdx`.
- Commit only files intentionally changed for the current task; leave unrelated dirty files untouched.
- Before staging knowledge changes, confirm the staged diff excludes `{{knowledge_dir}}/workspace/*/local/**` and worktree contents under `{{worktree_dir}}/`, except the managed `{{worktree_dir}}/.gitignore`.

### Project-Specific Rules

Add project-specific rules here. This protected local subsection must remain the final `###` heading inside the `Knowledge Workflow` block.

Project-specific rules may specialize workflow behavior, but they must not weaken core safety, ownership, privacy, local-only, approval, or review rules. Use `knowledge-assistant` to explain or audit project-specific rules. Maintainers must manually choose `knowledge-workflow-admin:config` when the user asks to update or save configuration or project rules.

<!-- knowledge-workflow:end -->
