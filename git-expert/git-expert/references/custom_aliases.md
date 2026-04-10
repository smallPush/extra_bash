# Custom Git Aliases

The user's environment provides the following custom Git aliases that you can use. Note that to use them non-interactively in a bash command, you should execute their underlying Git commands directly, or source `~/extra_bash/aliases.sh` first.

| Alias | Command | Description |
|---|---|---|
| `gaa` | `git add -A` | Stage all changes |
| `gc` | `$DOTLY_PATH/bin/dot git commit` | Interactive Dotly commit |
| `gca` | `git add --all && git commit --amend --no-edit` | Stage all and amend without editing |
| `gco` | `git checkout` | Checkout branch/commit |
| `gd` | `$DOTLY_PATH/bin/dot git pretty-diff` | View a pretty diff |
| `gs` | `git status -sb` | Short status with branch |
| `gf` | `git fetch --all -p` | Fetch all remotes and prune |
| `gps` | `git push` | Push changes |
| `gpsf` | `git push --force` | Force push changes |
| `gpl` | `git pull --rebase --autostash` | Pull with rebase and autostash |
| `gb` | `git branch` | List branches |
| `gl` | `$DOTLY_PATH/bin/dot git pretty-log` | View a pretty commit log |
| `gsq2` | `git reset --soft HEAD~2 && git commit` | Soft reset 2 commits and commit |
| `custom_squash_two_commits` | `git reset --soft HEAD~2 && git commit` | Same as gsq2 |
