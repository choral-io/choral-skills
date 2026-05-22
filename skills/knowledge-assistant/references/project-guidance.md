# Project Guidance

Use this for status reports, project rules, local workflow feedback, installation help, and unsafe shortcut warnings.

## Status Reports

For project status, delivery progress, decisions, requirements, ownership, or risks, recommend `knowledge-status-report`.

Ask it to choose the narrowest useful scope, state `Reliability: high | medium | low`, label counts as `field-based`, `board-based`, `path-based`, `link-based`, `git-based`, or `inferred`, and list source paths. If the user asks to report and fix, report first; route approved fixes to the owning skill.

Use predefined report templates for weekly delivery, knowledge health, proposal/decision queue, member workload, and blocked work reports.

## Project Rules

Use `knowledge-assistant` to understand or audit project-specific rules in root `AGENTS.md`. Ask a maintainer to use `knowledge-workflow-admin:config` only to define, update, or save project rules.

Rule topics include auto-review, approval gates, protected surfaces, validation baseline, Kanban automation, git/worktree automation, source stability, and parallel/subagent execution.

Project rules answers are read-only. Do not ask teams to configure auto-review unless they request auto-review or another workflow discovers that auto-review rules are missing and the user chooses to define a stable rule set.

## Local Workflow Feedback

Use `.feedback/` only for feedback about Knowledge Workflow itself: missing guidance, confusing routing, weak schema behavior, repeated recovery friction, or improvement ideas for the Skill suite. Do not use it for product facts, customer feedback, delivery notes, task evidence, accepted decisions, project rules, or team knowledge.

Feedback capture is explicit-only. Do not infer it from complaints, confusion, bug reports, suggestions, repeated friction, or optimization discussions. Do not proactively suggest feedback capture in ordinary help, routing, recovery, review, or check answers; the flow consumes user attention and Agent tokens.

`knowledge-assistant` may create feedback only when manifest `feedback.enabled` is `true` and the user explicitly asks to record feedback. Before writing:

- resolve `<knowledge_dir>` from root `AGENTS.md` and the manifest;
- explain feedback mode before recording or enabling it:
    - feedback is local workflow-improvement material, not project knowledge;
    - feedback is written under `<knowledge_dir>/.feedback/`;
    - feedback is not telemetry and is not automatically sent to Choral, GitHub, a registry, or any external service;
    - users can review the full feedback file before using it to create an issue, PR, or upstream contribution;
    - sensitive data, secrets, private customer details, and unrelated project facts should not be recorded;
- verify manifest `feedback.enabled` is `true`;
- verify `<knowledge_dir>/.gitignore` excludes `.feedback/`;
- if feedback mode is disabled, ask whether to enable it only because the user explicitly requested feedback capture. Do not write feedback yet;
- after the user confirms enablement, provide a concrete `knowledge-workflow-admin:config` prompt and stop; do not continue into the write-capable Skill in the same invocation;
- after the admin config change is approved and applied, continue the feedback flow only when the user asks again to record the feedback;
- if exclusion is missing or unclear, do not write feedback; ask a maintainer to update the installation with `knowledge-workflow-admin:config`;
- create `<knowledge_dir>/.feedback/` only after the exclusion check passes.

Use this enablement prompt shape when feedback is requested but disabled:

```md
## Feedback Mode

Feedback mode records local notes about improving Knowledge Workflow under `<knowledge_dir>/.feedback/`.

It does not modify shared project knowledge or delivery state. It does not automatically submit telemetry, issues, pull requests, or any content to an external service. You can review the complete feedback file before deciding whether to share or upstream it.

Do not include secrets, private customer data, unrelated product facts, or personal notes.

Feedback mode is currently disabled in `<knowledge_dir>/.workflow/manifest.yml`.

## Confirmation Needed

Should I enable feedback mode by setting `feedback.enabled: true` through `knowledge-workflow-admin:config`? After that change is approved and applied, ask me again to record this feedback.
```

Use a dated file such as `<knowledge_dir>/.feedback/YYYY-MM-DD-<short-slug>.md`. Keep the content public-safe and repository-relative:

```md
---
type: workflow-feedback
scope: local-project | reusable-workflow | public-skill
status: open

related_skill:
    - knowledge-assistant

created_at: YYYY-MM-DD
---

# <Feedback Title>

## Situation

## Friction Or Failure

## Suggested Improvement

## Evidence

## Upstream Candidate
```

Treat feedback files as local learning material and possible PR preparation notes. They are not telemetry, not automatically submitted upstream, and not accepted workflow changes.

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
- Files under `.workflow/templates/` are Markdown templates, not project facts, task inputs, delivery candidates, or graph nodes.
- Editor settings are optional and unmanaged. If the user asks for editor setup, recommend excluding `.workflow/` from Foam graph scanning when possible and configuring any available Markdown formatter such as Prettier for Markdown files.
