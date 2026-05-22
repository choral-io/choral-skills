# Config

Use this reference for the maintainer `config` mode.

Config mode manages configuration in two places:

- `<knowledge_dir>/.workflow/manifest.yml`
- root platform hint block -> `Project-Specific Rules`

It may also update `<knowledge_dir>/.gitignore` only to add the `.feedback/` exclusion required when enabling feedback mode.

Use `knowledge-assistant` for ordinary read-only configuration or project rules explanation. Use this maintainer mode only when the user asks to define, update, or save configuration, or accepts a recommendation after a check finds missing or inconsistent configuration.

## Configuration Topics

Supported manifest configuration:

- `canonical_language`: the BCP 47 language tag for canonical knowledge files.
- `worktrees_dir`: the local-only worktrees directory.
- `feedback.enabled`: whether `knowledge-assistant` may write local workflow feedback under `<knowledge_dir>/.feedback/`.
- `agent_skills.required`: the required Skills expected by this installation.
- `managed`, `protected`, `local_only`, `local_overrides`, and `skipped_patterns`: managed, protected, and local-only path strategy.
- `template_version` and `manifest_version`: workflow skeleton and manifest schema versions.

Supported root platform hint workflow-block configuration:

- required workflow context shown to Agents;
- Skill routing guidance;
- safety and local-only boundaries;
- project-specific rules under `Project-Specific Rules`.

Project-specific rule topics include auto-review, approval gates, protected surfaces, validation baseline, Kanban automation, git/worktree automation, source stability, and parallel/subagent execution.

If the user asks for a configuration topic outside these areas, handle it here only when it affects workflow setup, Agent behavior, approvals, execution, review, safety, or workflow gates. Otherwise route to help or knowledge-capture.

## Trigger

Use this mode when:

- the user asks to design, configure, update, audit, or save configuration;
- the user asks to change manifest values such as `canonical_language`, `worktrees_dir`, `feedback.enabled`, or `agent_skills.required`;
- the user asks to define, update, or save project-specific rules;
- `workspace-worklist:run-goal` or `run-loop` wants `auto-review`, but `Project-Specific Rules` lacks enough execution boundaries and the user chooses to configure them.

If the user asks general workflow education or read-only project rules explanation, use `knowledge-assistant` instead.

## Read And Preserve

1. Resolve `<knowledge_dir>` using runtime bootstrap rules, then read runtime, manifest, and the root platform hint block when present.
2. Read `<knowledge_dir>/.workflow/runtime.md` and `<knowledge_dir>/.workflow/manifest.yml`.
3. Locate the marked Knowledge Workflow block when changing platform hint project rules.
4. Read `references/manifest.md` when changing manifest fields or ownership strategy.
5. Locate the block's final `### Project-Specific Rules` subsection when changing root project rules.
6. Preserve all existing project-specific rules and manifest fields unless the user explicitly changes them.
7. Write only the approved manifest fields, the approved root workflow-block subsection, or the `.feedback/` exclusion in `<knowledge_dir>/.gitignore` when enabling feedback mode. Do not edit ordinary project engineering instructions outside the marked block.

If runtime, manifest, marked block, or project-specific subsection needed for the requested change is missing, stop and recommend workflow init, `check`, or manual repair.

## Explain Or Audit

For configuration questions, answer from current manifest, runtime context, platform hint block when relevant, and workflow baseline.

Output:

```md
## Config Answer

<direct answer>

## Sources

- <knowledge_dir>/.workflow/manifest.yml
- root platform hint -> Knowledge Workflow block
- relevant workflow baseline or skill reference

## Effective Configuration

<merged rule or field value from manifest + runtime + platform hint block + prompt when applicable>

## Gaps

- none | missing/partial configuration to define

## Next Step

<optional: ask a maintainer to define or update stable configuration>
```

Do not produce a write dry run unless the user asks to update or save configuration.

## Manifest Changes

Manifest changes require a dry run and explicit approval.

Rules:

- Keep `knowledge_dir` stable after init unless the user explicitly asks for a full workflow relocation plan.
- Keep `canonical_language` explicit; validate it as a BCP 47-like tag such as `en`, `zh-CN`, or `ja-JP`.
- Validate `worktrees_dir` as a repository-relative local-only path. Reject absolute paths, `..`, `.git/`, `.agents/`, `.claude/`, the selected knowledge directory, source package directories, build outputs, dependency folders, editor caches, and tool caches.
- Enable `feedback.enabled` only after explicit maintainer approval. Before enabling it, present the feedback-mode privacy summary: feedback is local-only, stored under `<knowledge_dir>/.feedback/`, not automatically submitted externally, fully reviewable by the user, and unsuitable for secrets, private customer data, unrelated project facts, or personal notes.
- When enabling `feedback.enabled`, verify `<knowledge_dir>/.gitignore` excludes `.feedback/`; if it does not, include the `.gitignore` update in the approved config dry run or block the enablement.
- Feedback files remain local-only, must stay under `<knowledge_dir>/.feedback/`, and must be excluded from SCM.
- Treat `agent_skills.required` as external runtime requirements only; never copy Skill files into the target repository.
- Change `managed`, `protected`, `local_only`, `local_overrides`, or `skipped_patterns` only when the path strategy itself changes.

## Project Rules Changes

Ask only the missing questions needed for the rules:

| Decision                  | What to capture                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------------------ |
| Low-risk automation       | Local logs, local worklist edits, read-only checks, formatting, or other project-approved basics |
| Medium-risk scopes        | Paths or change types where auto-review may proceed after main-Agent review                      |
| Protected surfaces        | Areas that always require explicit confirmation                                                  |
| Confirmation actions      | Commits, publishing, dependency changes, migrations, deletion, external transmission, etc.       |
| Validation baseline       | Minimum checks per allowed scope                                                                 |
| Kanban and git boundaries | Whether board edits, pulls, branch/worktree operations, or sync actions may be automated         |
| Source stability          | Whether the default is `focused` or project-specific stricter rules                              |

Keep rules short. Prefer project-specific categories over long file lists when categories are clear.

## Dry Run Shape

Before editing, output:

```md
## Config Dry Run

### Topic

manifest-field | manifest-ownership | workflow-block | project-rules | other

### Existing Configuration

<current value or summary>

### Proposed Change

<exact manifest fields or markdown block to insert/replace>

### Still Requires Confirmation

- ...

### Validation

- manifest found
- platform hint marked block found when needed
- edit scope limited to approved configuration surface
```

## Suggested Auto-Review Section

Use a `#### Auto-Review Execution Rules` heading inside `Project-Specific Rules` unless the project already has an equivalent heading.

Example:

```md
#### Auto-Review Execution Rules

- Auto-review is optional and applies only when the user requests it for a run.
- Vague auto-review allows only low-risk local actions: local worklist/log updates, read-only checks, and formatting files already approved for the current task.
- Medium-risk auto-review is allowed only for <project-defined scopes> after the main Agent reviews scope, diff, validation, and rule sources.
- Protected surfaces that always require explicit confirmation: <project-defined categories>.
- Kanban edits remain propose-only unless the user explicitly authorizes approved maintenance for the run.
- Commits, publishing, dependency installation, deletion, migrations, secrets, permissions, and external transmission require explicit confirmation unless this project adds a narrower task-level exception.
- Validation baseline: <project-defined checks per scope>.
- Source stability uses `focused` by default; use `strict` for protected surfaces, unclear freshness, worker dispatch, or user-requested strict runs.
```

Do not include placeholder text in the saved configuration. Ask the user or infer from existing project instructions before saving.
