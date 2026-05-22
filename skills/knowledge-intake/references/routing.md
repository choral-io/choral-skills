# Knowledge Intake Routing

## Routing Decisions

Choose exactly one routing decision before recommending a next step:

Rows are ordered by source-of-truth safety: no repository write, deferred or rejected material, current-member local material, shared knowledge candidates, delivery planning, then visible people/group metadata.

| Decision              | Use when                                                                 | Default next step                                        |
| --------------------- | ------------------------------------------------------------------------ | -------------------------------------------------------- |
| `no-change`           | No durable or useful local project information emerged                   | Answer in chat; do not write                             |
| `ignore-or-defer`     | Duplicative, premature, sensitive, or intentionally deferred             | Explain why no repository write should happen            |
| `local-scratch`       | Raw personal observation, rough idea, inbox-style capture                | Write only if user asks; target current `local/scratch/` |
| `local-draft`         | Structured personal draft not approved for team sharing                  | Draft under current `local/drafts/` after approval       |
| `shared-workspace`    | Public member summary, handoff, or shareable investigation               | Route approved write to `knowledge-capture`              |
| `proposal`            | Valuable but unconfirmed candidate needing review                        | Create proposal after approval                           |
| `canonical-knowledge` | Approved fact, requirement, design, architecture, decision, or guideline | Route approved write to `knowledge-capture`              |
| `task-candidate`      | Executable team work not yet accepted onto Kanban                        | Create or refine task item after approval                |
| `kanban-planning`     | Accepted task item needs board proposal                                  | Route to `delivery-planning`                             |
| `member-or-group`     | Project-visible member or group profile/change                           | Route approved write to `knowledge-capture`              |

If multiple decisions appear plausible, choose the highest row that preserves safety and source-of-truth boundaries, then list the rejected alternatives in the response.

## Analysis-First Intake

Use analysis-first intake before recommending capture when material is complex, multi-source, high-impact, contradictory, or unclear. Do not write canonical knowledge in this step.

Include:

- durable claims or decisions implied by the input;
- explicit sources or origin material, if available;
- existing canonical pages checked for overlap;
- conflicts, uncertainty, or missing reviewer judgment;
- possible target areas and the recommended route.

After analysis, ask the user to approve the route or select an alternative before handing off to `knowledge-capture`.

## Intake Output

Use this shape:

```md
## Routing Decision

`canonical-knowledge`

## Target

`<knowledge_dir>/product/example.md`

## Why

Rule-based reason tied to the table above.

## Existing Knowledge Checked

- path or "not checked"

## Next Step

Use `knowledge-capture` to ...

## Do Not Do Yet

- Kanban change
```

## Routing Examples

| User mention                                                       | First action                   | Target                                         |
| ------------------------------------------------------------------ | ------------------------------ | ---------------------------------------------- |
| Market, business, customer, environmental, or competitive research | Review discovery docs          | `<knowledge_dir>/discovery/`                   |
| Product requirement or user behavior                               | Review existing product docs   | `<knowledge_dir>/product/`                     |
| UI layout, component behavior, visual state                        | Review existing design docs    | `<knowledge_dir>/design/`                      |
| Domain term or reusable concept                                    | Search concepts                | `<knowledge_dir>/concepts/`                    |
| Module boundary, API, data flow, integration                       | Review architecture docs       | `<knowledge_dir>/architecture/`                |
| Product or technical tradeoff                                      | Check existing decisions       | `<knowledge_dir>/decisions/`                   |
| Cross-area writing, terminology, or language                       | Review guidelines              | `<knowledge_dir>/guidelines/`                  |
| Sprint, roadmap, process, migration                                | Review planning docs           | `<knowledge_dir>/planning/`                    |
| Valuable but unconfirmed knowledge, task, or decision candidate    | Create proposal after approval | `<knowledge_dir>/proposals/`                   |
| Implementable work item                                            | Create or refine task item     | `<knowledge_dir>/tasks/`                       |
| Personal working context                                           | Capture locally                | `<knowledge_dir>/workspace/<member-id>/local/` |
| Shareable member summary, handoff, research                        | Summarize for team use         | `<knowledge_dir>/workspace/<member-id>/`       |

## Local Promotion

Use intake to decide whether local-only material should become shared knowledge. Do not promote automatically.

Recommend promotion when local material affects:

- market, business, customer, environmental, or competitive research that informs product direction
- product behavior or user-visible requirements
- UI design, interaction, or prototype decisions
- architecture, data flow, integration, or operational constraints
- task scope, acceptance criteria, blockers, or readiness
- member handoff, coordination, or review context
- decisions that future Agents or team members must rely on

If the user agrees, route the approved write to `knowledge-capture`.

## Proposal Buffer

Recommend a proposal when material is valuable but not yet confirmed enough to become canonical knowledge, a task item, or an accepted decision.

Good proposal candidates:

- local log, scratch, handoff, or research material that may become reusable knowledge
- user feedback, QA observation, market signal, or failure pattern that needs review
- task candidate that is not ready for a task item
- decision candidate that needs owner or reviewer judgment
- material with multiple possible target areas

Do not require a proposal for user-approved single-file wording or metadata updates with a known target and no schema, ownership, delivery-status, or acceptance impact.

## Suggested Response Pattern

```text
This sounds like durable project knowledge.

I will first check existing discovery, product, and decision docs for overlap.
If there is no matching canonical page, I will suggest the right target area before drafting.
If it is executable work, I will also suggest a task item, but I will not create a Kanban card without approval.
```

## No-Change Cases

Do not suggest a knowledge update when:

- The message is purely operational status with no durable fact.
- The idea is private or sensitive and should not enter the repository.
- The content only repeats existing canonical knowledge.
- The user is asking a one-off question and no new project knowledge emerges.
