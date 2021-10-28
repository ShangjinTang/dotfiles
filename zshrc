[ -f ~/.dotfiles/.shrc ] && source ~/.dotfiles/.shrc

# completion for zsh
# To fix warning: "zsh compinit: insecure directories", enter command `compaudit | xargs chmod g-w`
autoload -Uz compinit && compinit

# ohmyzsh settings
export ZSH=$HOME/.oh-my-zsh
# ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
ZSH_THEME="sol-light"  # ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
unset LSCOLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LSCOLORS}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# set tmux auto launch by flag file
if [ -f ~/.dotfiles.local/.flag.tmux_auto_launch ]; then
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        tmux send-keys -t 0:1 " cd ~ && clear" Enter &> /dev/null
        tmux attach-session -t 0:1 2> /dev/null || tmux new-session -s 0
    fi
fi
