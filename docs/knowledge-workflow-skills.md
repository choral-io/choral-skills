# Knowledge Workflow Skills Overview

Knowledge Workflow Skills help teams build a repository-backed knowledge system for AI-assisted work. The workflow comes from repeated team practices: keep durable context close to the repository, let Agents help maintain the parts humans neglect, and make important conclusions survive beyond the current conversation.

A repository knowledge system is different from a chat transcript, a document dump, or a query-time retrieval index. It gives Agents and humans a durable working surface where facts, decisions, task intent, delivery state, and local execution notes can be read, reviewed, corrected, linked, and versioned. The repository becomes the shared memory; the Agent helps maintain it.

## Knowledge Model

The workflow is built around a few principles:

- **Persistent knowledge beats temporary context.** Important discoveries, decisions, requirements, and delivery notes should survive the current Agent session.
- **The knowledge base is a maintained artifact.** New information should update existing pages, reveal contradictions, add missing links, and improve summaries instead of only creating more files.
- **Markdown remains the working format.** Knowledge should stay readable in ordinary editors, reviewable in Git, and usable by different Agent runtimes.
- **Files are the shared record.** Agent memory, chat history, and retrieval tools can help, but the repository knowledge files are the inspectable project context.
- **Governance matters.** Team knowledge, task state, maintainer configuration, and member-local execution are related, but they have different write authorities and review expectations.

This makes Knowledge Workflow more than a wiki template. It is a set of operational boundaries for letting Agents maintain project knowledge without silently turning every conversation into shared truth.

The bundled profile in this repository is intentionally oriented toward software product development. Its default areas and workflow rules are designed for product knowledge, design notes, architecture decisions, delivery tasks, implementation review, and reusable product development experience. The underlying repository-backed knowledge model may be useful elsewhere, but this profile should be read as a software product development workflow rather than a fully general knowledge-base template.

## What The Skills Provide

- A repository-local knowledge structure with schemas, templates, workflow rules, and a manifest.
- Read-only help, audit, and reporting Skills for safe navigation and diagnosis.
- Approval-gated capture and delivery Skills for shared knowledge writes, Kanban changes, implementation, and review.
- Member-local execution support through `workspace-worklist`, with local-only worklists and logs kept out of project facts.
- Maintainer-only administration through `knowledge-workflow-admin` for init, checks, manifest state, and approved configuration updates.

## Responsibility Boundaries

The suite is split so each Skill has a narrow authority boundary:

| Area                              | Owning Skills                                                              | Boundary                                                                   |
| --------------------------------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| Setup and configuration           | `knowledge-workflow-admin`                                                 | Maintainer-scoped; not ordinary team help.                                 |
| Help and routing                  | `knowledge-assistant`                                                      | Strictly read-only.                                                        |
| Unapproved ideas and evidence     | `knowledge-intake`                                                         | Recommends routing before writes.                                          |
| Approved knowledge writes         | `knowledge-capture`                                                        | Writes only after the target and change are approved.                      |
| Knowledge health and task checks  | `knowledge-schema-audit`, `task-metadata-audit`, `knowledge-status-report` | Read-only diagnostics and dry-run fixes.                                   |
| Delivery planning and board state | `delivery-planning`, `kanban-maintenance`, `next-task-selection`           | Planning is dry-run; board mutation requires approval.                     |
| Implementation and review         | `delivery-implementation`, `delivery-review`                               | Work from accepted task/Kanban context and report validation evidence.     |
| Personal execution                | `workspace-worklist`                                                       | Current-member local flow only; does not write another member's workspace. |

## Repository Model

A repository using the workflow declares runtime context in root `AGENTS.md` and stores installation state in `<knowledge_dir>/.workflow/manifest.yml`. Required Skills are external Agent runtime capabilities; the workflow does not copy Skill files into target repositories.

The knowledge directory is Markdown-first and editor-friendly. Schemas define writing contracts, templates provide starting points, task files hold durable delivery context, and `planning/KANBAN.md` tracks delivery status. Member `workspace/<member-id>/local/` content is local-only execution state and must not be treated as shared project knowledge.

In this model, the knowledge directory is not just where outputs are stored. It is the place where repeated Agent interactions accumulate: source material becomes structured knowledge, questions can become durable analysis, audits find stale or conflicting claims, and delivery work can refer back to accepted intent instead of reconstructing it from conversation history.

## Skill Set Guidance

Install the Knowledge Workflow Skills into the Agent runtime that will work with the repository. Use the install methods in the repository [README](../README.md).

The full Knowledge Workflow suite is useful when a team wants repository-backed product knowledge, task planning, implementation, review, and local execution support.

For ordinary team collaboration, install the non-admin Skills:

```text
knowledge-assistant
knowledge-intake
knowledge-capture
knowledge-schema-audit
task-metadata-audit
knowledge-status-report
delivery-planning
next-task-selection
kanban-maintenance
delivery-implementation
delivery-review
workspace-worklist
```

For maintainers, additionally install or explicitly invoke `knowledge-workflow-admin` when initializing or upgrading a Knowledge Workflow installation, checking required Skills, updating the manifest, or applying approved configuration changes.

For read-only reviewers, install `knowledge-assistant`, `knowledge-schema-audit`, `task-metadata-audit`, `knowledge-status-report`, and `delivery-review`.

After Skills are installed in the Agent runtime, initialize or check a target repository with `knowledge-workflow-admin`. The target repository should declare runtime context in root `AGENTS.md`, including the knowledge directory, the manifest path, required Skills, and any project-specific rules under the Knowledge Workflow section.

## Default Use

Start with `knowledge-assistant` when the next step is unclear. Use intake before deciding whether material should become shared knowledge, capture only after approval, audit/report Skills for read-only checks, and delivery Skills only when work has a task or Kanban context. Use `knowledge-workflow-admin` only for maintainer setup and approved configuration.
