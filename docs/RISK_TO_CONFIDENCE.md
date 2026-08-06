# Risk-to-Confidence Workflow

Risk-to-Confidence (R2C) is the end-to-end delivery orchestrator in this repository. It turns an uncertain request into explicit implementation boundaries and closes the work with executed evidence.

```text
Risk Map -> Executable Contract -> Dependency-Aware Build
  -> Progressive Integration -> Confidence Pack
```

The canonical instructions live in [the R2C skill](../.agent-core/skills/risk-to-confidence/SKILL.md). This document explains how to select and operate the workflow without duplicating its detailed rules.

## Contents

- [When To Use It](#when-to-use-it)
- [Phase Gates](#phase-gates)
- [Decision Governance](#decision-governance)
- [Execution Levels](#execution-levels)
- [Artifact Policy](#artifact-policy)
- [Specialist Composition](#specialist-composition)
- [Context-Isolated Delegation](#context-isolated-delegation)
- [Conformance And Learning](#conformance-and-learning)
- [Completion Cleanup](#completion-cleanup)
- [Invocation](#invocation)
- [Verdicts](#verdicts)
- [Installation And Discovery](#installation-and-discovery)
- [Portability Rules](#portability-rules)

## When To Use It

| Request | Routing |
|---|---|
| Explicitly asks for Risk-to-Confidence or R2C | Use R2C and stop at the requested exit point |
| Spans planning, implementation, integration, and verification | R2C may be selected automatically |
| Asks only for review, implementation, design, testing, QA, or commit | Use the relevant stage skill |
| Is small, local, reversible, and contract-neutral | Prefer a compact stage workflow unless R2C was explicitly requested |

An explicit invocation does not authorize every phase. State the intended exit point when the request should stop after the Risk Map, Contract, implementation, or integration.

## Phase Gates

| Phase | Main output | Exit condition |
|---|---|---|
| Risk Map | Current-state evidence plus governed Assumed, Decision, and Dependency items | Material impact, provenance, and approval metadata are visible |
| Executable Contract | Scope, behavior, interfaces, failure handling, dependencies, acceptance criteria | Another agent can implement without hidden chat context |
| Dependency-Aware Build | Small vertical results and Contract Conformance results | The smallest useful behavior works and targeted checks pass |
| Progressive Integration | One verified boundary at a time, with temporary seams removed or owned | Dependencies are integrated or represented by explicit gates |
| Confidence Pack | Executed checks, impact review, decision closure, residual risk | Final readiness verdict is supported by evidence |

## Decision Governance

R2C keeps five fields separate:

1. uncertainty class
2. provenance
3. approval requirement
4. approval status
5. blocking phase

It classifies uncertainty as:

- `Verified`: directly supported by code, tests, logs, supplied contracts, or user input
- `Assumed`: reversible and safely inferred from an established pattern
- `Decision`: requires a human choice because behavior, scope, compatibility, or risk changes
- `Dependency`: requires an external artifact, system, environment, team, or approval

Current-state evidence is recorded separately from intended changes. Every material Assumed, Decision, and Dependency carries a stable identifier and provenance:

| Provenance | Meaning |
|---|---|
| `User` | An explicit user-originated claim or constraint |
| `Repository` | Observed code, tests, history, configuration, or repository documentation |
| `External Contract` | An inspected interface, specification, environment, or external authority |
| `Agent Default` | A fallback proposed by the agent |

Approval requirement is `Required` or `Not Required`. Approval status is `Open`, `Approved`, `Rejected`, or `Not Applicable`; `Not Applicable` pairs only with `Not Required`. Timing belongs in the separate `Build`, `Integration`, or `Release` blocking phase. Approval does not rewrite provenance.

A Decision always requires human approval. An Agent Default may remain Assumed only when it is reversible and does not change behavior, scope, compatibility, authority, or material risk. It never closes a Decision.

Every Decision and Dependency records its blocking phase, owner, resolution condition, verification method, and unaffected work. A resolved required approval also records its approver and approval evidence.

## Execution Levels

| Level | Typical shape | Documentation |
|---|---|---|
| Compact | Local and reversible; no shared contract or external dependency changes | Keep the Risk Map and Contract in the conversation |
| Standard | One bounded subsystem changes behavior, state, data, or an interface | Persist only for a long-running task or handoff |
| Expanded | Multiple subsystems, shared contracts, migration, security, or rollout order | Persist the contract, plan, and evidence when an authorized location exists |

The level changes the depth of evidence, not the quality bar.

## Artifact Policy

Running R2C does not create workflow files by default.

Choose an artifact location in this order:

1. a location supplied by the user
2. an existing repository convention that the user has authorized
3. conversation-only output

For durable handoff, the reusable contracts are:

- `DRAFT.md`: Risk Map and Executable Contract
- `PLAN.md`: work graph, integration order, and validation plan
- `EVIDENCE.md`: executed checks, impact review, decision closure, and verdict

See [Artifact Contracts](../.agent-core/skills/risk-to-confidence/references/artifact-contracts.md) for the templates. Do not copy an external specification into these files; record only repository-grounded contracts and evidence.

## Specialist Composition

R2C owns phase transitions and readiness gates. Existing skills keep ownership of phase-specific practice:

| Need | Specialist |
|---|---|
| Repository context | `repo-convention-intelligence` |
| Engineering and architecture | `engineering-excellence-harness` |
| Scenario design | `testing` |
| Evidence and independent review | `verification-layer` |
| Durable accepted corrections | `intent-capture` |
| Pull-request finalization | `pr-checklist`, only when requested |

Code, design, security, migration, release, or other specialists are loaded only when the actual change requires them.

## Context-Isolated Delegation

For Standard or Expanded work, the coordinating context owns the Risk Map, Contract, and phase gates. Delegate only a bounded contract slice with its repository evidence, dependencies, and completion criteria.

A worker returns:

- changed artifacts
- checks it actually executed
- blockers
- any contract delta

An independent reviewer receives the request or contract, the diff, executed evidence, and unresolved items, but not implementation-session reasoning or a desired conclusion. Compact work does not need this ceremony unless delegation materially helps.

## Conformance And Learning

After each work unit, compare the contracted outcome with the observed result:

| Delta | Handling |
|---|---|
| `None` | Continue |
| `Structural` | Continue only when observable behavior and constraints remain unchanged |
| `Behavioral` | Correct the output unless the corresponding Decision is Approved with approver and evidence recorded |
| `Evidence` | Update validation or block when required proof is no longer available |

Use separate entries when one work unit creates more than one delta class. The Contract remains authoritative. An Approved Decision permits only the recorded Contract revision; it does not grant authority to commit, deploy, or mutate external systems. An Evidence delta may move to a later gate only when the proof is not required now and its blocking phase, owner, and verification method are recorded; the conformance entry must link to that gate or contain those fields inline. Otherwise block.

For check results, `NOT RUN` means the check was not attempted. `BLOCKED` means a missing prerequisite prevents a required check. Compact work may perform one conformance check before Integration.

The Confidence Pack ends with a Learning Check: identify repeated or non-obvious failures, determine whether a reusable rule was missing or wrong, and state the smallest candidate lesson. Record its disposition as `None`, `Proposed`, `Accepted`, or `Rejected`. Only a lesson with `Accepted` disposition and human acceptance evidence becomes durable memory; otherwise it remains current-task evidence.

For Standard or Expanded work, optional harness signals include review/fix rounds, human decisions or interventions, contract deltas, and repeated failure patterns. These diagnose the workflow. Lines changed and pull-request count are not confidence or productivity measures.

## Completion Cleanup

After delivery is preserved, use `task-cleanup` when the task created a dedicated worktree, external task directory, or local or remote task branch.

- R2C may assess cleanup eligibility, but deletion requires an explicit user request or an active policy that specifically authorizes completion cleanup.
- Remove only task-scoped resources that are clean, preserved, no longer used, and not protected.
- Keep branches required by an open PR, CI, deployment, monitor, or handoff.
- Never force-remove a worktree or recursively delete a task directory. `task-cleanup` deletes remote and local branch refs only through expected-OID-conditional operations.
- Report `CLEANED` or `CLEANUP DEFERRED` separately from the R2C evidence verdict when cleanup applies.

## Invocation

Full delivery:

```text
Codex:       $risk-to-confidence Deliver <change> through the Confidence Pack.
Claude Code: /risk-to-confidence Deliver <change> through the Confidence Pack.
```

Early exit:

```text
Codex:       $risk-to-confidence Build a Risk Map for <change> and stop before implementation.
Claude Code: /risk-to-confidence Draft the Contract for <change> and stop.
```

Handoff-oriented work:

```text
$risk-to-confidence Prepare a durable Contract and Plan for <change>; do not implement.
```

## Verdicts

Before implementation:

- `BUILD READY`: the implementation contract is closed and no Build approval remains Open
- `BUILD READY WITH GATES`: implementation can start while named Integration or Release gates remain
- `BUILD BLOCKED`: a Build-phase Decision, Dependency, or required approval remains Open

At the end:

- `READY`: acceptance criteria, required validation, and all required delivery approvals are closed with evidence
- `READY WITH DEFERRED`: the core outcome is verified and every future-gate item has an owner and confirmation method
- `NOT READY`: a core outcome or required gate failed or remains blocked

These verdicts describe evidence state. They do not grant permission to commit, publish, deploy, or change external systems.

## Installation And Discovery

The formal workflows have canonical sources and thin discovery adapters:

```text
.agent-core/skills/risk-to-confidence/       canonical package
.agent-core/skills/task-cleanup/              canonical package
.agents/skills/risk-to-confidence            formal Agent Skills adapter
.agents/skills/task-cleanup                   formal Agent Skills adapter
.claude/skills/risk-to-confidence             Claude Code adapter
.claude/skills/task-cleanup                    Claude Code adapter
```

Install both tool entrypoints:

```bash
./scripts/bootstrap.sh all /path/to/project
./scripts/doctor.sh /path/to/project all
```

Use `codex` or `claude` instead of `all` for a single-tool installation. See [Symlink Installation](SYMLINK_INSTALLATION.md) when this repository should remain the local source of truth.

## Portability Rules

- Target-repository instructions and observed architecture override portable defaults.
- Do not encode company names, product rules, personal paths, or framework assumptions in the canonical workflow.
- Use only commands and tools that actually exist in the target repository.
- Keep temporary assumptions and external dependencies visible.
- Separate source readiness, target-environment availability, and observed runtime behavior.
- Never report generated checks as executed evidence.
