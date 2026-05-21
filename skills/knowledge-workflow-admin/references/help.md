# Knowledge Workflow Admin Help

Use this reference only for maintainer questions about the `knowledge-workflow-admin` Skill itself. Ordinary team workflow help belongs to `knowledge-assistant`.

## Boundary

`knowledge-workflow-admin` is a maintainer/admin Skill. It can initialize Knowledge Workflow in a repository, run checks, guide post-upgrade migrations, maintain the manifest, and save approved configuration.

It is not the ordinary distributed help surface for team members. Do not route normal questions about content placement, delivery flow, WORKLIST usage, Kanban state, recovery, or skill choice through this maintainer Skill unless the question is about setup or administration.

## Mode Router

| Maintainer question                 | Mode             | Write behavior                                                              |
| ----------------------------------- | ---------------- | --------------------------------------------------------------------------- |
| "How do I set this workflow up?"    | `help` or `init` | `help` is read-only; `init` writes only after approval.                     |
| "Initialize this repository."       | `init`           | Dry-run first; write after approval.                                        |
| "Check this workflow installation." | `check`          | Read-only; report setup, migration needs, and Skill availability issues.    |
| "Upgrade or migrate this workflow." | `check` first    | Read-only inventory first; any file move or manifest update needs approval. |
| "Explain manager manifest fields."  | `help`           | Read-only.                                                                  |
| "Change configuration."             | `config`         | Dry-run first; edit manifest or root `AGENTS.md` after approval.            |

For ordinary team questions, recommend `knowledge-assistant`.

## Setup Guidance

Before answering setup questions:

1. Read the root `AGENTS.md` Knowledge Workflow block when it exists.
2. Read `<knowledge_dir>/.workflow/manifest.yml` when it exists.
3. If neither exists, give pre-install guidance and ask for required initialization choices:
    - repository-relative `knowledge_dir`;
    - explicit `canonical_language`;
    - whether required Skills are available to the current Agent;
    - `worktree_dir`.

Do not silently choose a canonical language. `knowledge/`, required Skills, and `.worktrees/` are examples or defaults only where the main skill instructions allow them.

## Installed Content Rule

Installed repository `AGENTS.md` and ordinary knowledge documents should not tell regular team members to call this maintainer Skill directly. They may keep workflow block markers and manifest metadata required for upgrades, but normal routing should use `knowledge-assistant` and the ordinary workflow Skills.

When a maintainer operation is needed, describe it as maintainer administration unless the user has explicitly chosen this Skill.

## Upgrade Guidance

When a maintainer asks about upgrading an existing installation, read `references/upgrade.md`.

Start with `check`. Do not run `init` over an existing repository as a migration shortcut. Treat migration as a protected maintainer operation: inventory first, preserve project knowledge and local-only files, produce a dry run, then write only after explicit approval.

## Answer Shape

For maintainer help, answer with:

1. the relevant mode;
2. whether the next step is read-only, dry-run-only, or write-capable after approval;
3. required inputs that are missing;
4. files that would be read or changed;
5. the next prompt the maintainer can use.
