# Skill Quality

Use this lightweight checklist when creating or changing public Choral Skills.

## Frontmatter

- `name` uses lowercase letters, digits, and hyphens.
- `description` starts with `Use when`.
- `description` describes trigger conditions, not the Skill workflow.
- Keep descriptions short enough for always-loaded Skill-selection context.
- Put safety and routing boundaries in `SKILL.md`; platform metadata can reinforce them but must not be the only boundary.

## Trigger Boundary

Before changing a description, test it against a few realistic prompts:

| Type                | Purpose                                           |
| ------------------- | ------------------------------------------------- |
| should-trigger      | A prompt that should load this Skill.             |
| should-not-trigger  | A similar prompt that should not load this Skill. |
| routing expectation | The Skill or normal answer that should handle it. |

Keep examples in review notes or test artifacts unless they are useful durable documentation. Do not put long examples into the description.

## Cross-Agent Rules

- `SKILL.md` is the portable contract across Agent runtimes.
- `agents/openai.yaml` is optional OpenAI/Codex UI metadata.
- Do not add platform-specific metadata files unless a runtime or adapter actually consumes them.
- Do not assume target projects have Node, Bun, Python, PowerShell, Bash, a package manager, or a specific editor.

## Publication Review

Check before publishing or copying Skills:

- Frontmatter exists and matches the folder name.
- Descriptions are trigger-only and do not summarize multi-step workflows.
- Maintainer-only Skills cannot be mistaken for ordinary team help.
- Read-only Skills do not include write instructions.
- Workflow skeleton files contain no copied Skill templates.
- No product facts, private member data, local paths, generated reports, or local-only runtime files are included.
