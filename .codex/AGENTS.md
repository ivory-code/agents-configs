# Codex Workspace Rules

Use `.agent-core` as the vendor-neutral source of truth.

## Default Flow

1. Run or approximate `../.agent-core/scripts/inspect-repo.sh .`.
2. Read `../.agent-core/skills/repo-convention-intelligence.md`.
3. Load only the task-specific skill(s) from `../.agent-core/skills/index.md`.
4. Validate with commands discovered from the target repo.

## Do Not

- Do not read every skill by default.
- Do not force conventions from another repo.
- Do not duplicate core rules in Codex-specific docs.
- Do not keep volatile release numbers, branch names, or project secrets in reusable skills.
