# Skill Boilerplate

Use this template when creating a new reusable `.agent-core/skills/*.md` skill. Keep it generic, portable, and operational.

````md
# <Skill Name>

## Purpose

One or two sentences explaining what outcome this skill improves.

## Trigger

Use this skill when:

- <concrete task or request pattern>
- <codebase condition>
- <risk scenario>

Do not use this skill when:

- <out-of-scope task>

## Required Context

Inspect these before acting:

- <files/commands/signals>
- <profile or stack constraints>
- <user/business constraints>

## Operating Loop

1. Clarify the objective from existing context and evidence.
2. Separate observed facts, inferred intent, and human-reviewed policy.
3. Inspect the smallest sufficient surface.
4. Decide the approach and name the tradeoff.
5. Implement or produce the requested artifact.
6. Validate using the gate below; distinguish generated checks from executed evidence.
7. Report result, confidence, risk, and next step.

## Decision Rules

- MUST: <non-negotiable rule>
- SHOULD: <preferred default>
- MAY: <allowed escape hatch>
- NEVER: <dangerous behavior>

## Validation Gate

- <command/check 1>
- <command/check 2>
- <manual review item>

## Output Format

```text
[Intent]
- objective:
- evidence:
- confidence:

[What]
- change:

[Validation]
- generated:
- executed static/automated/build/runtime/manual:

[Risk]
- none | <risk>

[Next]
- none | <recommended next action>
```

## Escalation

Pause and ask the user before:

- <decision with non-obvious consequence>
- <irreversible action>
- <costly or policy-sensitive action>
````

## Quality Rules

- Keep the skill under 300 lines where possible.
- Put long examples or domain details in a separate reference file.
- Avoid repo-specific names unless this is a profile, not a core skill.
- Use concrete triggers and validation gates.
- Prefer operational checklists over motivational advice.
