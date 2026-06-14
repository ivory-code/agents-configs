# Skill System Architect

## Purpose

Design, refactor, and validate reusable agent skills so they stay portable, concise, and useful across repositories.

## Trigger

Use this skill when:

- creating a new reusable skill
- restructuring `.agent-core/skills`, `.codex`, or `.claude` instructions
- turning repeated agent behavior into a reusable workflow
- deciding whether content belongs in a core skill, profile, reference, or project-local doc
- reviewing skills for overlap, bloat, missing validation, or weak triggers

## Required Context

Inspect before editing:

- `.agent-core/skills/index.md`
- existing related skills
- `.codex/AGENTS.md` and `.claude/CLAUDE.md`
- repo inspection output or generated profile when project-specific
- `docs/UNIVERSAL_SKILLSET_BLUEPRINT.md` if present

## Operating Loop

1. Identify the repeated task or decision pattern.
2. Decide scope: core skill, profile, formal `SKILL.md`, reference, or project-local doc.
3. Write the trigger first. If the trigger is vague, the skill is not ready.
4. Keep the body procedural and concise.
5. Add a validation gate and output format.
6. Update the index/load order if the skill should be discoverable.
7. Check for duplication with existing skills.

## Placement Rules

- Core reusable rule: `.agent-core/skills/<name>.md`
- Repo-specific convention: target repo profile/doc generated from `.agent-core/blueprints/profile-template.md`
- Large reference table: `.agent-core/references/<topic>.md` when introduced
- Formal Codex skill: `<skill-name>/SKILL.md` only after the markdown skill is stable
- Agent-specific wording: `.codex/AGENTS.md` or `.claude/CLAUDE.md`

## Decision Rules

- MUST define concrete triggers.
- MUST include validation or done criteria.
- MUST keep volatile project details out of core skills.
- SHOULD split skills when one file mixes strategy, implementation, and validation.
- SHOULD prefer references for long examples.
- NEVER duplicate the same rule in Codex and Claude entry files; link to core.

## Validation Gate

- Skill has purpose, trigger, required context, operating loop, decision rules, validation gate, escalation.
- Skill is referenced in `skills/index.md` if it should be discoverable.
- Agent entry files mention it only if it belongs in the default load/optional list.
- No project-specific secrets, branch names, or volatile release numbers in core skills.

## Output Format

```text
[Skill Design]
- name:
- scope:
- trigger:
- owner layer:

[Changes]
- files:

[Validation]
- duplication check:
- portability check:
- done criteria:

[Follow-up]
- none | <next split/reference/formalization>
```

## Escalation

Pause before deleting or renaming existing skills, changing bootstrap behavior, or converting shared skills into tool-specific formats.
