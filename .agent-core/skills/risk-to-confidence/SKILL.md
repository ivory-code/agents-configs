---
name: risk-to-confidence
description: Orchestrates non-trivial change delivery by turning uncertain requests into a Risk Map, Executable Contract, dependency-aware work graph, progressive integration, and evidence-backed verdict. Use when explicitly asked for Risk-to-Confidence or R2C at any named exit point, or when delivering a feature or specification across planning, implementation, integration, and verification. Do not invoke implicitly for isolated review, design, API, testing, QA, or commit tasks.
---

# Risk to Confidence

Turn uncertainty into an executable contract, then close the work with evidence.

`Risk Map → Executable Contract → Dependency-Aware Build → Progressive Integration → Confidence Pack`

## Start

1. Determine the requested exit point: risk review, contract and plan, implementation, integration, or complete delivery.
2. An explicit Risk-to-Confidence request may stop at any requested named exit point, including the Risk Map or Contract. For an ordinary review or explanation request, use the relevant stage skill instead. Unless constrained otherwise, carry authorized implementation work through the Confidence Pack.
3. Use `repo-convention-intelligence` to inspect the target before asking questions. If that specialist is unavailable, use [Repository Context Fallback](references/repository-adapter.md).
4. Select an execution level.

| Level | Use when | Artifact policy | Minimum evidence |
| --- | --- | --- | --- |
| **Compact** | The change is local, reversible, and does not alter behavior contracts, shared boundaries, or external dependencies | Keep the Risk Map and Contract in the conversation | Focused diff plus available targeted checks |
| **Standard** | One bounded subsystem changes behavior, state, data, or an interface | Use conversational handoff; persist only when the task is long-running or handed off | Applicable tests and static/runtime checks; independent review when risk warrants it |
| **Expanded** | Multiple subsystems, shared contracts, security, data meaning, migration, or rollout order are involved | Persist the contract, plan, and evidence when the user supplies or authorizes a location | Consumer checks, compatibility and rollout gates, and independent review |

5. For durable handoff, read [Artifact Contracts](references/artifact-contracts.md). Choose the artifact location in this order: user-provided location, an existing repository convention the user has authorized, otherwise conversation-only output. Do not create workflow files in a target repository merely because this skill ran.

## Compose Existing Skills

Use the repository's existing phase specialists when available instead of duplicating their rules:

- `repo-convention-intelligence` before the Risk Map
- `engineering-excellence-harness` during Build
- `testing` for scenario design before selecting test tools
- `verification-layer` during the Confidence Pack
- code, design, security, migration, or release guidance only when the change requires it
- `intent-capture` only for corrections accepted as durable
- `pr-checklist` only when pull-request finalization is requested

If a specialist is unavailable, perform the smallest equivalent procedure from current repository evidence.

## Operating Principles

- Inspect evidence before asking questions.
- Clarify through an executable contract, not a detached question list.
- Do not ask the user for facts that the repository or supplied artifacts can answer.
- Ask only when a decision materially changes behavior, scope, compatibility, risk, or an irreversible path.
- Isolate unresolved dependencies behind explicit, replaceable seams and continue unaffected work.
- Record what proved a claim, not merely that a check passed.
- Do not expand authority, commit, publish, deploy, or mutate external systems unless requested.

## Transition Gates

- **Risk Map → Contract**: affected boundaries and regression surfaces are known; uncertainty is classified with evidence.
- **Contract → Build**: another agent can implement and verify without hidden chat context; verdict is `BUILD READY` or `BUILD READY WITH GATES`.
- **Build → Integration**: the smallest useful vertical result works; available targeted checks pass; unavailable checks and contract deltas are recorded.
- **Integration → Confidence**: required dependencies are integrated or explicit Integration/Release gates have owners and resolution conditions; no hidden temporary seam remains.
- **Confidence → Close**: executed evidence, impact review, applicable independent review, decision closure, and a final verdict exist.

Do not label work as being in the next phase when its gate is not satisfied. Continue only independent tracks that remain safe.

## 1. Risk Map

1. Read the request, supplied specification, current implementation, tests, and relevant history.
2. Trace entry points, domain rules, interfaces, state transitions, side effects, persistence, configuration, deployment boundaries, and consumers that can be affected.
3. Reconcile plans and documentation with current code and execution state. Mark stale or already implemented claims instead of repeating the work.
4. Describe the current behavior, intended behavior, collision points, reusable boundaries, constraints, and regression surface with evidence.
5. Classify uncertainty:
   - **Verified**: directly supported by code, tests, logs, supplied contracts, or user input
   - **Assumed**: reversible and safely inferred from an established pattern
   - **Decision**: requires human choice because it changes behavior, scope, compatibility, or risk
   - **Dependency**: requires an external artifact, system, environment, team, or approval
6. Ask before inspection only when the target cannot be located or different interpretations would create materially different investigations.

The Risk Map must explain the behavior delta, not only list files.

## 2. Executable Contract

Draft the contract before asking for decisions:

- objective and observable outcome
- scope and explicit non-scope
- entry points and preconditions
- domain rules, state transitions, and side effects
- interfaces, data meaning, failure behavior, and compatibility
- dependency seams, temporary substitutes, and replacement conditions
- acceptance criteria and regression expectations

Check every proposed implementation against current repository rules and architecture. Reject stale plan snippets or paths that conflict with observed code.

For each Decision and Dependency, record:

- blocking phase: `Build`, `Integration`, or `Release`
- owner or decision maker
- resolution condition and verification method
- unaffected work that may continue

For multi-repository or staged delivery, define rollout order, compatibility window, missing-contract behavior, rollback path, and the difference between source implementation and deployed state.

Ask concrete questions using observation, current draft, options and impacts, recommended default, and work that can proceed regardless.

End with one build verdict:

- **BUILD READY**: the implementation contract is closed
- **BUILD READY WITH GATES**: implementation may start, but named Integration or Release gates remain
- **BUILD BLOCKED**: safe implementation cannot start without a Decision or Dependency

## 3. Dependency-Aware Build

1. Convert the contract into a dependency graph of work units.
2. Start with the smallest vertical result that exposes real behavior early.
3. Parallelize only independent tracks and only when available tooling and authority make it safe.
4. Use mocks, simulators, adapters, or fixtures only as clearly labeled temporary seams with replacement conditions.
5. Add or update checks at the boundary that best protects the changed behavior. Do not force a particular development ritual.
6. After each work unit, record contract deltas and return to the Contract when behavior or data meaning changes.

## 4. Progressive Integration

1. Integrate one ready boundary at a time.
2. Validate the affected behavior immediately after each integration to keep failures attributable.
3. Distinguish local source readiness from availability in the target environment.
4. Verify compatibility, failure, recovery, migration, and rollback behavior when applicable.
5. Remove temporary seams or record the exact gate that still owns them.
6. If an integrated dependency contradicts the contract, update the contract before adapting implementation.

## 5. Confidence Pack

1. Use the target repository's actual commands and available tools. Do not invent missing scripts or substitute fake environment values.
2. Validate only risk-relevant primary, failure, boundary, and state-transition scenarios.
3. Expand checks to affected consumers, interfaces, environments, security boundaries, or rollout paths when the Risk Map requires it.
4. For non-trivial work, use independent review context when available:
   - provide the request or contract, diff, executed evidence, and unresolved items
   - omit implementation-session reasoning and desired conclusions
   - collect findings first; apply fixes in the implementation context
5. Reconcile every Verified, Assumed, Decision, and Dependency item as confirmed, changed, or deferred.
6. Separate generated checks from executed evidence and record skipped checks with reasons.
7. Promote only human-reviewed, reusable corrections into durable repository memory.

End with one final verdict:

- **READY**: acceptance criteria and required validation are closed with evidence
- **READY WITH DEFERRED**: the core outcome is verified and every remaining item has an owner and confirmation method
- **NOT READY**: a core outcome or required gate failed or remains blocked

## Loop Back

- Return to the Risk Map when repository evidence contradicts the request or plan.
- Return to the Contract when behavior, data meaning, compatibility, or scope changes.
- Return to Integration when a dependency differs from its contract.
- Return a validation failure to the phase that owns its cause.

Record why the loop occurred and what changed so the same decision is not repeated.
