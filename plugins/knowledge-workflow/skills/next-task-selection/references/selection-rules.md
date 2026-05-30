# Selection Rules

Use these details after `next-task-selection` has triggered.

## Candidate Boundaries

- Use linked task items only as context for selected or candidate Kanban cards.
- Treat `readiness: blocked` in `Backlog` as valid planned dependency state, but exclude it from implementation recommendations until blockers are resolved.
- Do not select cards from `Blocked`, `Doing`, `Reviewing`, `Done`, or `Cancelled` unless the user explicitly asks for recovery, blocker-resolution, review, or cleanup work.
- Treat `related_to` as context only, not a blocker.

## Source Stability

- For ordinary recommendations, do a lightweight source stability check: flag uncommitted changes reported by `git status` or `git diff` for the task item or directly linked local source files, but do not scan every transitive dependency or query remotes for every candidate.
- For the top recommendation, automatic start, or a proposed move to `Doing`, run the full source stability check: the task item and required local source files must be committed; if a default remote exists, their commits must be pushed to that remote.
- Check required source material from the task item, `## Sources`, `blocked_by`, design links, product requirements, architecture decisions, acceptance criteria, and linked assets.
- Treat `related_to` as optional context unless the task body says it is required.
- Allow external stable sources only when the task records the URL, access condition, and relevant version or date.

## Assignment And Value

- First search tasks assigned to the current member id in `assignees`.
- If none are eligible, search unassigned tasks with missing or empty `assignees`.
- If none are eligible, list several tasks assigned to other members as candidates, ordered by priority and value, but do not recommend starting them unless the user explicitly asks.
- Treat downstream tasks whose `blocked_by` references the candidate as a value signal, especially when those downstream tasks are high priority.
- Prefer smaller ready tasks when two candidates have similar value and priority.
