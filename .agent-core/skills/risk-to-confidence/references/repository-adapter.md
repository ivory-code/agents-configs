# Repository Context Fallback

Use this reference only when a repository-convention or context-discovery specialist is unavailable. Produce the smallest handoff needed to build a Risk Map; leave scenario design and verification selection to their phase specialists.

## Evidence Priority

1. System and user instructions
2. Applicable repository and path-scoped instructions
3. Human-reviewed baselines, contracts, and runbooks
4. Current code, tests, manifests, configuration, and execution evidence
5. Plans, general documentation, and examples

Treat a plan as an input, not proof of current state. Distinguish source implementation, committed state, deployed state, and observed runtime behavior.

## Inspect

1. Resolve the repository root, current branch or revision, default baseline, and working-tree changes.
2. Discover applicable instruction surfaces without assuming a specific agent vendor.
3. Read the nearest manifests and configuration to identify:
   - language, runtime, package or build system
   - available scripts and validation tools
   - workspace, module, or service boundaries
4. Trace only the target surface:
   - entry points and preconditions
   - domain rules and state transitions
   - interfaces and data meaning
   - side effects, persistence, configuration, and deployment boundaries
   - tests, consumers, and reusable components or modules
5. Record the validation commands and tools that actually exist without selecting a test strategy yet.
6. Discover task-specific skills by capability and load them only when their phase begins.
7. Stop once the changed behavior, applicable rules, reusable boundaries, available validation surface, and material risks are clear.

Do not expose credentials, secret values, private customer data, or unrelated local paths in artifacts.

## Context Handoff

```text
[Repo Context]
- baseline and current change evidence:
- applicable instructions:
- language/runtime/build system:
- affected boundaries:
- reusable surfaces:
- validation commands and tools:
- current versus intended behavior:
- external or environment dependencies:
- material risks:
- unresolved evidence:
```
