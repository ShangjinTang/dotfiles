#!/usr/bin/env bash

# Colors
RESET=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
# YELLOW=$(tput setaf 3)
# BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
# CYAN=$(tput setaf 6)
# ITALIC=$(tput sitm)
BOLD=$(tput bold)

if ! command -v jq &> /dev/null; then
    echo "${BOLD}${RED}ERROR:${RESET} 'jq' not available, please install it first."
    exit 1
fi

script_path=$(readlink -f "$0")
script_directory=$(dirname "$script_path")

execute_command() {
    command=$*
    echo "${MAGENTA}$command${RESET}"
    eval $command
    if [ $? -eq 0 ]; then
        echo "${GREEN}done${RESET}"
    else
        echo "${RED}fail${RESET}"
    fi
    echo
}

# completions unavailable: spacer, dua, tokei

# completions no auto-renew:
# _mdcat: 2.4.0

# _fd
execute_command "curl https://raw.githubusercontent.com/sharkdp/fd/master/contrib/completion/_fd -o ${script_directory}/_fd"

# _pueue
if command -v pueue &> /dev/null; then
    execute_command "pueue completions zsh ${script_directory}"
fi

# _ast-grep
if command -v ast-grep &> /dev/null; then
    execute_command "ast-grep completions zsh > ${script_directory}/_ast-grep"
fi

# _mise
if command -v mise &> /dev/null; then
    execute_command "mise completions zsh > ${script_directory}/_mise"
fi

# _chezmoi
if command -v chezmoi &> /dev/null; then
    execute_command "chezmoi completion zsh > ${script_directory}/_chezmoi"
fi
