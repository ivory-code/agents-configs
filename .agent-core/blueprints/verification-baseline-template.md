# Verification Baseline Boilerplate

Use this optional template when a target repository has important behavior or QA policy that code structure alone cannot explain. A suitable target path is `docs/VERIFICATION_BASELINE.md`.

Create or update the shared baseline on the repository's canonical branch, normally the default branch, only after human review. Branch analysis may propose a correction, but should not silently convert generated observations into policy.

Store durable contracts, not a full generated graph or one-off branch output.

````md
# Verification Baseline: <repo-name>

## Ownership

- Default branch:
- Owners/reviewers:
- Last reviewed:

## Critical Behaviors

| ID | Actor | Trigger / Precondition | Action | State Change | Side Effect | Observable Outcome | Criticality |
|---|---|---|---|---|---|---|---|
| `<stable-id>` |  |  |  |  |  |  | high / medium / low |

## Verification Axes

| Behavior ID | Primary | Failure | Boundary | State Transition |
|---|---|---|---|---|
| `<stable-id>` |  |  |  |  |

## Entrypoints And Anchors

| Behavior ID | Route / Screen / Endpoint / Command | Stable Source Anchor | Observable Selector / Contract |
|---|---|---|---|
| `<stable-id>` |  |  |  |

## Fixtures And Environment

- Reusable fixtures/mocks:
- Auth/permission setup:
- Required environment:
- External dependencies:

## Evidence Commands

```bash
<focused test command>
<integration or E2E command>
<build or contract command>
```

## Known Uncertainty

| Topic | Observed Evidence | Inference | Confidence | Human Review Needed |
|---|---|---|---|---|
|  |  |  | high / medium / low | yes / no |

## Accepted Corrections

| Incorrect Or Missing Inference | Reviewed Correction | Durable Rule | Evidence |
|---|---|---|---|
|  |  |  |  |
````

## Promotion Rules

- Keep behavior ids stable and product-oriented; do not name internal helpers or file layout.
- Add only behavior that affects repeated review or verification decisions.
- Record evidence and uncertainty instead of presenting inference as fact.
- Promote a branch lesson only after a human accepts it as durable.
- Remove stale contracts when the behavior or source anchor no longer exists.
