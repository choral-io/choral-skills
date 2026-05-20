# Knowledge Placement

Use this reference after `knowledge-capture` has triggered.

## Project Areas

Promote durable material into the right project area:

- `<knowledge_dir>/discovery/`
- `<knowledge_dir>/product/`
- `<knowledge_dir>/design/`
- `<knowledge_dir>/concepts/`
- `<knowledge_dir>/architecture/`
- `<knowledge_dir>/decisions/`
- `<knowledge_dir>/guidelines/`
- `<knowledge_dir>/planning/`
- `<knowledge_dir>/proposals/`
- `<knowledge_dir>/tasks/`

## Placement Rules

- Store requirement discovery, market and business analysis, customer context, environmental research, opportunity framing, and assumptions in `<knowledge_dir>/discovery/`.
- Store product-level prototypes, user flows, and information architecture in `<knowledge_dir>/product/`.
- Store UI visual design, component guidelines, layout rules, and design system decisions in `<knowledge_dir>/design/`.
- Store cross-area writing, terminology, language, documentation, and process guidelines in `<knowledge_dir>/guidelines/`.
- Store binary or exported supporting materials under `<knowledge_dir>/assets/<asset-type>/<topic>/`, for example `<knowledge_dir>/assets/design/<feature-name>/`, and link to them from Markdown files.
- Use `<knowledge_dir>/proposals/` only for valuable but unconfirmed candidates that need review before becoming canonical knowledge, task items, or accepted decisions.

## Members And Groups

- Create member profiles in `<knowledge_dir>/members/` when the user approves a project-visible member record. Use `<knowledge_dir>/templates/member.md`; ask for or confirm `member_id`, `display_name`, public responsibilities, focus areas, and collaboration context.
- Create group documents in `<knowledge_dir>/groups/` when the user approves a project-visible team, review board, maintainer group, or working group. Use `<knowledge_dir>/templates/group.md`; ask for or confirm `group_id`, `display_name`, purpose, responsibility scope, owners, and members.
- For member creation, ask the user to manually choose groups or infer likely target groups from responsibilities, then ask for confirmation before updating group documents' `members` lists. Do not write a `groups` field to the member profile.
- For group creation, ask the user to manually choose members or infer likely target members from responsibilities, then ask for confirmation before writing `members`.
