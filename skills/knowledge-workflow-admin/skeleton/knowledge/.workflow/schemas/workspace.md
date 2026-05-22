---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - workspace
---

# Workspace Schema

Workspace documents capture member-scoped work context that is safe to share with the team before it becomes project knowledge.

## Frontmatter

```yaml
---
scope: member
type: summary
owners:
    - "[[members/Gavroche]]"
assignees:
    - "[[members/Gavroche]]"
reviewers: []
tags:
    - workspace
    - summary
---
```

Allowed `type` values:

- `member-workspace`
- `summary`
- `handoff`
- `research`
- `note`

## Shared Structure

```text
workspace/<member-id>/
  summaries/
  handoffs/
  research/
  local/
```

Use these directories deliberately:

- `summaries/`: edited daily, weekly, milestone, session, retrospective, or ad hoc summaries.
- `handoffs/`: handoff notes that help another member continue work with clear context. Use `<knowledge_dir>/.workflow/templates/handoff.md` as a reference template when a handoff needs a durable shared file.
- `research/`: member-led exploration or investigation notes that are useful to the team but not yet promoted into project knowledge.
- `local/`: local-only member state for Agent collaboration, including `WORKLIST.md`, `logs/*.md`, `scratch/`, `drafts/`, and local workspace instructions. It must stay uncommitted.

Stable member identity, responsibilities, focus areas, and public collaboration context belong in `<knowledge_dir>/members/<member-id>.md`. Personal Agent collaboration preferences may live in local workspace instructions.

## Rules

- Workspace notes are context, not project facts.
- Do not store secrets, credentials, private customer data, raw personal logs, or private personal notes.
- Local workspace instructions may define personal Agent collaboration preferences. They must not weaken workflow runtime, rules, schemas, task acceptance criteria, safety, privacy, approval, local-only, or review rules.
- Raw personal work items, daily notes, scratch material, draft notes, and inbox-style captures belong in `workspace/<member-id>/local/`, which is not committed.
- Use `workspace/<member-id>/local/scratch/` for raw observations and `workspace/<member-id>/local/drafts/` for structured personal drafts that are not ready to become shared knowledge.
- Use `workspace/<member-id>/local/WORKLIST.md` only for executable or nearly executable personal work items.
- Worktrees belong in `<worktrees_dir>/`, not in the knowledge base.
- Do not create shared `daily/`, `inbox/`, `scratch/`, or `drafts/` directories by default.
- Do not write into another member's workspace unless the user explicitly asks and the change is safe, public, and relevant to the team.
- Use `assignees` when a shared workspace note has a current follow-up owner.
- Use `reviewers` when a shared workspace note is ready for another member or Agent to review.
- Promote durable content to project knowledge before using it as planning input.
- Do not link shared workspace documents to `local/` files.

## Local Worklist

Copy the template from:

```text
<knowledge_dir>/.workflow/templates/worklist.md
```

to:

```text
workspace/<member-id>/local/WORKLIST.md
```

Execution logs should use daily files under:

```text
workspace/<member-id>/local/logs/YYYY-MM-DD.md
```

Raw local notes and structured personal drafts may use:

```text
workspace/<member-id>/local/scratch/
workspace/<member-id>/local/drafts/
```

The `local/` directory is ignored by `<knowledge_dir>/.gitignore`.

Worktree isolation, when used, belongs outside the knowledge base:

```text
<worktrees_dir>/shared/
```

This shared worker worktree is reusable local worktree state. It is not member workspace content, project knowledge, or a source for planning facts.

## Member-To-Member Work

Do not assign work by writing into another member's workspace or `local/` directory.

- Executable delegated work belongs in `<knowledge_dir>/tasks/` with `assignees`.
- Work ready for delivery belongs on `<knowledge_dir>/planning/KANBAN.md` after approved Kanban maintenance.
- Reusable forwarded material belongs in the relevant project knowledge area.
- Temporary personal captures should be handled by the receiving member or their Agent in that member's `local/scratch/`, `local/drafts/`, or `local/WORKLIST.md`, depending on whether the material is raw, structured, or executable.

Ordinary implementation and review handoffs can stay in final responses, local logs, task items, review reports, or Kanban maintenance requests. Create shared `handoffs/` files only for cross-member, long-lived, complex, or explicitly requested handoffs.

Agents should look for shared handoffs only when the user asks, when the current member has no active local work and asks to continue team work, when a selected work item links to a handoff, or when a task assigned to the current member references a handoff.
