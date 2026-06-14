# Repo Convention Intelligence

## Purpose

Understand a repository's actual conventions with minimal token cost before editing. Prefer automated inspection and targeted reads over repeatedly scanning broad files.

## Trigger

Use this skill at the start of any new repo session, before code changes, and whenever the agent is unsure about stack, package manager, validation commands, architecture, styling, tests, or local conventions.

## Required Context

Run first when available:

```bash
.agent-core/scripts/inspect-repo.sh <target-repo-path>
```

If the script is unavailable, inspect only the smallest equivalent surface:

- `package.json`
- lockfile
- `tsconfig.*`
- lint/format config
- root agent docs: `AGENTS.md`, `CLAUDE.md`
- nearest files around the target change

## Context Budget Rules

- Start with the inspection summary, not a broad file dump.
- Read only files that explain the touched surface.
- Do not read all skills or all docs by default.
- Reuse the first inspection result in the same task unless the repo changes.
- Prefer `rg` and targeted `sed` ranges over opening whole large files.
- Stop reading once commands, architecture boundaries, and local style are clear.

## Convention Extraction

Capture only what affects the task:

```text
[Repo Context]
- stack:
- package manager:
- commands:
- path aliases:
- architecture dirs:
- styling/design-system:
- state/data:
- tests:
- high-risk areas:
```

## Decision Rules

- MUST follow observed repo conventions over generic preference.
- MUST avoid inventing new architecture if the existing pattern is adequate.
- MUST load task-specific skills only after identifying the task type.
- SHOULD create or update a repo profile only when the same repo will be reused repeatedly.
- NEVER spend context on framework rules that do not apply to the current repo.

## Validation Gate

Before editing, the agent can state:

- package manager and validation commands
- target architecture boundary
- reusable components/services/config already checked
- task-specific skill selected or intentionally skipped

## Escalation

Ask before generating a long-lived repo profile, changing global conventions, or replacing an established architecture pattern.
