# Agent Operating Model

This repository is built around one idea: agent productivity depends less on a bigger prompt and more on a durable loop for context, intent, and verification.

## The Loop

```text
default-branch baseline + branch evidence
  -> change intent + confidence
  -> behavior lifecycle + scenario axes
  -> relevant skill + small action
  -> generated and executed evidence
  -> human-reviewed correction
  -> durable repo memory
```

The loop should be cheap enough to repeat in every repo and explicit enough that another agent can continue later. Tool or runner choice comes after the changed behavior and verification need are clear.

For end-to-end non-trivial delivery, `risk-to-confidence` turns this loop into explicit phase gates:

```text
Risk Map -> Executable Contract -> Dependency-Aware Build
  -> Progressive Integration -> Confidence Pack
```

The orchestrator composes the existing repository, engineering, testing, and verification skills; it does not replace their detailed rules.

## 1. Shared Source Of Truth

Agent configs drift when every project and every agent tool gets its own copied instruction set.

Use `.agent-core` as the shared, vendor-neutral source of truth:

- keep reusable skills in `.agent-core/skills`
- keep inspection scripts in `.agent-core/scripts`
- keep Codex and Claude files as thin entrypoints
- use symlinks for personal local repos when one central copy should update many projects
- use copies for public/project-owned repos where stable committed files matter more than central updates

## 2. Intent Capture

Agents often fail because the user's real judgment is implicit. The user knows what good looks like but has not written it down yet.

When a conversation reveals repeated context, constraints, or taste, capture it:

- project-specific convention -> target repo doc/profile
- reusable agent behavior -> `.agent-core/skills`
- long reference -> `.agent-core/references`
- temporary handoff -> PR body, task note, or decision log

Keep shared behavior and verification baselines on the default branch. Treat branch-local observations as proposals until a human accepts them as durable corrections.

The goal is to reduce repeated explanation in future sessions.

## 3. Taste Calibration

AI can produce many plausible options. The human bottleneck often becomes deciding which option is actually good.

When a user reveals taste, convert it into reusable criteria:

- what good looks like
- what failure looks like
- which signals are explicit user input
- which signals are inferred and need confirmation
- how the criteria can be checked next time

Taste should not stay as a vague preference in one chat. Durable taste becomes a rubric that future agents can apply before asking the user to re-explain the same judgment.

## 4. Verification Layer

AI-generated output can look correct while creating hidden integration, domain, or intent debt.

Before trusting important generated output, define:

- binary checks: tests, typecheck, lint, build, E2E, API contracts
- quantitative metrics: latency, cost, coverage, error rate, size
- qualitative rubrics: architecture fit, UX clarity, domain correctness, maintainability

For changed behavior, first map trigger, precondition, action, state change, side effect, and observable outcome. Then consider primary, failure, boundary, and state-transition scenarios. Do not select a test runner before the scenario is clear.

Keep three evidence levels separate:

- observed: present in user input, commits, diff, files, tests, or logs
- inferred: connected by a rule or reasoned assumption
- reviewed: accepted by a human or durable repo baseline

A generated test is a proposal. It becomes validation evidence only after execution or explicit human verification.

For important work, use independent review context. The same agent session that made the work is biased toward defending it.

## 5. Correction Lifecycle

Repeated agent value comes from correction, not from storing every output.

```text
infer -> review -> accept or reject -> store durable correction -> reuse on the next change
```

Use [the verification baseline template](../.agent-core/blueprints/verification-baseline-template.md) when a repo has important flows, scenario policy, fixtures, or uncertainty that code structure cannot explain. Keep it small and human-reviewed.

## 6. Reusable Project Layer

`agents-configs` is meant to be reusable across new and existing repositories.

It answers:

- How should an agent enter a repo?
- Which local conventions should it respect?
- Which skill should it load?
- How should it capture intent, taste, and validation evidence?

It should stay portable:

- keep product-specific context in the target repo
- keep reusable agent behavior in `.agent-core`
- keep tool-specific entrypoints thin
- keep reviewed behavior and QA memory in the target repo
- use copy mode when the target repo should own its config
- use symlink mode when one local source of truth should update many repos

This reduces repeated human effort:

- less repeated explanation to agents
- less unreviewed generated output
- more reusable quality judgment
- more durable repo-local knowledge

## 7. Practical Rule

Do not make agents smarter by loading everything.

Make agents more useful by giving them:

1. the current repo context
2. the default-branch baseline and current branch evidence
3. an explicit change intent and confidence
4. the smallest relevant skill
5. a calibrated quality bar
6. a clear validation layer
7. a place to store reviewed, durable lessons
