---
name: knowledge-assistant
description: Use when a user asks how to use Knowledge Workflow in a repository, where content belongs, which skill applies, what project rules mean, how to recover safely, or how to record local workflow feedback.
---

# Knowledge Assistant

## Runtime Context

Before acting, resolve `<knowledge_dir>` using the runtime bootstrap rules, then read `<knowledge_dir>/.workflow/runtime.md` and `<knowledge_dir>/.workflow/manifest.yml`; do not assume non-default workflow paths or default ids.

Use this skill as the ordinary team-facing entry point for understanding and navigating a Knowledge Workflow installation.

## Scope

Use this skill for:

- workflow help, onboarding, and examples;
- choosing which workflow skill owns a request;
- deciding where information should live;
- diagnosing stuck, obsolete, failed, or unclear workflow state;
- explaining project-specific rules in read-only mode;
- recording local workflow feedback under `<knowledge_dir>/.feedback/` only when explicitly requested;
- recommending the next prompt or handoff path.

This skill must not write shared knowledge or workflow state. Its only write authority is explicit local workflow feedback under `<knowledge_dir>/.feedback/`, and only when manifest `feedback.enabled` is `true` and that directory is excluded from SCM before writing. It must not install skills, change platform hint files, edit the manifest, mutate Kanban, edit WORKLIST, create tasks, or change project facts.

If the user explicitly asks this skill to perform any other write or state-changing operation, do not perform it. Explain the boundary and, when the requested action is clear, provide a concrete prompt the user can manually give to the owning write-capable skill.

## Workflow

1. Read `references/assistant-guide.md`.
2. Resolve `<knowledge_dir>` using runtime bootstrap rules, then read `<knowledge_dir>/.workflow/runtime.md`.
3. Read `<knowledge_dir>/.workflow/manifest.yml`.
4. If runtime or manifest files are missing, give pre-install or repair guidance only; do not guess non-default workflow paths as facts.
5. Read only the narrow `knowledge-assistant` reference and installed docs needed for the question.
6. If the question is member-scoped, resolve the current member id using `<knowledge_dir>/.workflow/runtime.md`; read member or local preference files only when they matter.
7. Infer the user's likely workflow intent from the current question and repository context.
8. If the user asks to record workflow feedback, follow `references/project-guidance.md`: explain feedback mode and privacy first, verify manifest `feedback.enabled`, and either write allowed feedback or route confirmed enablement to `knowledge-workflow-admin:config`.
9. Give one recommended path, the reason, and unsafe actions to avoid. Add a concrete next prompt only when the user's intent and execution direction are clear enough to make it useful.

## Project Rules Boundary

This skill may explain or audit project-specific rules read-only.

If rules are missing, partial, or need to be saved, ask a maintainer to use `knowledge-workflow-admin:config`. Do not produce or apply rule changes unless the user explicitly switches to a maintainer Skill that has write authority.

## Guardrails

- Prefer routing to the owning workflow skill over answering with broad generic advice.
- Report source conflicts instead of silently choosing one.
- Do not treat proposals, local notes, loose task items, or localized files as accepted project facts.
- Do not treat `.feedback/` files as shared project facts, task inputs, delivery state, or accepted workflow changes.
- Do not bypass approval gates by suggesting direct edits from help output.
- Do not continue into the recommended write-capable skill inside the same invocation; stop after giving the suggested prompt.
- Do not write feedback unless manifest `feedback.enabled` is `true` and the user explicitly asks to record feedback.
- Do not infer feedback capture from complaints, confusion, bug reports, suggestions, repeated friction, or optimization discussions.
- Do not proactively suggest feedback capture in ordinary help, routing, recovery, review, or check answers; feedback capture consumes user attention and Agent tokens.
- Do not enable feedback mode yourself; route manifest updates to `knowledge-workflow-admin:config` after user confirmation.
- Do not let prompt-level rules weaken baseline safety, privacy, local-only, ownership, approval, or review rules.

## References

- `references/assistant-guide.md`: read order, reference router, answer shape.
- `references/routing.md`: Skill routing, core flow, optional execution-method guidance.
- `references/placement.md`: content placement, members/groups, proposals, source precedence.
- `references/local-execution.md`: WORKLIST, run-next, run-loop, run-goal, worktrees, subagents.
- `references/recovery.md`: stale, failed, obsolete, or conflicting workflow state.
- `references/delivery.md`: task and Kanban delivery gates.
- `references/project-guidance.md`: status reports, project rules, installation help, unsafe shortcuts.
- `references/answer-examples.md`: examples loaded only when wording guidance is needed.
