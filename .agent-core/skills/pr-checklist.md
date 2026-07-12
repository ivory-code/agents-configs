# PR Checklist

## Purpose

Finalize changes with concise validation evidence, risk notes, and no unnecessary context or files.

## Trigger

Use this skill before committing, opening a PR, summarizing a branch, or handing work to another agent.

## Required Context

Use the repo inspection summary, git diff, and validation outputs. Do not re-read unrelated files.

## Checklist

1. Scope is clear and limited to the requested work.
2. The intended behavior change is stated with user, commit, diff, test, or reviewed-baseline evidence.
3. Relevant primary, failure, boundary, and state-transition scenarios were considered.
4. Low-confidence or conflicting intent is marked for human review.
5. No unrelated files or generated noise are included.
6. Local conventions were followed.
7. Existing reusable components/services/config were preferred.
8. Validation commands from repo context were run or explicitly skipped with reason.
9. Generated drafts are not reported as passing evidence unless they were executed.
10. Risky areas are called out: auth, storage, payment, privacy, release, migration.
11. Accepted corrections that should help future changes were captured in durable repo memory.
12. Follow-up work is separated from this PR.

## Suggested Report

```text
[Summary]
- intended behavior:
- evidence:
- confidence:

[Scenario Coverage]
- primary/failure/boundary/state transition:

[Validation]
- lint:
- typecheck:
- generated:
- executed test/build/manual:

[Risk]
- none | <risk>

[Follow-up]
- none | <next item>
```

## Escalation

Pause before staging, committing, pushing, deleting branches, or changing release/version metadata unless explicitly requested.
