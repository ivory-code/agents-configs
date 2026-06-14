# Code Style

## Purpose

Keep code readable, typed, and consistent with the current repository's observed conventions instead of forcing a universal framework style.

## Trigger

Use this skill when writing, reviewing, or refactoring code after `repo-convention-intelligence` has identified the active conventions.

## Required Context

Use the repo inspection summary plus nearby files that match the target surface.

Check:

- naming patterns
- import aliases and ordering
- component/function declaration style
- error/loading conventions
- service/hook/component boundaries
- lint/typecheck commands

## Universal Rules

- Follow local conventions unless they are clearly unsafe.
- Keep the smallest source of truth; derive values where possible.
- Avoid new `any`; use `unknown`, type guards, or explicit interfaces.
- Prefer clear boundaries over large mixed files.
- Avoid unrelated rewrites in feature work.
- Remove dead debug logs unless the repo intentionally keeps them.

## Reuse Rules

Before adding new code, search for:

- existing shared UI/component
- existing service/util/hook
- existing token/theme/config
- existing test helper
- existing mapper/adapter

Create new abstraction only when duplication or boundary pressure is visible.

## Validation Gate

- lint command from repo context
- typecheck command from repo context when available
- tests/build for high-risk changes
- explain any skipped validation

## Output Format

```text
[Code Quality]
- conventions followed:
- reused existing:
- new abstraction:
- validation:
- risk:
```
