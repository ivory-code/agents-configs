# Engineering Excellence Harness

## Purpose

Raise codebase quality through architecture boundaries, reuse, design-system discipline, performance, testing, privacy, and release safety.

## Trigger

Use this skill when:

- planning or implementing non-trivial code changes
- refactoring architecture, shared UI, services, state, or data flow
- improving design system adoption, reusability, performance, or test coverage
- reviewing a PR for maintainability and regression risk
- preparing a release or high-risk change

## Required Context

Inspect before editing:

- active repo profile and validation commands
- target files and neighboring conventions
- existing shared components/services/hooks
- current tests and quality gates
- performance/privacy/release risks for the touched surface

## Operating Loop

1. Identify the change type and risk level.
2. Map the impacted boundaries: screen, feature, service, shared UI, config.
3. Reuse existing patterns before creating new ones.
4. Keep source of truth minimal; derive everything else.
5. Add or update tests/checks proportional to risk.
6. Run validation and report residual risk.

## Quality Pillars

| Pillar | Rule |
|---|---|
| Architecture | separate UI, state, domain logic, services, and config |
| Reuse | create explicit contracts; avoid copy-paste and prop explosion |
| Design system | use existing components/tokens before custom styling |
| Type safety | no new `any`; validate unknown boundaries |
| State | store minimal source of truth; derive during render where possible |
| Performance | avoid unstable refs in lists, expensive render work, unnecessary subscriptions |
| Testing | protect high-risk user flows and pure domain utilities |
| Privacy | avoid leaking personal content to logs, analytics, or share artifacts |
| Release | verify environment, version source of truth, and rollback risk |

## Risk Levels

| Level | Examples | Minimum Gate |
|---|---|---|
| Low | docs, copy, isolated style | diff check or lint |
| Medium | component/state/refactor | lint + typecheck |
| High | auth, storage, payment, release, migration | lint + typecheck + test/build + risk note |

## Decision Rules

- MUST inspect existing conventions before introducing new structure.
- MUST keep unrelated refactors out of feature changes unless explicitly scoped.
- MUST document exceptions with reason and follow-up.
- SHOULD reduce file size and responsibility when touching large files.
- SHOULD add tests around extracted logic.
- NEVER skip validation because a change “looks small” if it touches high-risk domains.

## Output Format

```text
[Engineering Plan]
- change type:
- risk level:
- affected boundaries:

[Implementation]
- reuse:
- new abstractions:
- exceptions:

[Validation]
- lint:
- typecheck:
- test/build:

[Risk]
- residual:
- follow-up:
```

## Escalation

Pause before changing storage schema, authentication behavior, public API contracts, release configuration, analytics/privacy behavior, or shared design-system primitives.
