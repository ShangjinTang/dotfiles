# >>> Shangjin add begin >>>

export LANG="en_US.UTF-8"

# ls/grep: alias & enable color
if [ $(uname) = "Darwin" ]; then
    alias ls='ls -G'
    alias l='ls -lFG'
    alias ll='ls -AlFG'
elif [ $(uname) = "Linux" ]; then
    alias l='ls -CF --color=auto'
    alias la='ls -A --color=auto'
    alias ll='ls -alF --color=auto'
    alias ls='ls -G --color=auto'
fi
alias grep='grep --color=auto'

# Path
if [ -d "$HOME/bin" ]; then
    export PATH="$PATH:$HOME/bin"
fi
if [ -d "$HOME/anaconda3/bin" ]; then
    export PATH="$PATH:$HOME/anaconda3/bin"
fi

# git completion
if [ $(uname) = "Linux" ]; then
    [ -f /usr/share/bash-completion/completions/git ] && source /usr/share/bash-completion/completions/git
fi

# Proxy (V2Ray)
alias setproxy='export https_proxy=http://127.0.0.1:1080 http_proxy=http://127.0.0.1:1080 all_proxy=socks5://127.0.0.1:1080 '
alias unsetproxy='unset https_proxy http_proxy all_proxy'
# setproxy by default (to disable proxy, add a flag file by `touch ~/.noproxy.flag`)
[ ! -f ~/.noproxy.flag ] && setproxy

# Git
alias gpristine='git reset --hard && git clean -dfx'
alias cdgitroot='cd $(git rev-parse --show-cdup)'

# TMUX Session
alias t='tmux attach-session 2> /dev/null || tmux new-session'
alias tat='tmux attach-session -t'
alias tn='tmux new-session'
alias tns='tmux new-session -s'
alias tk='tmux kill-session'
alias tkt='tmux kill-session -t'
alias tl='tmux list-sessions'








# Use rg (ripgrep) as fzf's **<TAB> / CTRL-T backend
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!{.git,.repo,.CMVolumes}/*' 2> /dev/null"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# <<< Shangjin add end <<<

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
