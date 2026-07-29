# Repo Profile Boilerplate

Use this template when creating a target-repo profile, for example `.agent-profile.md` or `docs/AGENT_PROFILE.md` inside the target repository.

````md
# Profile: <repo-name>

## Stack Snapshot

- Runtime/platform:
- Language/data format:
- Dependency/build system:
- State/data/persistence:
- Presentation/design conventions when relevant:
- Entrypoints/routing:
- Test tooling:
- Packaging/deployment target:

## Commands

```bash
<install command>
<run command>
<format/static-check command>
<test command>
<build/package command>
```

## Source of Truth

- version:
- environment:
- interface/schema:
- shared assets/tokens when relevant:
- release metadata:

## Change Context

- default branch/ref:
- commit convention:
- branch comparison rule:
- instruction surfaces:

## Verification Memory

- shared baseline path:
- critical behavior source:
- fixture/mock source:
- accepted correction log:

## Architecture Rules

- entrypoint/interface layer:
- domain/processing layer:
- data/persistence layer:
- shared modules/assets:
- dependency/import rules:

## Quality Gates

| Change Type | Required Validation |
|---|---|
| docs/configuration only | diff, format, or schema check |
| low-risk local change | repository-defined static or targeted check |
| interface/state/persistence | targeted tests plus applicable static/runtime checks |
| security/migration/public contract/release | comprehensive repository checks + risk note |

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
