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
- [Execution Levels](#execution-levels)
- [Artifact Policy](#artifact-policy)
- [Specialist Composition](#specialist-composition)
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
| Risk Map | Current and intended behavior, affected boundaries, regression surface, classified uncertainty | Material impact and uncertainty are visible |
| Executable Contract | Scope, behavior, interfaces, failure handling, dependencies, acceptance criteria | Another agent can implement without hidden chat context |
| Dependency-Aware Build | Small vertical results and recorded contract deltas | The smallest useful behavior works and targeted checks pass |
| Progressive Integration | One verified boundary at a time, with temporary seams removed or owned | Dependencies are integrated or represented by explicit gates |
| Confidence Pack | Executed checks, impact review, decision closure, residual risk | Final readiness verdict is supported by evidence |

R2C classifies uncertainty as:

- `Verified`: directly supported by code, tests, logs, supplied contracts, or user input
- `Assumed`: reversible and safely inferred from an established pattern
- `Decision`: requires a human choice because behavior, scope, compatibility, or risk changes
- `Dependency`: requires an external artifact, system, environment, team, or approval

Every Decision and Dependency records its blocking phase, owner, resolution condition, and unaffected work that may continue.

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

- `BUILD READY`: the implementation contract is closed
- `BUILD READY WITH GATES`: implementation can start while named Integration or Release gates remain
- `BUILD BLOCKED`: safe implementation cannot start

At the end:

- `READY`: acceptance criteria and required validation are closed with evidence
- `READY WITH DEFERRED`: the core outcome is verified and every remaining item has an owner and confirmation method
- `NOT READY`: a core outcome or required gate failed or remains blocked

These verdicts describe evidence state. They do not grant permission to commit, publish, deploy, or change external systems.

## Installation And Discovery

The workflow has one canonical source and thin discovery adapters:

```text
.agent-core/skills/risk-to-confidence/       canonical package
.agents/skills/risk-to-confidence            formal Agent Skills adapter
.claude/skills/risk-to-confidence             Claude Code adapter
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
