# Taste Calibration

## Purpose

Turn a user's implicit taste, quality bar, and judgment criteria into explicit rubrics that future agent sessions can reuse.

## Trigger

Use this skill when:

- the user says something feels good, bad, polished, awkward, risky, or off
- multiple acceptable solutions exist and quality depends on judgment
- an agent needs to evaluate generated output beyond whether it passes tests
- a repeated review preference should become durable project memory
- a repo, product, document, or design needs a sharper definition of "good"

## Required Context

Inspect or collect:

- the artifact being judged
- examples the user considers good or bad
- existing product, code, design, or writing conventions
- audience and usage context
- non-negotiable constraints versus personal preference
- evidence already available from tests, previews, screenshots, metrics, or reviews

## Operating Loop

1. Name the artifact and the decision being made.
2. Ask for or infer contrast pairs: good example, bad example, borderline example.
3. Convert taste into 3-7 evaluation dimensions.
4. For each dimension, write:
   - what good looks like
   - common failure signs
   - how to verify it
5. Separate durable criteria from one-off preference.
6. Store durable criteria in the smallest appropriate place: repo profile, skill, PR note, test plan, checklist, or design guideline.
7. Reuse the rubric when judging future generated output.

## Decision Rules

- MUST distinguish personal preference from domain-critical quality.
- MUST preserve uncertainty when taste is inferred rather than stated.
- MUST include negative examples or failure signs when possible.
- SHOULD keep rubrics short enough to use during real work.
- SHOULD link rubric items to verification commands, screenshots, review steps, or fixtures when available.
- NEVER treat taste as a substitute for tests when behavior can be verified mechanically.

## Validation Gate

Before finishing, provide:

- the calibrated quality dimensions
- which dimensions are based on explicit user input versus inference
- how the rubric should be applied next time
- where the durable version was stored or why it stayed temporary

## Output Format

```text
[Taste Calibration]
- artifact:
- decision:
- quality dimensions:
- explicit user signals:
- inferred signals:
- failure signs:

[Reuse]
- store in:
- apply when:
- next evidence to collect:
```

## Escalation

Pause when taste affects brand identity, public messaging, accessibility, legal claims, safety, privacy, or high-cost irreversible decisions.
