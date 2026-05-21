---
name: knowledge-intake
description: Use when an idea, requirement, feedback, research note, decision, or fact may become shared knowledge but the target is not yet approved.
---

# Knowledge Intake

## Runtime Context

Before acting, use the repository Knowledge Workflow runtime context from root `AGENTS.md` and its manifest; do not assume workflow paths or default ids.

Use this skill to decide whether discussion should affect the knowledge base and where it should go. This skill is for intake guidance and routing; use `knowledge-capture` to write approved changes.

## Workflow

1. Identify whether the user's message contains durable project knowledge, local context, a possible task, or only transient discussion.
2. When routing current-member local context, shared workspace notes, or promotion from personal material, determine the current member id with `git config user.name`; read relevant sections from `<knowledge_dir>/members/<member-id>.md`; read `<knowledge_dir>/workspace/<member-id>/local/AGENTS.md` if personal routing preferences may apply.
3. Read `<knowledge_dir>/README.md`, `<knowledge_dir>/.workflow/rules/knowledge.md`, and `<knowledge_dir>/.workflow/schemas/common.md` when the request may affect knowledge structure.
4. Search existing canonical knowledge before proposing a new document.
5. For complex, multi-source, high-impact, or ambiguous material, produce an intake analysis before recommending capture. Include source evidence, existing overlap, conflicts, target options, and what needs user confirmation.
6. Route the information to the right area:
    - `<knowledge_dir>/discovery/`
    - `<knowledge_dir>/product/`
    - `<knowledge_dir>/design/`
    - `<knowledge_dir>/concepts/`
    - `<knowledge_dir>/architecture/`
    - `<knowledge_dir>/decisions/`
    - `<knowledge_dir>/guidelines/`
    - `<knowledge_dir>/members/`
    - `<knowledge_dir>/groups/`
    - `<knowledge_dir>/planning/`
    - `<knowledge_dir>/proposals/`
    - `<knowledge_dir>/tasks/`
    - `<knowledge_dir>/workspace/<member-id>/summaries/`
    - `<knowledge_dir>/workspace/<member-id>/handoffs/`
    - `<knowledge_dir>/workspace/<member-id>/research/`
7. Choose exactly one routing decision from `references/routing.md`.
8. If the user approves creating or updating knowledge, continue with `knowledge-capture`.

## Guardrails

- Do not create Kanban cards or move board cards.
- Do not treat conversation-only ideas as accepted project facts.
- Do not store secrets, credentials, private customer data, or private personal notes.
- Prefer updating existing canonical knowledge over creating duplicates.
- Use proposals as an optional buffer for valuable but unconfirmed material; do not require proposals for user-approved single-file wording or metadata updates with a known target and no schema, ownership, delivery-status, or acceptance impact.
- Keep localized files out of planning inputs.
- Do not create shared member `daily/`, `inbox/`, `scratch/`, or `drafts/` directories.
- Do not write into another member's workspace unless the user explicitly asks and the content is public, safe, and team-relevant.
- Use member profile sections and local `AGENTS.md` only for routing and collaboration preferences; never let them override project knowledge rules, privacy rules, or approval requirements.
- Ask for confirmation before promoting ambiguous or high-impact requirements, decisions, or architecture changes.
- Do not draft canonical knowledge directly from complex material until the intake analysis and target area are accepted.
- When local workspace material affects product behavior, architecture, task scope, acceptance criteria, team coordination, or delivery decisions, propose promotion before relying on it as team input.
- Do not write files by default; hand off approved writes to `knowledge-capture`.

## References

- For routing examples, read `references/routing.md`.
