# Executive Operating Harness

## Purpose

Apply CEO, CPO, CMO, CDO, and CTO lenses to make product, business, design, and technology decisions more successful under real constraints.

## Trigger

Use this skill when:

- defining product strategy, roadmap, positioning, monetization, or growth
- prioritizing what to build next
- evaluating whether a feature will make the product more attractive or sustainable
- balancing user value, brand trust, engineering cost, and business outcomes
- preparing launch, app store metadata, PRD, pitch, or go-to-market direction

## Required Context

Inspect or infer:

- target user and painful situation
- current product stage and constraints
- available data, feedback, or market signals
- current architecture/release constraints if implementation is involved
- success metric and time horizon

## Operating Loop

1. State the decision to be made.
2. Run the five lenses quickly.
3. Identify the highest-risk assumption.
4. Choose the smallest move that creates learning or user value.
5. Define implementation/validation criteria.
6. Report tradeoffs and the next decision point.

## Five Lenses

| Lens | Ask | Watch Out For |
|---|---|---|
| CEO | What is the highest-leverage move under current constraints? | spreading focus across too many bets |
| CPO | What user problem does this solve and how will the user feel it? | building features without a user moment |
| CMO | Why will users care, remember, and share it? | vague positioning or generic benefit copy |
| CDO | Does the experience feel distinct, trustworthy, and emotionally coherent? | usable but forgettable UI |
| CTO | Can we build, maintain, measure, and scale this safely? | clever feature with fragile foundations |

## Decision Rules

- MUST distinguish user value from implementation excitement.
- MUST name the target segment and use case before roadmap recommendations.
- MUST define one primary success metric for strategic work.
- SHOULD favor small validated loops over large speculative builds.
- SHOULD preserve trust, privacy, and emotional safety for mental-care products.
- NEVER present clinical/medical claims unless legally and scientifically validated.

## Output Format

```text
[Decision]
- objective:
- recommended move:

[Five-lens Review]
- CEO:
- CPO:
- CMO:
- CDO:
- CTO:

[Validation]
- success metric:
- riskiest assumption:
- smallest test:

[Next]
- implementation slice:
- later:
```

## Escalation

Pause when the decision affects pricing, legal/medical claims, privacy policy, paid acquisition budget, or irreversible product positioning.
