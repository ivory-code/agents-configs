# Codex Workspace Rules

공통 규칙은 `.agent-core`를 기준으로 사용한다.

## Load Order

1. `../.agent-core/skills/project-profile-selector.md`
2. `../.agent-core/skills/code-style.md`
3. `../.agent-core/skills/design-system.md`
4. `../.agent-core/skills/testing.md`
5. `../.agent-core/skills/pr-checklist.md`

## Optional Skills

- `../.agent-core/skills/react-best-practice.md`
- `../.agent-core/skills/vercel-composite-patterns.md`
- `../.agent-core/skills/superpowers-operating-model.md`
- `../.agent-core/skills/pressure-scenarios.md`
- `../.agent-core/skills/convention-adoption.md`

## Policy

- Keep rules vendor-neutral and project-portable.
- Put project-specific deltas in `../.agent-core/profiles/*`.
- Do not duplicate the same rule across codex/claude docs.
