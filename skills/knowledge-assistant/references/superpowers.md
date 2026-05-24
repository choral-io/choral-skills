# Superpowers Integration

Use this when Knowledge Workflow routes to or invokes Superpowers skills that may write a spec or plan output.

## Purpose

Superpowers specs and plans are personal execution aids by default. They help the current member clarify unclear work, shape implementation, coordinate optional subagents, and keep temporary execution plans out of shared repository history.

`<knowledge_dir>/workspace/<member-id>/local/superpowers/specs/` and `plans/` are Superpowers output locations only. They do not replace `<knowledge_dir>/workspace/<member-id>/local/drafts/`, which remains the place for general structured personal drafts that are not Superpowers spec or plan outputs.

Team-shared plans and specs are not a default Knowledge Workflow area. When local Superpowers output has durable team value, promote selected content through the owning Knowledge Workflow skill into the appropriate shared area, such as `proposals/`, `tasks/`, `planning/`, `product/`, `design/`, `architecture/`, or `decisions/`.

## P0 Integration Rules

| Superpowers skill                            | Knowledge Workflow integration                                                                                                                           |
| -------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `superpowers:brainstorming`                  | Resolve spec output using the path priority below before invocation. Durable outcomes require Knowledge Workflow promotion before becoming shared facts. |
| `superpowers:writing-plans`                  | Resolve plan output using the path priority below before invocation. Local plans support personal execution and are not team plans by default.           |
| `superpowers:subagent-driven-development`    | Use only for an accepted plan with independent tasks. The main Agent owns scope, integration, review, approvals, and all Knowledge Workflow state.       |
| `superpowers:using-git-worktrees`            | Resolve `<worktrees_dir>` from Knowledge Workflow runtime and manifest. Do not let Superpowers choose an unrelated worktree location.                    |
| `superpowers:verification-before-completion` | Use as evidence discipline before completion claims. Knowledge Workflow delivery review, acceptance criteria, and Kanban gates remain authoritative.     |

Subagents and worktree workers must not self-approve elevated execution, dependency installation, deletion, publishing, commits, migrations, Kanban changes, shared knowledge writes, or local-only file promotion. Route those decisions back to the main Agent.

## Output Path Priority

Before invoking `superpowers:brainstorming` or `superpowers:writing-plans`, explicitly tell Superpowers which output directory to use and whether the output may be committed. Resolve the directory in this order:

1. User-specified path in the current request.
    - Examples: "write the plan to X", "put the spec in Y", or "use this directory for the plan".
    - Use it only if it does not violate safety, approval, protected-path, local-only, member-boundary, or repository-boundary rules.
    - Respect the selected path. Do not replace it with the Knowledge Workflow default.
2. Current member local Superpowers workspace.
    - Resolve `<knowledge_dir>` using the runtime bootstrap rules.
    - Read `<knowledge_dir>/.workflow/runtime.md` and `<knowledge_dir>/.workflow/manifest.yml`.
    - Resolve the current member exactly as runtime rules require; do not guess, slugify, or infer from chat context.
    - Verify `<knowledge_dir>/members/<member-id>.md` exists before writing member-scoped local files.
    - Verify manifest `local_only.knowledge` and actual SCM ignore behavior exclude `<knowledge_dir>/workspace/<member-id>/local/**`; if not, stop and route repair to `knowledge-workflow-admin:check` or `knowledge-workflow-admin:config`.
    - Specs default to `<knowledge_dir>/workspace/<member-id>/local/superpowers/specs/`.
    - Plans default to `<knowledge_dir>/workspace/<member-id>/local/superpowers/plans/`.
3. Superpowers default path.
    - Use the Superpowers skill's own default spec or plan path.
    - Use only when Knowledge Workflow runtime, manifest, or current member cannot be resolved, the user did not specify a path, repair through `knowledge-workflow-admin:check` or `knowledge-workflow-admin:config` is not the next step, and the user gives explicit confirmation to use the Superpowers default path.
    - Before asking for confirmation, state why Knowledge Workflow local output could not be resolved.

## Commit Behavior

- If the output path is under `<knowledge_dir>/workspace/<member-id>/local/superpowers/**`, instruct Superpowers not to commit the file; local-only source files in that path must never be committed.
- If Superpowers attempts to auto-commit local-only output, stop before staging or committing and restate the local-only boundary.
- Commit Superpowers specs or plans only when the selected path does not violate local-only, approval, protected-path, member-boundary, or repository-boundary rules, or after the user approves promotion through the owning Knowledge Workflow skill. Promotion must create or update an owned shared artifact in the appropriate shared area, or use an explicitly selected path; it must not commit the local-only source file itself.
- Verification notes, subagent notes, and worktree execution notes follow the same local-only rule when they are written under the current member's `local/` workspace; summarize durable evidence into the owning review or shared artifact only when approved.

## Boundaries

- Treat `<knowledge_dir>/workspace/<member-id>/local/superpowers/**` as local-only because it is under `<knowledge_dir>/workspace/*/local/**`.
- Treat `local/superpowers/**` as a Superpowers artifact boundary, not a general drafts boundary; route non-Superpowers structured personal drafts to `local/drafts/`.
- Do not include local-only Superpowers files in shared knowledge commits, delivery evidence, Kanban updates, or task promotion unless the user explicitly asks to summarize or promote selected content through the owning Knowledge Workflow skill.
- Do not use local Superpowers specs or plans as delivery-planning input until their durable parts have been promoted into shared knowledge or task items.
- If runtime, manifest, current member, member profile, or SCM exclusion resolution fails, do not silently write to a guessed member path; report the specific missing input and apply the fallback rule only when the user has not specified a path.
