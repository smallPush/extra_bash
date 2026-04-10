alias ..="cd .."           # Go up one directory
alias ...="cd ../.."       # Go up two directories
alias ll="ls -l"           # List files in long format
alias la="ls -la"          # List all files in long format
alias ~="cd ~"             # Go to home directory

# Git
alias gaa="git add -A"                                  # Git add all
alias gc='$DOTLY_PATH/bin/dot git commit'               # Git commit
alias gca="git add --all && git commit --amend --no-edit" # Git amend
alias gco="git checkout"                                # Git checkout
alias gd='$DOTLY_PATH/bin/dot git pretty-diff'          # Git diff
alias gs="git status -sb"                               # Git status short
alias gf="git fetch --all -p"                           # Git fetch and prune
alias gps="git push"                                    # Git push
alias gpsf="git push --force"                           # Git push force
alias gpl="git pull --rebase --autostash"               # Git pull with rebase
alias gb="git branch"                                   # Git branch
alias gl='$DOTLY_PATH/bin/dot git pretty-log'           # Git log
alias gsq2="git reset --soft HEAD~2 && git commit"      # Squash last 2 commits

# Utils
alias k='kill -9'                                      # Kill process
alias i.='(idea $PWD &>/dev/null &)'                    # Open in IntelliJ IDEA
alias c.='(code $PWD &>/dev/null &)'                    # Open in VS Code
alias o.='open .'                                       # Open current directory
alias up='dot package update_all'                       # Update all packages
alias c="ssh ${DEFAULT_USER_SSH}@${DEV_HOST}"           # SSH to dev host
alias setclip="xclip -selection c"                      # Copy to clipboard
alias getclip="xclip -selection c -o"                   # Paste from clipboard

# Custom to clipboard
alias custom_reroute_email='printf "drush vset --yes reroute_email_enable 1 \n drush vset --yes reroute_email_address ${EMAIL_ENTERPRISE} \n drush vset --yes reroute_email_enable_message 1 \n" | xclip -selection c'; # Reroute email setup
alias custom_dis_modules='printf "drush dis autologout --y \n" | xclip -selection c'; # Disable autologout module
alias custom_after_migrate='printf "drush en reroute_email --y \n drush vset --yes reroute_email_enable 1 \n drush vset --yes reroute_email_address ${EMAIL_ENTERPRISE} \n drush vset --yes reroute_email_enable_message 1 \n drush dis autologout --y \n drush en dblog --y \n drush dis --y session_expire \n drush dis --y session_limit \n drush sqlq --file=~/static/scripts/disable_emails.sql \n" \n drush upwd root --password=${PASSWORD_DRUPAL_DEFAULT} \n | xclip -selection c'; # Post-migration setup
alias custom_after_migrate_d9='printf "drush  drush pm-uninstall autologout --y \n | xclip -selection c'; # Post-migration setup (D9)
alias custom_change_password_root='printf "drush upwd root --password=${PASSWORD_DRUPAL_DEFAULT}" | xclip -selection c'; # Reset root password
alias custom_change_password_ruben='printf "drush upwd ruben --password=${PASSWORD_DRUPAL_RUBEN}" | xclip -selection c'; # Reset ruben password
alias custom_new_user='printf "drush user-create newuser --mail=${EMAIL_ENTERPRISE} --password=${PASSWORD_DRUPAL_RUBEN}" | xclip -selection c '; # Create new user
alias custom_aegir_path='printf "/data/disk/rpineda/static/" | xclip -selection c'; # Aegir static path
alias custom_drush_make='printf "drush make site.make --no-core --contrib-destination=. -y " | xclip -selection c'; # Drush make command

alias custom_password="openssl rand -base64 32 | xclip -selection c" # Generate random password
alias custom_get_ip_vpn="ip addr show tun0 | grep -Po 'inet \K[\d.]+'" # Get VPN IP address
alias custom_phpcbf="phpcbf --standard=Generic,Squiz,PEAR,PSR2 --sniffs=Generic.Arrays.DisallowLongArraySyntax" # PHP Code Beautifier
alias custom_find_last_modified_files="find . -mtime -2 -ls" # Find recently modified files

# Alias to avoid issues with snap install code
alias code="/snap/bin/code"
alias custom_squash_two_commits="git reset --soft HEAD~2 && git commit"


# Docker Compose alias
alias dcu="docker-compose up -d"                         # Docker compose up
alias dcd="docker-compose down -v"                      # Docker compose down
alias dcr="docker-compose restart"                      # Docker compose restart
alias dcl="docker-compose logs -f"                      # Docker compose logs
alias dcs="docker-compose stop"                         # Docker compose stop

alias grep="grep --color"                               # Grep with color
alias ll="ls -al"                                       # List all files (redundant)

alias dk_tr_u='docker-compose --file $HOME/repositories/docker/docker_traeffik/docker-compose.yml up -d' # Start Traefik
alias dk_tr_s='docker-compose --file $HOME/repositories/docker/docker_traeffik/docker-compose.yml stop' # Stop Traefik

alias rr='konsoleprofile colors=Solarized'             # Switch Konsole theme

# VPN connection to ixiam
alias vpnc="sudo vpnc-connect --local-port 0 "          # Connect to VPN
alias vpnd="sudo vpnc-disconnect"                       # Disconnect from VPN

alias get_enviroment="python3 ~/extra_bash/get_enviroment.py" # Get environment details