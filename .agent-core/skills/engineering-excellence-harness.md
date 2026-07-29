# Engineering Excellence Harness

## Purpose

Raise codebase quality through architecture boundaries, reuse, interface discipline, performance, testing, privacy, and release safety.

## Trigger

Use this skill when:

- planning or implementing non-trivial code changes
- refactoring architecture, shared modules, interfaces, state, persistence, or data flow
- improving repository fit, reusability, performance, or test coverage
- reviewing a PR for maintainability and regression risk
- preparing a release or high-risk change

## Required Context

Inspect before editing:

- active repo profile and validation commands
- target files and neighboring conventions
- existing shared modules, libraries, services, scripts, and configuration
- current tests and quality gates
- performance/privacy/release risks for the touched surface

## Operating Loop

1. Identify the intended behavior from the request, commits, and diff; mark assumptions.
2. Identify the change type and risk level.
3. Map the impacted behavior and boundaries: entry point, module, interface, state, persistence, configuration.
4. Reuse existing patterns before creating new ones.
5. Keep source of truth minimal; derive everything else.
6. Add or update tests/checks proportional to risk and behavior lifecycle.
7. Run validation and report residual risk.

## Quality Pillars

| Pillar | Rule |
|---|---|
| Architecture | preserve observed boundaries and separate interfaces, rules, state, persistence, and configuration |
| Reuse | create explicit contracts; avoid copy-paste and configuration or parameter sprawl |
| Repository fit | use existing libraries, modules, assets, and patterns before introducing new structures |
| Type and schema safety | preserve declared contracts and validate unknown boundaries |
| State | store the minimum source of truth and derive values at the appropriate boundary |
| Performance | avoid repeated work, unnecessary I/O, unstable references, and unneeded subscriptions |
| Testing | derive verification scenarios from changed behavior before selecting a runner |
| Privacy | avoid leaking sensitive data to logs, telemetry, or shared artifacts |
| Release | verify environment, version source of truth, and rollback risk |

## Risk Levels

| Level | Examples | Minimum Gate |
|---|---|---|
| Low | docs, metadata, local formatting | diff or repository-defined static check |
| Medium | shared module, state, interface, refactor | targeted static checks and tests when available |
| High | security, persistence, public contract, release, migration | applicable static checks + tests/build/runtime evidence + risk note |

## Decision Rules

- MUST inspect existing conventions before introducing new structure.
- MUST state which behavior is intended to change and which evidence supports that interpretation.
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
- static checks:
- tests:
- build/runtime:

[Risk]
- residual:
- follow-up:
```

## Escalation

Pause before changing persistence schemas, authentication or authorization behavior, public contracts, release configuration, privacy behavior, or shared platform primitives.
