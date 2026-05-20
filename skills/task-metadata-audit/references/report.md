# Task Metadata Audit Report

## Severity

- `P0`: prevents safe planning or implementation.
- `P1`: likely blocks next-task selection or delivery readiness.
- `P2`: weakens ranking, ownership, or review quality.
- `P3`: cleanup or consistency improvement.

## Audit-To-Fix Flow

Use a two-step process:

1. Audit and report findings without editing files.
2. Apply selected fixes only after maintainer approval.
3. Re-run the audit after fixes.

Apply approved task metadata fixes with `knowledge-capture` unless the fix is a Kanban board move, which belongs to `kanban-maintenance`.

## Auto-Fixable After Approval

- Normalize ownership metadata to the `owners` frontmatter field when the value is clear.
- Normalize empty relationship fields such as `blocked_by: []`.
- Normalize relationship entries that uniquely match existing task ids.
- Add missing low-risk tags derived from module, directory, or filename.
- Add `readiness: ready` only when the task already satisfies all readiness criteria and the maintainer approves the dry-run.

## Requires Maintainer Judgment

- Setting or raising `priority` or `value`.
- Setting issue `severity`.
- Assigning `assignees` or `reviewers`.
- Deciding whether a blocker is resolved.
- Moving tasks into or out of `Blocked`.
- Task splitting, merging, cancellation, or scope changes.
- Adding or changing acceptance criteria.
- Deciding whether an issue, bug, or defect is actionable, duplicate, invalid, cancelled, or ready for delivery.
- Handling possible sensitive information.

## Example Output

```text
Summary
- Task items scanned: 16
- Kanban cards scanned: 16
- P0: 0
- P1: 2
- P2: 5
- P3: 3

Findings
- [P1] example-delivery-task is Ready but has no acceptance criteria.
- [P1] example-downstream-task `blocked_by` missing task id example-runtime-setup.
- [P1] example-ingestion-task is in Blocked but has no blocker metadata.
- [P1] example-registration-task has readiness: ready but no Sources section.
- [P2] example-search-task is missing value.

Dry-run fixes
- Add value: H to example-search-task.
- Add `blocked_by: ["[[tasks/example-upstream-task]]"]` to example-downstream-task.
- Add readiness: blocked to example-ingestion-task.

Safe for next-task-selection
- example-documentation-task
- example-implementation-task

Sources
- <knowledge_dir>/schemas/tasks.md
- <knowledge_dir>/planning/WORKFLOW.md
```

## Finding Format

Each finding must include these fields:

```text
- [P1] Short title
  File: <knowledge_dir>/tasks/example-task.md
  Evidence: exact field, Kanban card, or section
  Issue: deterministic rule that failed
  Proposed fix: concrete dry-run metadata or board change, or "requires maintainer judgment"
  Owner skill: knowledge-capture | kanban-maintenance | task-metadata-audit
```

## Metadata Fix Format

Use task knowledge-reference wikilinks:

```yaml
blocked_by:
    - "[[tasks/example-upstream-task]]"
related_to:
    - "[[tasks/example-related-task]]"
```
