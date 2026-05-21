---
name: delivery-planning
description: Use when delivery work needs a proposal before editing task candidates, Kanban cards, backlog shape, or board changes.
---

# Delivery Planning

## Runtime Context

Before acting, use the repository Knowledge Workflow runtime context from root `AGENTS.md` and its manifest; do not assume workflow paths or default ids.

Use this skill to propose Kanban changes from project knowledge. This skill produces a dry-run only.

Task items are candidates and context until an approved Kanban card links to them. Use this skill when the user asks to rank loose task items, review backlog candidates, or turn task items into accepted Kanban work.

## Workflow

1. Read `<knowledge_dir>/.workflow/rules/delivery.md`.
2. Read `<knowledge_dir>/.workflow/schemas/common.md` and `<knowledge_dir>/.workflow/schemas/tasks.md`.
3. Collect candidate task items and source knowledge.
4. Exclude local workspace notes, archived notes, and localized files.
5. When proposing assignees, reviewers, ownership fit, or handoffs, read only the relevant sections from `<knowledge_dir>/members/<member-id>.md`, such as `Responsibilities`, `Focus Areas`, `Collaboration`, or `Availability`.
6. De-duplicate candidates against `<knowledge_dir>/planning/KANBAN.md`.
7. Produce a dry-run table and wait for maintainer approval.

## Default Inputs

- `<knowledge_dir>/product/**`
- `<knowledge_dir>/discovery/**`
- `<knowledge_dir>/concepts/**`
- `<knowledge_dir>/architecture/**`
- `<knowledge_dir>/decisions/**`
- `<knowledge_dir>/guidelines/**`
- `<knowledge_dir>/tasks/*.md`

Use `<knowledge_dir>/guidelines/**` as planning context or constraints. Do not create Kanban candidates from guidelines alone unless a guideline explicitly defines executable delivery work.

Use `<knowledge_dir>/discovery/**` as supporting evidence, assumptions, and opportunity context for product requirements. Do not create Kanban candidates from discovery analysis alone unless it has been accepted as product scope or a task item.

Use `<knowledge_dir>/proposals/**` only as backlog review context. Do not create Kanban candidates directly from proposals. Accepted task proposals must be converted into task items before delivery planning.

Use `type: issue`, `type: bug`, and `type: defect` task items as delivery candidates only after triage shows they are actionable. Do not plan raw feedback, unverified observations, duplicates, invalid reports, or unresolved non-reproducible defects as Ready work.

When decomposing one requirement into several dependent tasks, propose dependent tasks for `Backlog` by default. Use `blocked_by` and `readiness: blocked` for planned dependency order; propose `Ready` only when every Ready Checklist source requirement is satisfied and `owners` resolves to existing member or group documents.

Use `<knowledge_dir>/workspace/*/summaries/**`, `<knowledge_dir>/workspace/*/handoffs/**`, or `<knowledge_dir>/workspace/*/research/**` only when the owner or maintainer explicitly selects it.

Never use `<knowledge_dir>/workspace/*/local/**` as planning input.
Do not read member `local/AGENTS.md` for team planning.

## Output

- Concise summary of proposed cards.
- Dry-run table.
- Missing metadata or blockers.

## References

- For the dry-run table and task metadata examples, read `references/dry-run.md`.
