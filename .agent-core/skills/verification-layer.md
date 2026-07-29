# Verification Layer

## Purpose

Design the checks, metrics, rubrics, and review loops needed before trusting agent-generated output.

## Trigger

Use this skill when:

- an AI-generated change, document, plan, or artifact needs review
- the task has release, production, business, or user-trust risk
- generated output looks plausible but may hide integration or intent errors
- the user asks how to validate a PR, feature, workflow, or agent result
- a repo needs stronger QA, E2E, eval, or review evidence

## Required Context

Inspect or collect:

- user request, commits, diff, and changed symbols
- changed behavior and affected users
- existing reviewed behavior or verification baseline
- existing tests, scripts, CI, E2E, and manual checks
- product/domain success criteria
- likely failure modes and edge cases
- what can be checked automatically versus what requires human judgment

## Operating Loop

1. Name the behavior or artifact being verified and the evidence that identified it.
2. Separate evidence levels:
   - observed: directly present in files, commits, tests, logs, or user input
   - inferred: connected by a deterministic rule or reasoned assumption
   - reviewed: explicitly accepted by a human or durable repo baseline
3. For behavior-bearing changes, map trigger, precondition, action, state change, side effect, and observable outcome.
4. Derive only the applicable primary, failure, boundary, and state-transition scenarios.
5. Split validation into three layers:
   - binary checks: repository-defined automated tests, schema or static analysis, build or packaging, runtime or interface contracts
   - quantitative metrics: latency, coverage, error rate, cost, size, throughput
   - qualitative rubrics: UX, architecture fit, domain correctness, maintainability, trust
6. Mark each layer as existing, missing, or needs expansion.
7. Select tools and runners after the verification intent is clear.
8. Prefer independent review context when judging generated output.
9. Turn missing checks into concrete commands, scenarios, fixtures, or rubric questions.
10. Decide whether the result is ready, near-ready, or review-only.

## Decision Rules

- MUST validate integration and domain behavior, not only local happy paths.
- MUST distinguish evidence from confidence.
- MUST distinguish generated checks from checks that were actually executed.
- MUST identify the highest-risk unverified assumption.
- MUST request human review when intent evidence conflicts or remains low confidence.
- SHOULD use a separate review agent/session for important generated output.
- SHOULD capture repeated validation needs into repo docs, tests, or manifests.
- NEVER call generated output production-ready solely because it compiles.

## Validation Gate

Before finishing, provide:

- commands or checks run
- checks that still need a human
- missing fixtures or environments
- residual risk
- next action to convert review-only output into durable evidence

## Output Format

```text
[Verification Layer]
- target:
- intent evidence:
- confidence:
- lifecycle:
- scenario axes:
- binary checks:
- metrics:
- rubrics:

[Status]
- ready | near-ready | review-only:
- generated vs executed evidence:
- highest-risk gap:
- next validation action:
```

## Escalation

Pause when the output affects production data, security, regulated or evidence-sensitive decisions, privacy, or irreversible public messaging.
