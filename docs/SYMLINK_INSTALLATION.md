# Symlink Installation

Use symlink mode when this repository should remain the source of truth for several local projects.

Copy mode is safer for one-off projects. Symlink mode is better when you want updates to `.agent-core`, `.codex`, or `.claude` to immediately appear in target repos without copying the same files again.

## Copy Mode

```bash
./scripts/bootstrap.sh all /path/to/project
```

Copy mode writes independent files into the target project:

```text
/path/to/project/.agent-core/
/path/to/project/.codex/
/path/to/project/.claude/
```

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
/path/to/project/.codex      -> /path/to/agents-configs/.codex
/path/to/project/.claude     -> /path/to/agents-configs/.claude
```

Use this when:

- the same person uses the same configs across many local repos
- skill updates should apply everywhere immediately
- you want to avoid duplicated local copies drifting apart

## Safety Checks

Preview an install:

```bash
./scripts/bootstrap.sh --dry-run --link all /path/to/project
```

Check an installed target:

```bash
./scripts/doctor.sh /path/to/project
```

Replace existing copied directories with symlinks:

```bash
./scripts/bootstrap.sh --link --force all /path/to/project
```

Only use `--force` after reviewing the target repo. It replaces matching `.agent-core`, `.codex`, and `.claude` paths.

## Recommended Strategy

- Use symlink mode for personal local repos where you control the machine.
- Use copy mode for public repos where contributors should see stable committed files.
- Keep durable, vendor-neutral rules in `.agent-core`.
- Keep tool-specific files thin and pointer-based.
- Promote repeated project-specific lessons into the target repo, not into this portable core.
