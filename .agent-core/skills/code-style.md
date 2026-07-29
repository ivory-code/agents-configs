# Code Style

## Purpose

Keep code readable, typed, and consistent with the current repository's observed conventions instead of forcing a universal framework style.

## Trigger

Use this skill when writing, reviewing, or refactoring code after `repo-convention-intelligence` has identified the active conventions.

## Required Context

Use the repo inspection summary plus nearby files that match the target surface.

Check:

- naming patterns
- dependency, import, or include conventions
- module, type, function, or declaration style
- error and lifecycle conventions
- module, service, adapter, or interface boundaries
- formatting, linting, compilation, or static-analysis commands

## Universal Rules

- Follow local conventions unless they are clearly unsafe.
- Keep the smallest source of truth; derive values where possible.
- Preserve type and schema contracts; handle unknown inputs explicitly.
- Prefer clear boundaries over large mixed files.
- Avoid unrelated rewrites in scoped changes.
- Remove dead debug logs unless the repo intentionally keeps them.

## Reuse Rules

Before adding new code, search for:

- existing shared module, library, component, or command
- existing service, utility, adapter, or helper
- existing schema, resource, asset, or configuration
- existing test helper
- existing mapper/adapter

Create new abstraction only when duplication or boundary pressure is visible.

## Validation Gate

- formatting, linting, compilation, or static-analysis commands from repo context
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
