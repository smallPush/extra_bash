---
name: git-expert
description: Advanced Git agent specialized in commit formatting, merge conflict resolution, generating PR summaries, and navigating branch histories. Leverages the user's custom git aliases and environment.
---
# Git Expert

This skill provides advanced workflows for handling Git operations, taking advantage of the user's customized environment aliases.

## Custom Aliases

You should prioritize using the user's custom aliases for repetitive tasks when they are available, or their underlying commands if running non-interactively.
See [references/custom_aliases.md](references/custom_aliases.md) for a comprehensive list of available aliases.

## Workflows

### Commit Formatting

1. Always gather context by reviewing the status and diffs. You can use the underlying commands of `gs` and `gd` to understand the changes before committing.
2. Formulate clear, concise commit messages that describe the *why* alongside the *what*.
3. If making a small fix to the previous commit, use the command underlying `gca` (`git add --all && git commit --amend --no-edit`).
4. To squash the last two commits, use the command underlying `custom_squash_two_commits` (`git reset --soft HEAD~2 && git commit`).

### Merge Conflicts

1. When a merge conflict occurs, identify the conflicted files (e.g., using `git status -sb`).
2. Inspect the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`) inside the files.
3. Read the surrounding code to understand the intent of both branches and manually resolve the conflicts.
4. Stage the resolved files and continue the merge/rebase process.

### PRs & Summaries

1. Use `git diff main...HEAD` (or the appropriate base branch) to read the full context of changes.
2. Provide a clear, bulleted summary of changes suitable for a Pull Request description, categorizing changes into logical blocks (e.g., "Features", "Bug Fixes", "Refactors").

### Branching & History

1. To understand the history of the repository, run `bash -c 'source ~/extra_bash/aliases.sh && gl'` to view the pretty-log, or use standard `git log` commands.
2. To view the diff with styling, run `bash -c 'source ~/extra_bash/aliases.sh && gd'`.
3. To update your local repository, use `git fetch --all -p` followed by `git pull --rebase --autostash`.
