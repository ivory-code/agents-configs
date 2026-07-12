# Intent Capture

## Purpose

Turn tacit knowledge, repeated explanations, and fragile plans into durable repo-local documentation, profiles, or skills.

## Trigger

Use this skill when:

- the user says they keep repeating the same context to agents
- a plan depends on unstated product, domain, or team judgment
- an agent is about to make a broad change from incomplete intent
- a session discovers useful repo knowledge that should help future sessions
- a reusable rule should become a profile, doc, or skill

## Required Context

Inspect or collect:

- current task and decision being made
- current branch evidence and the default-branch baseline
- target repo conventions from `repo-convention-intelligence`
- existing docs, profiles, verification baselines, or skills that may already capture the intent
- user-provided examples, counterexamples, and quality bar
- whether the output should live in a target repo, `.agent-core`, or a private note

## Operating Loop

1. State the current intent in one paragraph and cite whether it came from the user, commits, diff, or inference.
2. Ask one focused question at a time when the answer cannot be inferred from files.
3. Prefer answering discoverable questions by inspecting the repo.
4. Separate observed evidence, inferred intent, and human-reviewed policy.
5. Capture decisions, constraints, examples, and anti-examples.
6. Decide the durable home:
   - project convention: target repo doc or profile
   - reviewed behavior and QA policy: target repo verification baseline
   - reusable behavior: `.agent-core/skills`
   - long reference: `.agent-core/references`
   - temporary handoff: task note or PR description
7. Use the feedback lifecycle: infer -> human review -> accept/reject -> durable correction.
8. Write only the accepted, reusable lesson that will prevent future repeated explanation.
9. Add a validation or review step so the artifact is not just motivational text.

## Decision Rules

- MUST separate durable intent from one-off task detail.
- MUST preserve the user's actual quality bar, not a generic best practice.
- MUST treat branch-local output as a proposal until reviewed.
- MUST promote accepted corrections, not every generated observation, into durable repo memory.
- MUST avoid storing secrets, volatile branch names, release numbers, or private business data in reusable skills.
- SHOULD include examples and non-examples when the distinction is subtle.
- SHOULD keep shared baselines on the default branch unless the repo defines another canonical source.
- SHOULD update an existing artifact instead of creating a near-duplicate.
- NEVER turn uncertain inferred intent into a hard rule without marking it for review.

## Validation Gate

Before finishing, confirm:

- what intent was captured
- which evidence was observed, inferred, or human-reviewed
- where it was stored
- why that location is durable enough
- how a future agent should use it
- what remains user judgment rather than automation

## Output Format

```text
[Intent Capture]
- captured:
- artifact:
- scope:
- future trigger:

[Open Judgment]
- human decision:
- review point:
```

## Escalation

Pause before capturing private company strategy, personal data, credentials, medical/legal claims, or rules that would change behavior across many repos.
