# agents-configs

Portable agent instructions, repo-convention skills, and bootstrap files for Codex, Claude Code, and other coding agents.

This repository is a personal public toolkit for making AI coding sessions start from the same operating principle:

> Inspect the target repo first, load only the relevant skill, follow local conventions, and finish with validation evidence.

## Why This Exists

AI coding agents waste a surprising amount of time rediscovering the same context: package manager, scripts, architecture boundaries, test commands, branch rules, and local style. They also drift when every tool has its own separate instruction file.

`agents-configs` keeps the reusable parts in a vendor-neutral `.agent-core/` directory and uses thin tool-specific entrypoints for Codex and Claude.

The goal is not to create a giant prompt. The goal is to keep agent behavior small, portable, inspectable, and easy to copy into new or existing repositories.

## What Is Included

```text
.agent-core/
  blueprints/      reusable skill and repo-profile templates
  scripts/         deterministic context and inspection helpers
  skills/          vendor-neutral operational skills
.codex/            Codex entrypoint that points to .agent-core
.claude/           Claude entrypoint that points to .agent-core
docs/              architecture and skillset notes
scripts/           bootstrap tools for copying configs into a target repo
```

Core skills:

- `repo-convention-intelligence`: inspect stack, commands, tests, and local conventions before acting.
- `engineering-excellence-harness`: guide non-trivial implementation, refactor, and release-risk work.
- `executive-operating-harness`: guide roadmap, positioning, product, and strategy decisions.
- `intent-capture`: turn repeated explanations and tacit judgment into durable docs, profiles, or skills.
- `taste-calibration`: turn implicit quality judgment into reusable rubrics and failure signs.
- `skill-system-architect`: design and maintain reusable agent skills without bloat.
- `verification-layer`: design checks, metrics, rubrics, and review loops for generated output.
- `code-style`, `design-system`, `testing`, `pr-checklist`: task-specific operating skills.

## Quick Start

Copy both Codex and Claude entrypoints into a target repo:

```bash
./scripts/bootstrap.sh all /path/to/project
```

Or keep this repo as the single source of truth with symlinks:

```bash
./scripts/bootstrap.sh --link all /path/to/project
```

Or copy only one tool entrypoint:

```bash
./scripts/bootstrap.sh codex /path/to/project
./scripts/bootstrap.sh claude /path/to/project
```

Then inspect the target repo before asking an agent to edit code:

```bash
cd /path/to/project
.agent-core/scripts/inspect-repo.sh .
```

The bootstrap script copies `.agent-core/` plus the selected tool-specific entrypoint. It may overwrite matching files in the target path, so review local changes before committing.

Check an installed project:

```bash
./scripts/doctor.sh /path/to/project
```

See [`docs/SYMLINK_INSTALLATION.md`](docs/SYMLINK_INSTALLATION.md) for the copy-vs-symlink strategy.

## Recommended Agent Flow

1. Run `.agent-core/scripts/inspect-repo.sh .`.
2. Read `.agent-core/skills/repo-convention-intelligence.md`.
3. Load only the task-specific skill from `.agent-core/skills/index.md`.
4. Make the smallest useful change that follows the target repo.
5. Validate with commands discovered from the target repo.
6. Report what changed and what evidence proves it.

## Main Documents

- [`docs/UNIVERSAL_SKILLSET_BLUEPRINT.md`](docs/UNIVERSAL_SKILLSET_BLUEPRINT.md)
- [`docs/AGENT_OPERATING_MODEL.md`](docs/AGENT_OPERATING_MODEL.md)
- [`docs/SYMLINK_INSTALLATION.md`](docs/SYMLINK_INSTALLATION.md)
- [`.agent-core/README.md`](.agent-core/README.md)
- [`.agent-core/skills/index.md`](.agent-core/skills/index.md)
- [`.agent-core/blueprints/skill-template.md`](.agent-core/blueprints/skill-template.md)
- [`.agent-core/blueprints/profile-template.md`](.agent-core/blueprints/profile-template.md)

## Design Principles

- Context first: inspect the current repo before applying generic advice.
- Automation before repetition: use scripts for repeatable convention discovery.
- Shared source, thin adapters: keep reusable rules in `.agent-core` and point each agent entrypoint at it.
- Progressive disclosure: load only the skill needed for the task.
- Local conventions win: target repo rules override portable defaults unless unsafe.
- Evidence over intuition: finish with files, commands, logs, tests, or a clear blocker.
- Intent capture: turn repeated explanations and tacit judgment into durable docs or skills.
- Taste calibration: convert "what good looks like" into compact rubrics future agents can reuse.
- Verification layer: do not trust generated output without checks, metrics, or rubrics.
- Portable core: keep project secrets, branch names, and volatile release details out of reusable skills.

## Non-Goals

- This is not a package manager, framework, or runtime dependency.
- This is not a replacement for project-specific `AGENTS.md`, `CLAUDE.md`, or security policy.
- This is not a giant all-purpose prompt that should be loaded on every turn.
- This is not tied to any single open-source project or product workflow.
- This repo should not store private project details, credentials, or one-off release state.

## Status

This is a lightweight personal toolkit, not a versioned product yet. Expect the skill files to evolve as repeated agent workflows become clearer.
