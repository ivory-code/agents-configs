# agents-configs

Portable agent configuration and skill boilerplate for Codex/Claude-style coding agents.

## Goals

- Understand each repo's conventions before acting.
- Use automation to avoid repeated context gathering.
- Keep reusable skills small, generic, and task-triggered.
- Support both executive product judgment and engineering quality gates.

## Structure

```text
.agent-core/
  blueprints/      skill/profile templates
  scripts/         automation helpers
  skills/          reusable operational skills
.codex/            Codex entrypoint
.claude/           Claude entrypoint
docs/              architecture notes
scripts/           bootstrap tools
```

## Quick Start

```bash
./scripts/bootstrap.sh all /path/to/project
cd /path/to/project
.agent-core/scripts/inspect-repo.sh .
```

## Main Documents

- `docs/UNIVERSAL_SKILLSET_BLUEPRINT.md`
- `.agent-core/skills/index.md`
- `.agent-core/blueprints/skill-template.md`
- `.agent-core/blueprints/profile-template.md`
