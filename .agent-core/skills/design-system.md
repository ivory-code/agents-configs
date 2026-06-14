# Design System

## Purpose

Use the repository's existing visual language, components, and tokens before creating custom UI.

## Trigger

Use this skill for UI, layout, component, theme, visual polish, accessibility, or design-system work.

## Required Context

Inspect only the relevant surface:

- existing `shared/ui`, `components`, `theme`, `tokens`, or equivalent directories
- nearby screens/components
- typography, spacing, color, radius, shadow patterns
- platform or accessibility conventions

## Decision Order

```text
existing design-system component > local shared component > adapted wrapper > custom component
existing token > local constant > scoped hardcoded value
```

## Rules

- Preserve established product visual language unless redesign is the task.
- Reuse tokens for color, spacing, typography, radius, and shadow.
- If a hardcoded value is necessary, keep it scoped and explain why.
- Keep accessibility states visible: disabled, loading, empty, error, focus/press.
- Avoid generic average UI when the product needs distinct brand memory.

## Validation Gate

- existing components/tokens checked
- responsive/safe-area/platform behavior considered
- accessibility labels/roles checked where relevant
- visual risk noted when not manually verified

## Escalation

Ask before changing foundational tokens, theme names, shared primitives, or product-wide visual direction.
