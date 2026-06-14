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

1. Clarify the objective from existing context.
2. Inspect the smallest sufficient surface.
3. Decide the approach and name the tradeoff.
4. Implement or produce the requested artifact.
5. Validate using the gate below.
6. Report result, risk, and next step.

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
[What]
- objective:
- change:

[Validation]
- lint/typecheck/test/build:

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
