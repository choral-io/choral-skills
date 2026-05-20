---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - proposals
---

# Proposals Schema

Proposal documents are an optional review buffer for valuable but unconfirmed knowledge, task, or decision candidates.

They are not project facts, accepted decisions, task items, or delivery commitments until converted into the appropriate canonical document.

## Frontmatter

```yaml
---
scope: project
type: proposal
proposal_type: knowledge
proposal_status: proposed
owners: []
assignees: []
reviewers: []
tags:
    - proposal
sources: []
target_area:
target:
related_to: []
---
```

## Fields

- `proposal_type`: `knowledge`, `task`, or `decision`.
- `proposal_status`: `proposed`, `reviewing`, `accepted`, `rejected`, `converted`, or `superseded`.
- `sources`: evidence or origin links, such as shared workspace research, handoffs, task items, canonical knowledge, or external URLs.
- `target_area`: expected destination area, such as `product`, `discovery`, `tasks`, or `decisions`.
- `target`: optional target file, task item id, decision id, or wikilink.
- `related_to`: contextual links that are related but not evidence.

## Body Template

- Summary
- Source Evidence
- Proposed Change
- Target
- Risk And Confidence
- Review Decision
- Follow-Up

## Rules

- Use proposals only when material is valuable but not yet confirmed enough to become canonical knowledge, a task item, or an accepted decision.
- Do not require proposals for user-approved single-file wording or metadata updates with a known target and no schema, ownership, delivery-status, or acceptance impact.
- Do not create Kanban cards directly from proposals.
- Convert accepted task proposals into task items before delivery planning.
- Convert accepted decision proposals into decision documents before treating them as accepted decisions.
- Convert accepted knowledge proposals into the appropriate canonical knowledge area before using them as project facts.
- Preserve source evidence and review reasoning in the proposal, but do not copy raw private notes, secrets, or command chatter.
- Keep rejected, converted, or superseded proposals available as review history when the proposal explains a later canonical document, task, or decision. Do not use them as canonical sources.

## Lifecycle

| From        | To           | Required evidence                                                              | Follow-up                                                  |
| ----------- | ------------ | ------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| `proposed`  | `reviewing`  | reviewer or owner starts evaluation                                            | record reviewer and review focus                           |
| `reviewing` | `accepted`   | owner or maintainer approves the proposed direction                            | identify conversion target and responsible handler         |
| `reviewing` | `rejected`   | owner or maintainer rejects the proposal                                       | record rationale; no canonical conversion                  |
| `reviewing` | `superseded` | replacement proposal, decision, task item, or canonical document is identified | link replacement in `related_to` or `target`               |
| `accepted`  | `converted`  | target canonical document, task item, or decision exists                       | link target; preserve proposal as review history           |
| `accepted`  | `superseded` | accepted proposal is replaced before conversion                                | link replacement and explain why conversion did not happen |

Do not skip `accepted` when a proposal needs owner review before conversion. Direct `proposed -> converted` is allowed only when the user explicitly approves both acceptance and conversion in the same request.

## Conversion Rules

| `proposal_type` | Conversion target                              | Owning workflow                               |
| --------------- | ---------------------------------------------- | --------------------------------------------- |
| `knowledge`     | canonical knowledge document in target area    | `knowledge-capture`                           |
| `task`          | `{{knowledge_dir}}/tasks/<task-id>.md`         | `knowledge-capture`, then `delivery-planning` |
| `decision`      | `{{knowledge_dir}}/decisions/<decision-id>.md` | `knowledge-capture`                           |

After conversion, update `proposal_status: converted`, set or confirm `target`, and keep source evidence and review rationale in the proposal. Do not use an accepted-but-unconverted proposal as a canonical source.

## Template

Use `templates/proposal.md` as the reference template.
