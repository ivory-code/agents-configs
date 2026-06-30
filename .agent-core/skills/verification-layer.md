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

- changed behavior and affected users
- existing tests, scripts, CI, E2E, and manual checks
- product/domain success criteria
- likely failure modes and edge cases
- what can be checked automatically versus what requires human judgment

## Operating Loop

1. Name the behavior or artifact being verified.
2. Split validation into three layers:
   - binary checks: pass/fail tests, typecheck, lint, build, E2E, API contracts
   - quantitative metrics: latency, coverage, error rate, cost, size, throughput
   - qualitative rubrics: UX, architecture fit, domain correctness, maintainability, trust
3. Mark each layer as existing, missing, or needs expansion.
4. Prefer independent review context when judging generated output.
5. Turn missing checks into concrete commands, scenarios, fixtures, or rubric questions.
6. Decide whether the result is ready, near-ready, or review-only.

## Decision Rules

- MUST validate integration and domain behavior, not only local happy paths.
- MUST distinguish evidence from confidence.
- MUST identify the highest-risk unverified assumption.
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
- binary checks:
- metrics:
- rubrics:

[Status]
- ready | near-ready | review-only:
- highest-risk gap:
- next validation action:
```

## Escalation

Pause when the output affects production data, security, payment, legal claims, medical claims, privacy, or irreversible public messaging.
