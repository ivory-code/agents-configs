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

### Current-State Evidence

| Evidence ID | Provenance | Evidence | Current behavior | Affected boundary |
| --- | --- | --- | --- | --- |
| E1 | User / Repository / External Contract | `path:line`, test, log, contract, or user statement | ... | ... |

### Governed Uncertainty

| Item ID | Class | Claim or intended change | Provenance | Evidence | Impact |
| --- | --- | --- | --- | --- | --- |
| U1 | Assumed | ... | Repository / Agent Default | E1 or supplied evidence | ... |
| U2 | Decision | ... | User / Repository / External Contract / Agent Default | why a human choice is material | ... |
| U3 | Dependency | ... | User / Repository / External Contract | external requirement | ... |

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

| Item ID | Approval requirement | Approval status | Blocking phase | Owner or decision maker | Approver and evidence | Resolution condition | Verification method | Unaffected work | Current handling |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| U1 | Not Required | Not Applicable | None | implementer | Not Applicable | reversible and contract-neutral | focused check | all | reversible default |
| U2 | Required | Open / Approved / Rejected | Build / Integration / Release | ... | ... | human choice recorded | ... | ... | awaiting choice |
| U3 | Required / Not Required | Open / Approved / Rejected / Not Applicable | Build / Integration / Release | ... | ... | external requirement available | ... | ... | isolated seam |

## Decision Check

- Item ID:
- Observation:
- Provenance:
- Approval requirement:
- Approval status:
- Approver and evidence:
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
- current-state evidence is separate from intended changes and governed uncertainty
- every material Assumed, Decision, and Dependency has a stable identifier, provenance, and evidence
- approval requirement, approval status, and blocking phase are separate
- `Not Required` pairs with `Not Applicable`; `Required` pairs with `Open`, `Approved`, or `Rejected`
- approval never rewrites an item's provenance
- no Agent Default closes a Decision
- every Assumed Agent Default is reversible and contract-neutral
- every Decision and Dependency has a blocking phase, owner, resolution condition, verification method, and unaffected work
- every resolved required approval records its approver and evidence
- no Build approval remains Open for a build-ready verdict
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

## Context-Isolated Delegation

Add for Standard or Expanded work only when delegation improves independence or throughput.

| Worker | Contract slice and supplied evidence | Dependencies | Completion criteria | Required return |
| --- | --- | --- | --- | --- |
| ... | ... | ... | ... | changed artifacts, executed evidence, blockers, contract delta |

## Integration Sequence

- [ ] temporary seam → real dependency
- [ ] local implementation → target environment
- [ ] compatibility and rollback verified where applicable

## Integration and Release Gates

| Gate ID | Phase | Condition | Owner | Verification method | Status |
| --- | --- | --- | --- | --- | --- |
| G1 | Integration | ... | ... | ... | ... |
| G2 | Release | ... | ... | ... | ... |

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

## Contract Conformance

| Work unit | Contracted outcome | Observed result | Delta class | Disposition | Deferred gate or closure evidence |
| --- | --- | --- | --- | --- | --- |
| ... | ... | ... | None / Structural / Behavioral / Evidence | Continue / Correct / Contract revised / Deferred / Blocked | gate ID, or phase + owner + verification method |

Use a separate row for each delta class when a work unit creates more than one. Correct a Behavioral delta unless the corresponding Decision is `Approved` with approver and evidence recorded and its approved outcome revises the Contract. That approval permits only Contract revision, not commit, deploy, or external mutation. A Deferred Evidence delta must link to a PLAN gate or state its phase, owner, and verification method inline.

## Independent Review

- Findings:
- Resolution:

## Decision Closure

| Item ID | Previous class | Provenance | Approval requirement | Approval status | Approver and evidence | Final state | Conclusion or follow-up |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ... | ... | unchanged from DRAFT | Required / Not Required | Open / Approved / Rejected / Not Applicable | ... | confirmed / changed / deferred | ... |

## Learning Check

- Repeated or non-obvious failure:
- Missing or incorrect reusable rule:
- Candidate lesson, or `None`:
- Disposition: None / Proposed / Accepted / Rejected
- Human acceptance decision and evidence:
- Durable destination, only if Accepted:

## Workflow Signals

Optional for Standard or Expanded work. Use for harness diagnosis, not productivity scoring.

- Review/fix rounds:
- Human decisions or interventions:
- Contract deltas:
- Repeated failure patterns:
- Interpretation:

## Remaining Items

- None / owner and confirmation method

## Delivery Gates

- Target environment:
- Confirmed contracts:
- Unconfirmed contracts:
- Rollout or smoke evidence:

## Task Cleanup

Add only when the task created cleanup resources or cleanup was explicitly requested.

- Verdict: CLEANED / CLEANUP DEFERRED
- Authorization source:
- Removed worktrees and directories:
- Removed remote and local branches:
- Retained targets and failed safety gates:
- Absence or retention evidence:

## Verdict

- READY / READY WITH DEFERRED / NOT READY
```

Never mark an unexecuted check as `PASS`. Use `NOT RUN` when it was not attempted. Use `BLOCKED` when a missing prerequisite prevents a required check, and state what would close it.

`READY` requires every required delivery approval to be `Approved` or resolved through a recorded rejection and Contract update. `READY WITH DEFERRED` may retain an `Open` approval only at a future gate with an owner and confirmation method.
