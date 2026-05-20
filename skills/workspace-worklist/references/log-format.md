# Log Format

## Location

```text
<knowledge_dir>/workspace/<member-id>/local/logs/YYYY-MM-DD.md
```

Use the local date. Create the file when first writing that day.

## File Template

```md
# Work Log YYYY-MM-DD
```

## Entries

Use append-only timestamped headings:

```md
## 17:20 Started wl-20260425-k7q9

Source: [[../WORKLIST#^wl-20260425-k7q9]]

- Task: Fix example feature behavior.
```

Task intake should include source links:

```md
## 10:20 Started wl-20260425-a8f2

Source:

- [[../WORKLIST#^wl-20260425-a8f2]]
- [[../../../planning/KANBAN#^kb-example-feature]]
- [[../../../tasks/example-feature-handling]]

- Intake: split assigned Kanban task into local execution steps.
- Next: confirm current example behavior and failing case.
```

Continue progress and completion entries with the same work id:

```md
## 17:42 Progress wl-20260425-k7q9

- Reproduced example failure.
- Next: add regression test.

## 18:05 Completed wl-20260425-k7q9

- Result: Added example classification and regression coverage.
- Changed:
    - `src/example/feature.ts`
- Checks:
    - `project lint or focused test command`
```

Entry verbs:

- `Started`
- `Resumed`
- `Progress`
- `Paused`
- `Blocked`
- `Completed`
- `Follow-up`

Record only meaningful events. Do not log every command, file read, search, or transient thought.

## Cross-Day Work

- Keep the same `wl-*` id across days.
- Write a new entry in the current day's log.
- Use `rg <work-id> <knowledge_dir>/workspace/<member-id>/local/logs/` to gather history.
- Do not merge daily logs.

## Pause And Resume

When stopping mid-task, write a `Paused` or `Progress` entry with:

- current state
- next concrete step
- important files or links
- known blockers or risks

When resuming, search by work id and write a `Resumed` entry only if there is useful new context.

## Summary Extraction

Summaries are user-facing shared documents, not raw log dumps. They can be daily, weekly, milestone-based, handoff-oriented, or ad hoc.

When extracting a summary:

- Ask or infer the summary period and purpose.
- Remove local noise, failed attempts, command chatter, secrets, and personal material.
- Keep decisions, outcomes, changed areas, blockers, follow-ups, and links to durable project knowledge.
- Use `<knowledge_dir>/workspace/<member-id>/summaries/` for ordinary summaries.
- Use `<knowledge_dir>/workspace/<member-id>/handoffs/` when another member needs to continue the work.
