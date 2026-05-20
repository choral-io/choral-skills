# Delivery Review Checklist

## Inputs

- `<knowledge_dir>/planning/KANBAN.md`
- Linked task item or project knowledge card source
- Current diff, pull request, or changed files
- Relevant product, architecture, decision, and configuration documents

## Acceptance Review

- Verify the implementation satisfies each acceptance criterion.
- Confirm out-of-scope items were not accidentally included.
- Confirm `blocked_by` entries are resolved or documented.
- Confirm downstream dependency follow-up was reviewed or explicitly deferred by reverse-looking up tasks blocked by the completed task.
- Confirm user-visible behavior matches product knowledge.

## Code And Test Review

- Look for correctness bugs, regressions, race conditions, data loss risks, and security issues.
- Confirm changed exports, API contracts, and package boundaries remain compatible.
- Confirm focused tests cover changed behavior.
- Confirm required lint, type, build, and test checks were run or explicitly not run.

## Knowledge Review

- Confirm durable changes are reflected in English canonical knowledge.
- Confirm decisions that affect future implementation are captured in `<knowledge_dir>/decisions/`.
- Confirm delivery status is not duplicated into every linked task item.
- Leave localized files unchanged unless translation work is explicitly requested.

## Output Shape

Start with findings:

```text
Findings
- [P1] Title - file or knowledge link
  Explain the concrete issue and why it matters.
```

Then include:

- Acceptance status: `accepted`, `needs changes`, or `blocked`
- Review result: `accepted`, `minor-fix`, `rework-required`, `blocked`, or `invalid-review`
- Checks run
- Checks not run
- Knowledge updates reviewed

## Review Result Classification

Use exactly one result class before recommending Kanban movement:

| Result            | Conditions                                                                                  | Default recommendation             |
| ----------------- | ------------------------------------------------------------------------------------------- | ---------------------------------- |
| `accepted`        | Acceptance criteria satisfied; required checks pass or skips are documented; no P0/P1 issue | Propose `Reviewing -> Done`        |
| `minor-fix`       | Only localized fixes remain; no acceptance, API, data, permission, or architecture change   | Keep in `Reviewing`                |
| `rework-required` | Acceptance gap, broad regression, API/data/permission change, or multi-area redesign needed | Propose `Reviewing -> Doing`       |
| `blocked`         | External dependency, access, decision, environment, or unresolved blocker prevents review   | Propose `Reviewing -> Blocked`     |
| `invalid-review`  | Missing linked task, missing diff, wrong card state, or insufficient source context         | Stop and request missing materials |

Classify P0/P1 findings as `rework-required` unless they are external blockers. Classify P2/P3-only findings as `minor-fix` when they can be fixed without changing scope or acceptance criteria.

## Handoff Structure

Use this structure when review needs follow-up:

```md
## Purpose

## Source Context

## Actions Taken

## Decisions Made

## Missing Information

## Risks

## Next Action

## Review Request
```
