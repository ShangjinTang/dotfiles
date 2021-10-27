# >>> Shangjin add begin >>>

export LANG="en_US.UTF-8"

# history control
export HISTFILESIZE=10000  # max size in history file, e.g. ~/.bash_history
export HISTSIZE=1000  # max size in command `history`
export HISTCONTROL=ignoreboth  # same as ignorespace:ignoredups

# ls/grep: alias & enable color
if [ $(uname) = "Darwin" ]; then
    alias ls='ls -G'
    alias l='ls -lFG'
    alias ll='ls -AlFG'
elif [ $(uname) = "Linux" ]; then
    alias ls='ls --color=auto'
    alias l='ls -lF --color=auto'
    alias ll='ls -AlF --color=auto'
fi
alias grep='grep --color=auto'

# Path
if [ -d "$HOME/bin" ]; then
    export PATH="$PATH:$HOME/bin"
fi
if [ -d "$HOME/anaconda3/bin" ]; then
    export PATH="$PATH:$HOME/anaconda3/bin"
fi

# zsh/bash configurations
if [ $SHELL = "/bin/zsh" ]; then
    # completion for zsh
    # To fix warning: "zsh compinit: insecure directories", enter command `compaudit | xargs chmod g-w`
    autoload -Uz compinit && compinit
    # ohmyzsh settings
    if [ -d "$HOME/.oh-my-zsh" ]; then
        export ZSH=$HOME/.oh-my-zsh
        ZSH_THEME="robbyrussell"
        plugins=(git)
        source $ZSH/oh-my-zsh.sh
    fi
elif [ $SHELL = "/bin/bash" ]; then
    [ -f /usr/share/bash-completion/completions/git ] && source /usr/share/bash-completion/completions/git
fi

# Proxy (V2Ray)
alias setproxy='export https_proxy=http://127.0.0.1:1080 http_proxy=http://127.0.0.1:1080 all_proxy=socks5://127.0.0.1:1080 '
alias unsetproxy='unset https_proxy http_proxy all_proxy'
# setproxy by flag file
if [ -f ~/.dotfiles.local/.flag.proxy ]; then
    setproxy
else
    unsetproxy
fi

# Git
alias gpristine='git reset --hard && git clean -dfx'
alias cdgitroot='cd $(git rev-parse --show-cdup)'

# TMUX
if command -v tmux &> /dev/null; then
    function t() {
        if [ $# -eq 1 ]; then
            tmux attach-session -t $1 2> /dev/null || tmux new-session -s $1
        elif [ $# -eq 0 ]; then
            tmux attach-session -t 0 2> /dev/null || tmux new-session -s 0
        fi
    }
    alias tk='tmux kill-session -at 0'
    alias tl='tmux list-sessions'
fi








# Use rg (ripgrep) as fzf's **<TAB> / CTRL-T backend
if command -v rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!{.git,.repo,.CMVolumes}/*' 2> /dev/null"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if [ $SHELL = "/bin/bash" ]; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
elif [ $SHELL = "/bin/zsh" ]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# set tmux auto launch by flag file
if [ -f ~/.dotfiles.local/.flag.tmux_auto_launch ]; then
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        tmux send-keys -t 0:1 " cd ~ && clear" Enter &> /dev/null
        tmux attach-session -t 0:1 2> /dev/null || tmux new-session -s 0
    fi
fi

# <<< Shangjin add end <<<

