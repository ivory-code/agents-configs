# Agent Core

Vendor-neutral agent skills, scripts, and blueprints for reuse across repositories.

## Directory

```text
.agent-core/
├── blueprints/      # templates for new skills and repo profiles
├── scripts/         # deterministic context/automation helpers
└── skills/          # small operational skills
```

## Core Skills

- `repo-convention-intelligence.md`
- `engineering-excellence-harness.md`
- `executive-operating-harness.md`
- `skill-system-architect.md`
- `code-style.md`
- `design-system.md`
- `testing.md`
- `pr-checklist.md`

## Scripts

- `scripts/inspect-repo.sh`: summarize stack, package manager, commands, aliases, key files, and convention clues.

## Blueprints

- `blueprints/skill-template.md`
- `blueprints/profile-template.md`

## Operating Rules

1. Start from repo context, not generic preference.
2. Keep skills short and load task-specific details only when needed.
3. Put volatile repo details in generated repo profiles, not core skills.
4. Prefer automation scripts for repeated inspection.
5. Remove or split skills that become motivational, duplicated, or framework-specific.
