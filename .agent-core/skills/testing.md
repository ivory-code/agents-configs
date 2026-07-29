# Testing

## Purpose

Choose the smallest useful validation strategy based on risk and the repository's actual tooling.

## Trigger

Use this skill when adding tests, changing logic, refactoring, touching risky flows, or preparing a PR/release.

## Required Context

From repo inspection and nearby files, identify:

- user request, branch commits, diff, and changed symbols
- existing verification baseline or critical behavior documentation
- test tooling and commands
- test file placement/naming
- existing helper/wrapper patterns
- risk level of the change

## Intent-To-Scenario Loop

1. Write the intended behavior change in one sentence.
2. Attach evidence from the user request, commits, diff, tests, or reviewed repo baseline.
3. Mark confidence as `high`, `medium`, or `low`; require human review when evidence conflicts or stays low.
4. Model only the relevant lifecycle: trigger, precondition, action, state change, side effect, observable outcome.
5. Select the smallest useful scenario set:
   - primary: intended outcome
   - failure: dependency, permission, validation, timeout, or recovery
   - boundary: empty, duplicate, limit, date/time, ordering, or malformed input
   - state transition: disabled/enabled, first/repeat, stale/fresh, re-entry, or restoration
6. Choose unit, integration, E2E, contract, or manual execution only after the scenario is clear.

## Risk-Based Strategy

| Risk | Examples | Validation |
|---|---|---|
| P0 | security, persistence, migration, public contract, release configuration | comprehensive repository checks + runtime or rollout evidence + risk note |
| P1 | primary behavior, state or data mutation, external interface | focused automated or observed flow + applicable static checks |
| P2 | shared module, utility, adapter, or service | targeted tests when tooling exists |
| P3 | docs, metadata, or local presentation | diff, format, or repository-defined static check |

## Rules

- Follow existing test style before introducing new tooling.
- Prefer user-visible behavior over private implementation details.
- Include only scenario axes supported by evidence; do not fabricate domain rules to fill a matrix.
- Cover primary, failure, boundary, and state-transition risks when they apply.
- Treat a generated test draft as a proposal, not execution evidence.
- Keep implementation-only helpers, types, and internal refactors out of user behavior steps.
- If no test tooling exists, run available static checks and report the gap.

## Validation Gate

Report:

```text
[Change Intent]
- intent:
- evidence:
- confidence:
- lifecycle:

[Scenario Matrix]
- primary:
- failure:
- boundary:
- state transition:

[Validation]
- static checks:
- generated draft:
- executed automated/build/runtime/manual:
- skipped and why:
```
