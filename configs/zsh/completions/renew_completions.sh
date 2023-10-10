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

# completions unavailable: macchina, spacer, dua, tokei

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

# _rtx
if command -v rtx &> /dev/null; then
    execute_command "rtx completions zsh > ${script_directory}/_rtx"
fi

# _tldr (cargo version)
execute_command "curl https://raw.githubusercontent.com/dbrgn/tealdeer/main/completion/zsh_tealdeer -o ${script_directory}/_tldr"

# _bat
execute_command 'bat_latest_tag=$(curl "https://api.github.com/repos/sharkdp/bat/tags" | jq -r '.[0].name') &&
    tmpdir=$(mktemp -d) &&
    curl -L -o "$tmpdir/bat.tar.gz" "https://github.com/sharkdp/bat/releases/download/${bat_latest_tag}/bat-${bat_latest_tag}-x86_64-unknown-linux-musl.tar.gz" &&
    tar -xzf "$tmpdir/bat.tar.gz" -C "$tmpdir" --strip-components=2 --wildcards "bat-*/autocomplete/bat.zsh" && mv $tmpdir/bat.zsh ${script_directory}/_bat'

# _dust
execute_command "curl https://raw.githubusercontent.com/bootandy/dust/master/completions/_dust -o ${script_directory}/_dust"

# # _delta
# execute_command "echo 'compdef _gnu_generic delta' > ${script_directory}/_delta"

# _hyperfine
execute_command 'hyperfine_latest_tag=$(curl "https://api.github.com/repos/sharkdp/hyperfine/tags" | jq -r '.[0].name') &&
    tmpdir=$(mktemp -d) &&
    curl -L -o "$tmpdir/hyperfine.tar.gz" "https://github.com/sharkdp/hyperfine/releases/download/${hyperfine_latest_tag}/hyperfine-${hyperfine_latest_tag}-x86_64-unknown-linux-musl.tar.gz" &&
    tar -xzf "$tmpdir/hyperfine.tar.gz" -C "$tmpdir" --strip-components=2 --wildcards "hyperfine-*/autocomplete/_hyperfine" && mv $tmpdir/_hyperfine ${script_directory}/_hyperfine'

# _lsd
execute_command 'lsd_latest_tag=$(curl "https://api.github.com/repos/lsd-rs/lsd/tags" | jq -r '.[0].name') &&
    tmpdir=$(mktemp -d) &&
    curl -L -o "$tmpdir/lsd.tar.gz" "https://github.com/lsd-rs/lsd/releases/download/${lsd_latest_tag}/lsd-${lsd_latest_tag}-x86_64-unknown-linux-musl.tar.gz" &&
    tar -xzf "$tmpdir/lsd.tar.gz" -C "$tmpdir" --strip-components=2 --wildcards "lsd-*/autocomplete/_lsd" && mv $tmpdir/_lsd ${script_directory}/_lsd'

# _ouch
execute_command 'tmpdir=$(mktemp -d) &&
    curl -L -o "$tmpdir/ouch.tar.gz" "https://github.com/ouch-org/ouch/releases/latest/download/ouch-x86_64-unknown-linux-musl.tar.gz" &&
    tar -xzf "$tmpdir/ouch.tar.gz" -C "$tmpdir" --strip-components=2 --wildcards "ouch-*/completions/_ouch" && mv $tmpdir/_ouch ${script_directory}/_ouch'

# _procs
if command -v procs &> /dev/null; then
    execute_command "procs --gen-completion-out zsh > ${script_directory}/_procs"
fi

# _sd
execute_command "curl https://raw.githubusercontent.com/chmln/sd/master/gen/completions/_sd -o ${script_directory}/_sd"

# _watchexec
execute_command "curl https://raw.githubusercontent.com/watchexec/watchexec/main/completions/zsh -o ${script_directory}/_watchexec"

# _zoxide
execute_command "curl https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/contrib/completions/_zoxide -o ${script_directory}/_zoxide"
