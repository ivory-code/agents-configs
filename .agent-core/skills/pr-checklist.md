# PR Checklist

## Purpose

Finalize changes with concise validation evidence, risk notes, and no unnecessary context or files.

## Trigger

Use this skill before committing, opening a PR, summarizing a branch, or handing work to another agent.

## Required Context

Use the repo inspection summary, git diff, and validation outputs. Do not re-read unrelated files.

## Checklist

1. Scope is clear and limited to the requested work.
2. No unrelated files or generated noise are included.
3. Local conventions were followed.
4. Existing reusable components/services/config were preferred.
5. Validation commands from repo context were run or explicitly skipped with reason.
6. Risky areas are called out: auth, storage, payment, privacy, release, migration.
7. Follow-up work is separated from this PR.

## Suggested Report

```text
[Summary]
-

[Validation]
- lint:
- typecheck:
- test/build/manual:

[Risk]
- none | <risk>

[Follow-up]
- none | <next item>
```

## Escalation

Pause before staging, committing, pushing, deleting branches, or changing release/version metadata unless explicitly requested.
