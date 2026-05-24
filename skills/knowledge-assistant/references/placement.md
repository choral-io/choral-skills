# Placement

Use this when the user asks where something should live.

## Placement Table

| Content                                     | Place                                                                   | Owning path                                                                   |
| ------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| Raw observation or rough idea               | current member `local/scratch/`                                         | `knowledge-intake` if it may matter later                                     |
| Structured personal draft                   | current member `local/drafts/`                                          | use for non-Superpowers drafts; promote only after user approval              |
| Superpowers spec or plan output             | current member `local/superpowers/specs/` or `local/superpowers/plans/` | personal execution aid; apply `references/superpowers.md` first               |
| Personal executable action                  | current member `local/WORKLIST.md`                                      | `workspace-worklist`                                                          |
| Public member summary, handoff, or research | `workspace/<member-id>/summaries/`, `handoffs/`, or `research/`         | `knowledge-capture` when writing shared files                                 |
| Project member profile                      | `members/<member-id>.md`                                                | update group `members` when membership applies                                |
| Group, team, review board, or working group | `groups/<group-id>.md`                                                  | confirm members before writing                                                |
| Discovery, market, customer, or assumption  | `discovery/`                                                            | `knowledge-capture`                                                           |
| Product behavior or requirement             | `product/`                                                              | `knowledge-capture`                                                           |
| UI, flow, visual design, or design asset    | `design/` plus `assets/<asset-type>/<topic>/` for supporting files      | `knowledge-capture`                                                           |
| Supporting asset                            | `assets/<asset-type>/<topic>/` with a canonical note that links it      | `knowledge-capture`                                                           |
| Concept, architecture, decision, guideline  | matching canonical area                                                 | `knowledge-capture`                                                           |
| Sprint or planning-period document          | `planning/sprints/`                                                     | `knowledge-capture` for the document; `delivery-planning` for board proposals |
| Valuable but unconfirmed candidate          | `proposals/`                                                            | convert before using as fact or delivery input                                |
| Potential delivery work                     | `tasks/`                                                                | audit before planning                                                         |
| Approved delivery status                    | `planning/KANBAN.md`                                                    | `kanban-maintenance` after approval                                           |

Project facts come from canonical knowledge and code. Shared workspace material is context. Local workspace material is personal execution state.

## Members And Groups

Use `knowledge-capture` for approved member and group creation.

- Member profiles live in `members/<member-id>.md` and should use `.workflow/templates/member.md`.
- Group documents live in `groups/<group-id>.md` and should use `.workflow/templates/group.md`.
- When creating a member, ask the user to choose groups manually or infer likely target groups from public responsibilities and ask for confirmation; record confirmed membership in the selected group documents' `members` lists.
- When creating a group, ask the user to choose members manually or infer likely target members from public responsibilities and ask for confirmation.
- `groups/*.md` frontmatter `members` is the structured membership source. Do not write group membership into member profile frontmatter.
- Keep private personal information out of both member and group documents.

## Proposals

Use proposals as a review buffer, not as facts or delivery commitments.

- `proposed -> reviewing`: reviewer or owner starts evaluation.
- `reviewing -> accepted`: owner or maintainer approves the direction.
- `accepted -> converted`: canonical document, task item, or decision exists.
- `reviewing -> rejected` or `reviewing -> superseded`: record rationale and replacement when present.

Accepted proposals remain non-canonical until converted. Task proposals must become task items before delivery planning.

## Scope Precedence

When sources conflict, recommend applying this order and reporting conflicts that affect facts, delivery scope, permissions, review, ownership, or another member:

```text
repository workflow runtime and repository safety rules
> knowledge schemas, workflow rules, and accepted decisions
> canonical project knowledge and code
> shared workspace summaries, handoffs, and research
> personal local notes, worklists, logs, and local workspace instructions
> current conversation
```

Lower-scope material can trigger updates, but it does not replace committed project knowledge until the user approves capture or maintenance.
