---
name: task-cleanup
description: Safely closes completed change-bearing tasks by removing agent-created Git worktrees, their task directories, and local and remote task branches after delivery is preserved. Use at the end of a task that created a dedicated worktree or branch, after a PR is merged or an unmerged task is explicitly abandoned, after direct delivery to a durable branch, or when the user asks to clean up completed work. Do not remove targets while dirty state, an open PR, required CI or monitoring, an unpreserved commit, or a protected or current branch still depends on them.
---

# Task Cleanup

Remove only task-scoped resources after proving that the delivered result no longer depends on them.

## Establish Completion

Treat destructive cleanup as authorized only when the user explicitly requests it or an active user or repository policy explicitly authorizes deletion of completed task worktrees, directories, and branches. Selecting R2C or reaching an evidence verdict alone is not authorization.

Verify one completion condition:

- a direct-delivery commit is present on the intended durable remote branch
- the task PR is merged
- a closed, unmerged task was explicitly abandoned
- local-only work was preserved at a user-approved destination or explicitly abandoned

An open PR, required CI run, deployment, monitor, or handoff that still uses the branch means cleanup is not yet eligible.

## Inventory Exact Targets

1. Resolve the primary repository, default or delivery branch, remotes, current worktree, and current branch.
2. List registered worktrees with `git worktree list --porcelain`.
3. Identify only resources created for the completed task:
   - registered task worktree
   - exact associated directory, including a sibling Desktop directory or nested agent worktree
   - local task branch
   - upstream or remote task branch
   - related PR, checks, deployments, or monitors
4. Inspect every candidate worktree with `git status --porcelain=v1 --untracked-files=all`.
5. Enumerate ignored entries separately with `git status --ignored=matching --porcelain=v1 --untracked-files=all` or an equivalent command. When Git collapses an ignored directory into one entry, enumerate that subtree before disposal or preserve the whole directory unless an explicit user or repository policy declares the entire subtree disposable.
6. Record the exact local task-tip OID and the full remote ref plus its OID when present.
7. Prove delivery preservation through ancestry, a verified squash/rebase delivery, or explicit abandonment.

Do not infer ownership or completion from a directory or branch name alone.
Repository-proven reproducible caches or build outputs may be marked disposable. Preserve local configuration, credentials, screenshots, logs, and user-created artifacts unless the user explicitly approves their disposal.

## Apply Safety Gates

Remove a target only when every applicable condition is true:

- it is linked to the completed task
- it is not the primary or current worktree
- its branch is not a default, protected, shared integration, or release branch
- the worktree has no modified, staged, or untracked files
- every ignored entry that removal would delete was preserved or explicitly deemed disposable
- delivery preservation is proven by one of:
  - the task tip is reachable from the durable target
  - a merged PR or explicit direct-delivery record is tied to the exact expected task head, local and remote tips have not advanced, and the durable target preserves the intended patch or content
  - abandonment is explicit and identifies the exact task head being discarded
- no open PR, required CI, deployment, monitor, or handoff needs it
- no other worktree uses the branch
- the exact remote, full branch ref, and expected remote OID are confirmed before remote deletion
- any leftover directory is both task-created and empty

Never use forced worktree removal, unconditional force-push, recursive directory deletion, or name-only branch deletion for routine completion cleanup. Both remote and local branch deletion must be conditional on the expected OID. If any gate fails, retain the target and report the blocker.

## Remove In Safe Order

1. Operate from the primary repository or another non-target worktree; never remove the current working directory. For a branch-only task in the primary checkout, switch the clean checkout to its durable branch first.
2. Remove the registered task worktree with `git worktree remove <exact-path>` without `--force`.
3. Verify the associated directory is gone. If an empty task-created directory remains, remove only that exact empty directory with `rmdir`.
4. Do not run repository-wide worktree pruning after a successful removal. For an already-missing stale record, run `git worktree prune --dry-run --verbose` and prune only when every listed record is proven task-owned; otherwise defer.
5. Immediately re-read the full remote ref. If absent, skip it. If its OID differs from the expected task head, defer. Otherwise delete it conditionally with `git push --force-with-lease=refs/heads/<branch>:<expected-oid> <remote> :refs/heads/<branch>`.
6. After the ancestry, alternate-delivery, or abandonment proof passes, delete the exact local ref atomically with `git update-ref -d refs/heads/<branch> <expected-local-oid>`. Defer if the ref no longer matches.
7. Verify the worktree path, directory, local branch, and remote branch are all absent.

If a task did not create a worktree, directory, or branch, skip that target rather than manufacturing cleanup work.

## Report One Verdict

- **CLEANED**: every eligible task-scoped target was removed and absence was verified
- **CLEANUP NOT NEEDED**: the task created no cleanup targets
- **CLEANUP DEFERRED**: name each retained target, the failed safety gate, and the event that will make cleanup eligible

Do not describe a change-bearing task as fully cleaned while task-created resources remain without a `CLEANUP DEFERRED` reason.
