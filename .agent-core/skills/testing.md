# Testing

## Purpose

Choose the smallest useful validation strategy based on risk and the repository's actual tooling.

## Trigger

Use this skill when adding tests, changing logic, refactoring, touching risky flows, or preparing a PR/release.

## Required Context

From repo inspection and nearby files, identify:

- test tooling and commands
- test file placement/naming
- existing helper/wrapper patterns
- risk level of the change

## Risk-Based Strategy

| Risk | Examples | Validation |
|---|---|---|
| P0 | auth, payment, storage, migration, release config | tests/build + lint + typecheck + risk note |
| P1 | primary user journey, data mutation, navigation | focused tests or manual flow + lint + typecheck |
| P2 | shared util/hook/service | unit tests when tooling exists |
| P3 | copy/docs/simple style | diff check or lint |

## Rules

- Follow existing test style before introducing new tooling.
- Prefer user-visible behavior over private implementation details.
- Cover success, failure, and empty states for risky flows.
- If no test tooling exists, run available static checks and report the gap.

## Validation Gate

Report:

```text
[Validation]
- lint:
- typecheck:
- test/build/manual:
- skipped and why:
```
