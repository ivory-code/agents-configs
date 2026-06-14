# Agent Skills Index

Use the smallest relevant skill set. Do not load every skill by default.

## Step 1: Repo Context Always First

| Situation | Required Skill |
|---|---|
| Any new repo/session or before code edits | `repo-convention-intelligence` |

## Step 2: Operating Harness

| Situation | Required Skill |
|---|---|
| Skill system design / cleanup | `skill-system-architect` |
| Product strategy / roadmap / positioning / monetization | `executive-operating-harness` |
| Non-trivial code change / refactor / release risk | `engineering-excellence-harness` |

## Step 3: Task Skills

| Task Type | Required Skills |
|---|---|
| Code implementation/refactor | `code-style` |
| UI / layout / component / theme | `design-system`, `code-style` |
| Tests / risky logic / PR validation | `testing` |
| PR finalize | `pr-checklist` |

## Token Budget Rules

1. Run or approximate repo inspection before reading broad docs.
2. Read only the skill that matches the task.
3. Prefer scripts and summaries over repeated manual file scanning.
4. Reuse context gathered earlier in the same task.
5. Stop gathering context once commands, architecture, conventions, and risks are clear.

## Completion Rule

Finish with validation evidence or a clear reason validation could not run.
