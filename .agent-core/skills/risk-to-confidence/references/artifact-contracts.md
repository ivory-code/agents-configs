# Artifact Contracts

Use only the artifacts the task needs. Keep them in the conversation unless the user supplies a location or the target repository already has an authorized convention. Do not copy the source specification; preserve only evidence, the executable contract, the work graph, and validation results.

## Contents

- [DRAFT.md](#draftmd)
- [PLAN.md](#planmd)
- [EVIDENCE.md](#evidencemd)

## DRAFT.md

Use when the Risk Map and Executable Contract must survive a handoff.

```markdown
# DRAFT — <change>

Status: EXPLORING / BLOCKED / CONTRACTED

## Objective

- Observable outcome:
- Scope:
- Non-scope:

## Risk Map

| Class | Evidence | Current behavior | Intended impact |
| --- | --- | --- | --- |
| Verified | `path:line`, test, log, contract, or user input | ... | ... |
| Assumed | established pattern | ... | ... |
| Decision | human choice required | ... | ... |
| Dependency | external requirement | ... | ... |

## Executable Contract

### Entry Points and Preconditions

### Domain Rules, State Transitions, and Side Effects

### Interfaces, Data Meaning, Failure, and Compatibility

### Dependency Seams and Replacement Conditions

Add this section only for multi-system or staged delivery:

### Delivery and Rollout Contract

| Input or environment state | Expected meaning | Consumer behavior |
| --- | --- | --- |
| ... | ... | ... |

- Source evidence:
- Target-environment evidence:
- Missing-contract behavior:
- Compatibility window:
- Rollout order:
- Rollback path:

## Decision Ledger

| Class | Item | Blocking phase | Owner and resolution condition | Current handling | Impact |
| --- | --- | --- | --- | --- | --- |
| Assumed | ... | None | ... | reversible default | ... |
| Decision | ... | Build / Integration / Release | ... | awaiting choice | ... |
| Dependency | ... | Build / Integration / Release | ... | isolated seam | ... |

## Decision Check

- Observation:
- Current draft:
- Options and impacts:
- Recommended default:
- Work that can continue:

## Acceptance Criteria

- [ ] Given ... When ... Then ...

## Build Readiness

- BUILD READY / BUILD READY WITH GATES / BUILD BLOCKED
- Remaining Integration or Release gates:
```

Before accepting the DRAFT, confirm that:

- every question changes a concrete behavior, scope, compatibility, or risk decision
- repository evidence has answered everything it can answer
- external contracts are not invented
- stale plan snippets were checked against current architecture
- every Decision and Dependency has a blocking phase, owner, and resolution condition
- another agent could implement and verify without hidden chat context

## PLAN.md

Use when implementation has multiple work units, dependencies, or handoffs.

```markdown
# PLAN — <change>

Status: PLANNED / IN PROGRESS / BLOCKED / IMPLEMENTED

## Work Graph

| Track | Work unit | Depends on | Parallel-safe | Completion evidence |
| --- | --- | --- | --- | --- |
| A | ... | None | with B | focused check |
| B | ... | contract | with A | observable result |

## Vertical Slices

### S1. <smallest useful result>

- Target:
- Behavior:
- Checks:

## Integration Sequence

- [ ] temporary seam → real dependency
- [ ] local implementation → target environment
- [ ] compatibility and rollback verified where applicable

## Integration and Release Gates

| Phase | Condition | Owner | Verification method | Status |
| --- | --- | --- | --- | --- |
| Integration | ... | ... | ... | ... |
| Release | ... | ... | ... | ... |

## Validation Plan

- Primary scenarios:
- Failure scenarios:
- Boundary scenarios:
- State transitions:
- Automated checks:
- Manual or observational checks:
- Affected consumers:
- Independent review:
```

Treat code snippets as explanatory pseudocode, not authoritative implementation. Current repository rules and code remain the source of truth.

## EVIDENCE.md

Use when results must survive a handoff or accompany a review.

```markdown
# EVIDENCE — <change>

Status: VERIFYING / BLOCKED / CLOSED

## Outcome

- Observable result:
- Main changes:

## Executed Checks

| Check | Command or target | Result | Evidence or blocker |
| --- | --- | --- | --- |
| ... | ... | PASS / FAIL / NOT RUN / BLOCKED | ... |

## Scenario Evidence

| Scenario | Expected | Observed | Evidence |
| --- | --- | --- | --- |
| Primary | ... | ... | ... |
| Failure | ... | ... | ... |
| Boundary | ... | ... | ... |
| State transition | ... | ... | ... |

## Impact Review

- Interfaces and consumers:
- State, side effects, and persistence:
- Failure and recovery:
- Compatibility, migration, and rollback:
- Security, privacy, performance, or accessibility when applicable:

## Independent Review

- Findings:
- Resolution:

## Decision Closure

| Previous class | Final state | Conclusion or follow-up |
| --- | --- | --- |
| ... | confirmed / changed / deferred | ... |

## Remaining Items

- None / owner and confirmation method

## Delivery Gates

- Target environment:
- Confirmed contracts:
- Unconfirmed contracts:
- Rollout or smoke evidence:

## Verdict

- READY / READY WITH DEFERRED / NOT READY
```

Never mark an unexecuted check as `PASS`. Use `NOT RUN` or `BLOCKED` and state what would close it.
