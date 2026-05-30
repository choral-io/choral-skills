# Delivery Implementation Checklist

## Before Editing

- Read the selected Kanban card.
- Read the linked task item.
- Read relevant canonical knowledge files.
- Inspect the package or module before editing.
- Check `git status --short` and avoid unrelated changes.

## Implementation Plan

Use this format before editing unless the user explicitly asks for a direct tiny edit and the target file is known:

```md
## Implementation Plan

| Field             | Value                                    |
| ----------------- | ---------------------------------------- |
| Task              | Kanban card and linked task item         |
| Goal              | One outcome from the task item           |
| Allowed paths     | Files or directories expected to change  |
| Forbidden paths   | Paths that must not be touched           |
| Knowledge updates | required \| not required \| needs review |
| Tests/checks      | focused validation commands or checks    |
| Review readiness  | expected evidence before review          |
| Risks             | blocker, dependency, or dirty-worktree   |
| Requires approval | yes/no and reason                        |
```

If any row cannot be filled from the task item, source knowledge, or user instruction, stop before editing and ask or route to `delivery-planning`.

## During Implementation

- Keep the change scoped to the task.
- Prefer existing patterns and package boundaries.
- Update tests near the changed behavior.
- Update canonical knowledge when behavior, configuration, or decisions change.

## Knowledge Update Decision

| Change observed during implementation                                   | Required action                                                                        |
| ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| User-facing behavior, requirement interpretation, or product scope      | Update `<knowledge_dir>/product/` or propose a knowledge update before review.         |
| UI layout, component behavior, interaction state, or visual rule        | Update `<knowledge_dir>/design/` or record why no durable design knowledge changed.    |
| Module boundary, API, data flow, integration, config, or operations     | Update `<knowledge_dir>/architecture/` or `<knowledge_dir>/decisions/` as appropriate. |
| Lasting tradeoff or accepted product/technical decision                 | Create or update `<knowledge_dir>/decisions/`.                                         |
| Cross-area terminology, documentation, language, or process rule        | Update `<knowledge_dir>/guidelines/`.                                                  |
| Pure implementation detail with no durable product or technical meaning | No canonical knowledge update; mention this in review readiness evidence.              |
| New follow-up work discovered outside current acceptance criteria       | Create or propose a follow-up task/proposal; do not silently expand scope.             |
| Local experiment, temporary log, or private execution note              | Keep it in current member `local/`; do not promote without user approval.              |

## Suggested Checks

Use the narrowest meaningful project-specific checks first:

```text
run the formatter or documentation check for changed Markdown
run focused tests for changed behavior
run the target project's normal build or verification command when risk warrants
```

Run broader checks when the change touches shared contracts, cross-module behavior, or delivery-sensitive flows.

## Review Readiness Evidence

Use this format before asking for delivery review or moving `Doing -> Reviewing`:

```md
## Review Readiness

| Field             | Evidence                                               |
| ----------------- | ------------------------------------------------------ |
| Scope completed   | task acceptance criteria addressed                     |
| Files changed     | intended files only; unrelated dirty files identified  |
| Knowledge updated | yes/no plus paths or reason                            |
| Checks run        | commands/checks and results, or documented skip reason |
| Residual risks    | none, or explicit risk and owner                       |
| Suggested review  | reviewer, review focus, and linked task/card           |
```

Do not claim review readiness when acceptance criteria are unverified, required knowledge updates are missing, or unrelated dirty changes cannot be separated from the task.
