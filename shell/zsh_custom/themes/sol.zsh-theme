# ZSH PROMPT
# Reference: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

# Light theme (inspired by gnzh.zsh-theme)

# Colors:
# Green Anchor: 28 | Red Anchor: 124
# Tmux Blue: 24 | Tmux Red: 160 | Tmux Purple: 91

setopt prompt_subst

() {
######################################################################
# PROMPT

if [ $TERMINAL_COLOR = 'light' ]; then
    COLOR_DEFAULT='255'
    COLOR_MACHINE='238'
    COLOR_RETURN_TRUE='28'
    COLOR_RETURN_FALSE='124'
elif [ $TERMINAL_COLOR = 'dark' ]; then
    COLOR_DEFAULT='234'
    COLOR_MACHINE='252'
    COLOR_RETURN_TRUE='70'
    COLOR_RETURN_FALSE='205'
fi

local git_branch='$(git_prompt_info)'

PROMPT=""

# Check if we are on SSH or not (only show if tmux is not launched)
if [ $SESSION_TYPE = "ssh" ] && [ -z "$TMUX" ]; then
    PROMPT+="%K{$COLOR_DEFAULT}%F{$COLOR_MACHINE}%m%f%k " # SSH
else
    PROMPT+="" # no SSH
fi

# Green/Blue anchor based on the return result
PROMPT+="%(?:%F{$COLOR_RETURN_TRUE}➤ :%F{$COLOR_RETURN_FALSE}➤ )%f "
# Current directory (starts with '~' if possible)
PROMPT+="%~ "

# Git branch (only show if tmux is not launched)
if [ -z "$TMUX" ]; then
    PROMPT+="${git_branch}" # SSH
fi
# Use '%' as prompt symbol
PROMPT+="%% "

######################################################################
# RPROMPT

local return_code="%(?..%F{124}%? ↵%f)"

RPROMPT=""

RPROMPT+="${return_code}"

######################################################################
# Others

ZSH_THEME_GIT_PROMPT_PREFIX="%F{28}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"

}
