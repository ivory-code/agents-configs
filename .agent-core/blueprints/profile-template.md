# Repo Profile Boilerplate

Use this template when creating a target-repo profile, for example `.agent-profile.md` or `docs/AGENT_PROFILE.md` inside the target repository.

````md
# Profile: <repo-name>

## Stack Snapshot

- Runtime/framework:
- Language:
- Package manager:
- State/data:
- Styling/design system:
- Navigation/routing:
- Test tooling:
- Deployment target:

## Commands

```bash
<install command>
<dev command>
<lint command>
<typecheck command>
<test command>
<build command>
```

## Source of Truth

- version:
- environment:
- design tokens:
- API schema:
- release metadata:

## Architecture Rules

- screen/page layer:
- feature/domain layer:
- service/data layer:
- shared UI layer:
- import aliases:

## Quality Gates

| Change Type | Required Validation |
|---|---|
| docs only | `git diff --check` |
| low-risk code | lint + typecheck |
| UI | lint + typecheck + visual/manual check |
| data/auth/payment/release | lint + typecheck + tests/build + risk note |

## Risk Points

- auth/security:
- data migration/storage:
- performance:
- release/deployment:
- legal/compliance:

## Local Exceptions

- rule:
- reason:
- expiration/follow-up:
````
