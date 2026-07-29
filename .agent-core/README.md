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
- `risk-to-confidence/SKILL.md`
- `engineering-excellence-harness.md`
- `executive-operating-harness.md`
- `intent-capture.md`
- `taste-calibration.md`
- `skill-system-architect.md`
- `verification-layer.md`
- `code-style.md`
- `design-system.md`
- `testing.md`
- `pr-checklist.md`

`risk-to-confidence` is the formal end-to-end orchestrator. Its canonical package stays under `.agent-core`; `.agents/skills` and `.claude/skills` provide thin discovery adapters. It may be selected automatically for non-trivial end-to-end delivery, while an explicit invocation may stop at an earlier phase gate.

## Scripts

- `scripts/inspect-repo.sh`: summarize generic repository, manifest, instruction, and convention clues, with optional structured `package.json` enrichment when Node.js is available.

## Blueprints

- `blueprints/skill-template.md`
- `blueprints/profile-template.md`
- `blueprints/verification-baseline-template.md`

## Operating Rules

1. Start from repo context, not generic preference.
2. Separate default-branch policy from current branch evidence.
3. Derive change intent and verification scenarios before selecting tools.
4. Keep skills short and load task-specific details only when needed.
5. Put volatile repo details in generated repo profiles, not core skills.
6. Promote only human-reviewed corrections into shared verification memory.
7. Prefer automation scripts for repeated inspection.
8. Remove or split skills that become motivational, duplicated, or framework-specific.
