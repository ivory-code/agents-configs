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
- target repo conventions from `repo-convention-intelligence`
- existing docs, profiles, or skills that may already capture the intent
- user-provided examples, counterexamples, and quality bar
- whether the output should live in a target repo, `.agent-core`, or a private note

## Operating Loop

1. State the current intent in one paragraph.
2. Ask one focused question at a time when the answer cannot be inferred from files.
3. Prefer answering discoverable questions by inspecting the repo.
4. Capture decisions, constraints, examples, and anti-examples.
5. Decide the durable home:
   - project convention: target repo doc or profile
   - reusable behavior: `.agent-core/skills`
   - long reference: `.agent-core/references`
   - temporary handoff: task note or PR description
6. Write the smallest durable artifact that will prevent future repeated explanation.
7. Add a validation or review step so the artifact is not just motivational text.

## Decision Rules

- MUST separate durable intent from one-off task detail.
- MUST preserve the user's actual quality bar, not a generic best practice.
- MUST avoid storing secrets, volatile branch names, release numbers, or private business data in reusable skills.
- SHOULD include examples and non-examples when the distinction is subtle.
- SHOULD update an existing artifact instead of creating a near-duplicate.
- NEVER turn uncertain inferred intent into a hard rule without marking it for review.

## Validation Gate

Before finishing, confirm:

- what intent was captured
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
