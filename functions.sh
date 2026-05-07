# Sync files to server using rsync
function custom_rsync() {
  source $2
  echo "rsync -uzva --no-links --ignore-errors -e ssh $1 $SSH_CONNECTION:$PATH_SITE$PATH_RELATIVE_EXT"
  # Ask if is correct and execute
  if ask "Do you want execute the command?"; then
    rsync -uzva --no-links --ignore-errors -e ssh $1 $SSH_CONNECTION:$PATH_SITE$PATH_RELATIVE_EXT
  else
    echo "No"
  fi
}

# Interactively change directory using fzf
function cdd() {
  cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

# Quick jump to directories using z
function j() {
  fname=$(declare -f -F _z)
  [ -n "$fname" ] || source "$DOTLY_PATH/modules/z/z.sh"
  _z "$1"
}

# List recently visited directories using fzf
function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

# https://gist.github.com/davejamesmiller/1965569

# Generate and open Drush uli for dev
_custom_drush_uli() {
  site_alias=$(fc -rl 1 | ssh ${DEFAULT_USER_SSH}@${DEV_HOST} drush sa | fzf)
  uli=$(ssh ${DEFAULT_USER_SSH}@${DEV_HOST} drush ${site_alias} uli )
  st_site=$(ssh ${DEFAULT_USER_SSH}@${DEV_HOST} drush ${site_alias} st)
  echo $st_site
  root_path=$(echo $st_site | grep  'Drupal root'  | awk '{print $4}')
  root_site=$(echo $st_site | grep  'Site path'  | awk '{print $4}')
  echo $root_path'/'$root_site | xclip -selection c
  $BROWSER ${uli}
}

# Generate and open Drush uli for staging
_custom_drush_uli_staging() {
  site_alias=$(fc -rl 1  | ssh -i ~/ssh_ixiam/id_rsa ${DEFAULT_USER_SSH}@${STAGING_HOST} drush sa | fzf)
  uli=$(ssh -i ~/ssh_ixiam/id_rsa ${DEFAULT_USER_SSH}@${STAGING_HOST} drush ${site_alias} uli )
  ssh -i ~/ssh_ixiam/id_rsa ${DEFAULT_USER_SSH}@${STAGING_HOST} drush sa ${site_alias} | awk '/site_path/ {print $3}' | head -c -3 | cut -c2- | xclip -selection c
  sa=$(ssh -i ~/ssh_ixiam/id_rsa ${DEFAULT_USER_SSH}@${STAGING_HOST} drush sa ${site_alias})
  $BROWSER ${uli}
}

# Fix Aegir permissions for ext directory
_custom_fix_permissions_aegir_ext() {
  $(ssh ${DEFAULT_USER_SSH}@${DEV_HOST} mv /data/disk/${USER_AEGIR_DEV}/static/repositories/ext /data/disk/${USER_AEGIR_DEV}/static/trash/ext$(date +%Y%m%d))
  $(ssh ${DEFAULT_USER_SSH}@${DEV_HOST} cp -r /data/disk/${USER_AEGIR_DEV}/static/trash/ext$(date +%Y%m%d) /data/disk/${USER_AEGIR_DEV}/static/repositories/ext)
}

# Fix all Aegir permissions
_custom_fix_permissions_aegir_total() {
  $(ssh ${DEFAULT_USER_SSH}@${DEV_HOST} mv /data/disk/${USER_AEGIR_DEV}/static/repositories /data/disk/${USER_AEGIR_DEV}/static/trash/repositories$(date +%Y%m%d))
  $(ssh ${DEFAULT_USER_SSH}@${DEV_HOST} cp -r /data/disk/${USER_AEGIR_DEV}/static/trash/repositories$(date +%Y%m%d) /data/disk/${USER_AEGIR_DEV}/static/repositories)
}

# Open project in VS Code using fzf
oo() {
  PROJECT_PATH=$(ls -1 ~/Documents/workspaces/ | fzf | awk '{print $1}')
  antigravity ~/Documents/workspaces/$PROJECT_PATH
}

# Open workspace with Antigravity
oa() {
  local project_path
  project_path=$(ls -1 ~/Documents/workspaces/ | fzf | awk '{print $1}')

  if [ -n "$project_path" ]; then
    antigravity ~/Documents/workspaces/"$project_path"
  fi
}

# Interactively select from clipboard history
_clipboard() {
  CLIPBOARD_RESPONSE=$(gpaste-client history | fzf | awk '{print $2}')
  echo -n $CLIPBOARD_RESPONSE | xclip -selection c
}

# Copy only the last line from stdin to clipboard
copy() {
  local last_line
  last_line=$(tail -n 1)

  if command -v xclip >/dev/null 2>&1; then
    printf "%s" "$last_line" | xclip -selection clipboard
  elif command -v wl-copy >/dev/null 2>&1; then
    printf "%s" "$last_line" | wl-copy
  elif command -v pbcopy >/dev/null 2>&1; then
    printf "%s" "$last_line" | pbcopy
  else
    echo "No clipboard tool found. Install xclip, wl-copy, or pbcopy."
    return 1
  fi
}

# Interactively kill a process
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Interactively connect to SSH host
ssh_c() {
  # ToDo generate a list of hosts with the path of the config file, more clear to select
  # Get path of the config file
  config=$(ls ~/.ssh/config_ssh/*.conf | fzf -m | xargs)
  # Get the host
  host=$(cat $config | grep "Host\ " | awk '{print $2}')
  # Print the host
  echo $host
  # Connect to the host
  ssh $host; rr;
}

# Clone a personal repository from GitHub
function clone_personal_repo() {
  if [ -z "$GITHUB_USER" ]; then
    echo "Error: GITHUB_USER environment variable is not set."
    return 1
  fi

  local repo_url
  # Fetch repositories using GitHub API, parse ssh_url, and pass to fzf
  repo_url=$(curl -s "https://api.github.com/users/$GITHUB_USER/repos?per_page=100" | grep -o '"ssh_url": "[^"]*"' | cut -d'"' -f4 | fzf --prompt="Select repository to clone: ")

  if [ -n "$repo_url" ]; then
    git clone "$repo_url"
  else
    echo "No repository selected."
  fi
}

# Create a GitHub issue, a branch, and a linked PR
git_start_issue_pr() {
  local title="$1"
  if [ -z "$title" ]; then
    read -rp "Enter issue title: " title
  fi

  echo "Creating issue..."
  # Create issue and capture the output URL
  local issue_url
  issue_url=$(gh issue create --title "$title" --body "Feature: $title")

  local issue_number
  issue_number=$(echo "$issue_url" | grep -oE '[0-9]+$' || echo "$issue_url" | awk -F '/' '{print $NF}')

  if [ -z "$issue_number" ]; then
    echo "Error: Could not determine issue number from $issue_url"
    return 1
  fi
  echo "Issue #$issue_number created: $issue_url"

  local slug
  slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
  local branch_name="feat/${issue_number}-${slug}"

  echo "Creating branch $branch_name..."
  git checkout -b "$branch_name"

  echo "Pushing initial commit..."
  git commit --allow-empty -m "feat: $title (start)"
  git push -u origin "$branch_name"

  echo "Creating PR..."
  gh pr create --title "feat: $title" --body "Closes #$issue_number"
}

# Merge current PR, delete branch and return to main
git_finish_feature() {
  echo "Merging PR and deleting branch..."
  if ! gh pr merge --auto --delete-branch --merge; then
    echo "Auto-merge not available. Trying direct merge..."
    gh pr merge --delete-branch --merge
  fi

  echo "Returning to main..."
  git checkout main
  git pull
}

# TaskQuest: Gamified Task Manager
function tq() {
  local python_script="$HOME/repositories/task-quest/tq.py"

  if [[ "$1" == "done" ]] && [[ -z "$2" ]]; then
    # Interactive completion with fzf
    local selected=$(python3 "$python_script" list | grep -E "^[0-9]+\." | fzf --height 40% --reverse --prompt="Select task to complete: ")
    if [ -n "$selected" ]; then
      local idx=$(echo "$selected" | cut -d'.' -f1)
      python3 "$python_script" done "$idx"
    fi
  elif [[ "$1" == "good" ]] && [[ -z "$2" ]]; then
    # Interactive good action
    local action xp
    if [[ -n "$ZSH_VERSION" ]]; then
      read "action?What good deed did you do today? "
      read "xp?XP Reward (default 50): "
    else
      read -rp "What good deed did you do today? " action
      read -rp "XP Reward (default 50): " xp
    fi
    xp=${xp:-50}
    python3 "$python_script" good "$action" "$xp"
  else
    # Regular commands
    python3 "$python_script" "$@"
  fi
}

function list_custom_commands() {
  echo -e "\n\033[1;32m--- CUSTOM ALIASES ---\033[0m"
  awk '
    /^alias / {
        line = $0
        sub(/^alias /, "", line)
        split(line, parts, "=")
        name = parts[1]

        description = ""
        if ($0 ~ /#/) {
            split($0, comment_parts, "#")
            description = comment_parts[2]
            gsub(/^[ \t]+/, "", description)
        }

        printf "\033[1;33m%-30s\033[0m | %s\n", name, description
    }
  ' "$HOME/extra_bash/aliases.sh" | sort | column -t -s '|'

  echo -e "\n\033[1;34m--- CUSTOM FUNCTIONS ---\033[0m"
  awk '
    /^# / { last_comment = $0; sub(/^# /, "", last_comment); next }
    /^(function )?[a-zA-Z0-9_-]+\(\) ?\{/ {
        line = $0
        sub(/^function /, "", line)
        sub(/\(\) ?\{.*$/, "", line)
        gsub(/^[ \t]+/, "", line)

        printf "\033[1;33m%-30s\033[0m | %s\n", line, last_comment
        last_comment = ""
        next
    }
    /^[ \t]*$/ { next }
    { last_comment = "" }
  ' "$HOME/extra_bash/functions.sh" "$HOME/extra_bash/docker_functions.sh" | sort | column -t -s '|'
}
