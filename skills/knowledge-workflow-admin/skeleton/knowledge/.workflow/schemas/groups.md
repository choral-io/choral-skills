---
scope: project
type: schema
owners: []
tags:
    - metadata
    - schema
    - groups
---

# Groups Schema

Group documents describe non-person responsibility subjects such as teams, review boards, maintainer groups, or working groups.

## Frontmatter

```yaml
---
scope: project
type: team
group_id: "<group-id>"
display_name: Example Group
owners: []
members: []
tags:
    - group
    - team
---
```

## Rules

- Use `group_id` as the stable id for links and metadata.
- Use lowercase kebab-case group ids.
- Use `type: team` for team-like groups.
- Use group wikilinks in `owners` and `reviewers` when responsibility belongs to a group.
- Use path-qualified group wikilinks such as `[[groups/review-board]]` for tool-written group references. Manual short group wikilinks are valid only when they resolve uniquely.
- Use `members` for member wikilinks included in the group, preferring path-qualified values such as `[[members/Gavroche]]` in templates and tool output. Ask the user to choose members manually, or infer likely target members from responsibilities and ask for confirmation.
- When creating a group, check existing `{{knowledge_dir}}/members/*.md` and suggest likely members before writing.
- Use `{{knowledge_dir}}/.workflow/templates/group.md` as the reference template for new group documents.
- Prefer concrete member wikilinks in `assignees`. A group assignee means a team or group pool, not assignment to the current member.
- Do not store private member information in group documents.
