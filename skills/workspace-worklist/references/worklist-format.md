# Worklist Format

## Location

```text
<knowledge_dir>/workspace/<member-id>/local/WORKLIST.md
```

Create from:

```text
<knowledge_dir>/templates/worklist.md
```

## Sections

```md
# Worklist

## Active

## Later

## Waiting

## Done
```

- `Active`: executable items the Agent may run.
- `Later`: executable or nearly executable unscheduled personal work.
- `Waiting`: blocked items that need outside input.
- `Done`: completed items, with only short human-readable notes.

## Items

Use normal Markdown checklists:

```md
- [ ] Fix example feature behavior. ^wl-20260425-k7q9
    - [ ] Reproduce example failure.
    - [ ] Add regression test.
    - [ ] Patch example classification.
```

Intake from a team task should keep source links in the top-level item:

```md
- [ ] Implement example feature handling from [[../../planning/KANBAN#^kb-example-feature]] / [[../../tasks/example-feature-handling]]. ^wl-20260425-a8f2
    - [ ] Confirm current example behavior and failing case.
    - [ ] Add regression coverage.
    - [ ] Patch example classification.
    - [ ] Run focused validation.
```

Rules:

- Users may add bare checklist items with no id.
- Treat only top-level checklist items as selectable work items.
- Treat nested checklist items as subtasks.
- Add a block anchor only when the Agent starts, logs, splits, or needs to track the item.
- Do not add metadata blocks under items.
- Keep result details in `local/logs/YYYY-MM-DD.md`.

## Edits

- Capture new executable or nearly executable ordinary items under `Later`.
- Route raw ideas, observations, and inbox-style notes to `local/scratch/` instead of `WORKLIST.md`.
- Route structured personal drafts to `local/drafts/` instead of `WORKLIST.md`.
- Put urgent or explicitly active items under `Active`.
- For Kanban/task intake, put the item under `Active` only when the user says they are starting or taking the task now. Otherwise use `Later`.
- Move blocked items to `Waiting` and write a short reason in the worklist or log.
- Move completed items to `Done` or mark them done in place, then keep `Active` tidy.
- Preserve user wording unless a small rewrite makes the item executable.

## Grooming

- Suggest cleanup when `Active` has more than five top-level items.
- Every `Waiting` item should have a short reason in the item text or log.
- When `Done` becomes noisy, suggest extracting a daily, weekly, or ad hoc summary before pruning old completed items.
- Keep follow-ups flowing back into `Active` or `Later`; do not bury next actions only in logs.
