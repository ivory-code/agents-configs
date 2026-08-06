# Symlink Installation

Use symlink mode when this repository should remain the source of truth for several local projects.

Copy mode is safer for one-off projects. Symlink mode is better when you want updates to `.agent-core`, `.agents`, `.codex`, or `.claude` to immediately appear in target repos without copying the same files again.

## Copy Mode

```bash
./scripts/bootstrap.sh all /path/to/project
```

Copy mode writes a project-owned configuration tree into the target project:

```text
/path/to/project/.agent-core/
/path/to/project/.agents/
/path/to/project/.codex/
/path/to/project/.claude/
```

The top-level directories no longer depend on this source checkout. The discovery adapters remain relative symlinks inside the copied tree so they resolve to the copied canonical skill packages.

Use this when:

- the project should own and commit its own agent instructions
- the target repo may be used on machines without access to this repo
- the target repo needs project-specific changes to the copied files

## Symlink Mode

```bash
./scripts/bootstrap.sh --link all /path/to/project
```

Symlink mode connects the target project back to this repository:

```text
/path/to/project/.agent-core -> /path/to/agents-configs/.agent-core
/path/to/project/.agents     -> /path/to/agents-configs/.agents
/path/to/project/.codex      -> /path/to/agents-configs/.codex
/path/to/project/.claude     -> /path/to/agents-configs/.claude
```

Use this when:

- the same person uses the same configs across many local repos
- skill updates should apply everywhere immediately
- you want to avoid duplicated local copies drifting apart

## Skill Discovery

The canonical formal skill packages live under `.agent-core/skills`:

- `.agents/skills/risk-to-confidence` is the formal Agent Skills discovery adapter.
- `.agents/skills/task-cleanup` is the completion-cleanup discovery adapter.
- `.claude/skills/risk-to-confidence` is the Claude Code discovery adapter.
- `.claude/skills/task-cleanup` is the Claude Code cleanup adapter.

The adapters are relative symlinks to their canonical packages. Copy mode preserves these internal links inside the target repository; symlink mode connects the top-level config directories back to this repository. Run `doctor.sh` after either installation to confirm that the top-level directories and selected discovery paths resolve.

For personal discovery without changing each target repository, link the canonical packages into the user-level skill directories:

```text
~/.codex/skills/risk-to-confidence -> /path/to/agents-configs/.agent-core/skills/risk-to-confidence
~/.codex/skills/task-cleanup       -> /path/to/agents-configs/.agent-core/skills/task-cleanup
~/.claude/skills/risk-to-confidence -> /path/to/agents-configs/.agent-core/skills/risk-to-confidence
~/.claude/skills/task-cleanup       -> /path/to/agents-configs/.agent-core/skills/task-cleanup
```

This keeps the canonical source outside product repositories while making both skills available across local sessions.

## Safety Checks

Preview an install:

```bash
./scripts/bootstrap.sh --dry-run --link all /path/to/project
```

Check an installed target:

```bash
./scripts/doctor.sh /path/to/project all
```

Use `codex` or `claude` for a strict single-tool installation check. Omit the mode to require the common core and formal skill discovery paths while treating tool-specific directories as optional.

Replace existing copied directories with symlinks:

```bash
./scripts/bootstrap.sh --link --force all /path/to/project
```

Only use `--force` after reviewing the target repo. It replaces matching `.agent-core`, `.agents`, `.codex`, and `.claude` paths.

Do not commit link-mode top-level symlinks to a shared or public repository: they contain checkout-specific absolute paths. Use copy mode when the installed configuration will be committed.

## Recommended Strategy

- Use symlink mode for personal local repos where you control the machine.
- Use copy mode for public repos where contributors should see stable committed files.
- Keep durable, vendor-neutral rules in `.agent-core`.
- Keep tool-specific files thin and pointer-based.
- Promote repeated project-specific lessons into the target repo, not into this portable core.
