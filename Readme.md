# Project Setup & Utilities

## Environment Configuration

### Required Files & Variables

Ensure the following configuration files are in place:

* init.sh: Initializes the environment and loads necessary functions.

Is required add the following to your shell profile (e.g., \~/.zshrc or \~/.bashrc):
  source "/path/to/your/repo/init.sh"

* Environment File: Source your environment variables:
  source "$HOME/.env"

* Data Files:
  * serverstats.json (Export source)
  * db/servers.json

## Shell Setup (Zsh)

To utilize the full feature set, the following Zsh plugins are required.

### 1\. Install Dependencies

* [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [zsh-fzf-history-search](https://github.com/joshskidmore/zsh-fzf-history-search)
* [zsh-autosuggestions](https://www.google.com/search?q=https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
* [zsh-syntax-highlighting](https://www.google.com/search?q=https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

### 2\. Configure .zshrc

Update your \~/.zshrc file to include the following plugins:

plugins=(git zsh-fzf-history-search compleat zsh-autosuggestions zsh-syntax-highlighting)

## Docker Utility Functions

This repository includes docker\_functions.sh, a set of utilities to simplify common Docker operations. These are loaded automatically if you are using the init.sh script.

### Container Management

| Command | Description |
| :---- | :---- |
| dkc | Interactively connect to a running container's shell. |
| dki | Inspect a container and copy its working directory to the clipboard. |
| dkg | Change the current directory to the working directory of a selected container. |
| dk-logs | Interactively select a running container and follow its logs (docker logs \-f). |
| dk-ip | Interactively select a running container and display its IP address. |
| dk-ps | Alias for docker ps. |

### Lifecycle Control

* dk-start \<container\>: Starts a stopped container (accepts name or ID).
* dk-stop \<container\>: Stops a running container (accepts name or ID).
* dk-stop-all: Stops *all* currently running containers.
* dk-stop-ixiam: Stops all containers except portainer and traefik (useful for dev environments).
* dk-rm: Interactively remove stopped container(s).
* dk-rmi: Interactively remove Docker image(s) using fzf.

### Development Tools & Execution

These commands mount the current directory to perform tasks inside a container:

* dk-exec: Select a container to execute a specific command inside it. (Defaults to sh/bash if no command provided).
* dk-php \<script.php\>: Runs a PHP script using php:cli-alpine.
* dk-gulp \<task\>: Executes Gulp tasks using node:alpine.
* dk-npm-install \<package\>: Installs Node.js packages using node:alpine.
* dk-npx \<command\>: Executes an npx command using node:alpine.
* dk-composer \<command\>: Executes a Composer command using the official composer image.

### Docker Compose Aliases

Defined in `aliases.sh`

* dcu → docker-compose up \-d
* dcd → docker-compose down \-v
* dcr → docker-compose restart
* dcl → docker-compose logs \-f
* dcs → docker-compose stop
