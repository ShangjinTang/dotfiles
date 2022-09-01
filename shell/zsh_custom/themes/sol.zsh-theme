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

if [ $TERMINAL_THEME = 'light' ]; then
    PROMPT_COLOR_HOSTNAME_BG=''
    PROMPT_COLOR_HOSTNAME_FG='238'
    PROMPT_COLOR_RETURN_TRUE='28'
    PROMPT_COLOR_RETURN_FALSE='124'
    PROMPT_COLOR_GIT='28'
elif [ $TERMINAL_THEME = 'dark' ]; then
    PROMPT_COLOR_HOSTNAME_BG=''
    PROMPT_COLOR_HOSTNAME_FG='252'
    PROMPT_COLOR_RETURN_TRUE='70'
    PROMPT_COLOR_RETURN_FALSE='205'
    PROMPT_COLOR_GIT='70'
fi

local git_branch='$(git_prompt_info)'

PROMPT=""

# Check if we are on SSH or not (only show if tmux is not launched)
if [ $SESSION_TYPE = "ssh" ] && [ -z "$TMUX" ]; then
    PROMPT+="%K{$PROMPT_COLOR_HOSTNAME_BG}%F{$PROMPT_COLOR_HOSTNAME_FG}%m%f%k " # SSH
else
    PROMPT+="" # no SSH
fi

# Green/Blue anchor based on the return result
PROMPT+="%(?:%F{$PROMPT_COLOR_RETURN_TRUE}➤ :%F{$PROMPT_COLOR_RETURN_FALSE}➤ )%f "
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

local return_code="%(?..%F{$PROMPT_COLOR_RETURN_FALSE}%? ↵%f)"

RPROMPT=""

RPROMPT+="${return_code}"

######################################################################
# Others

ZSH_THEME_GIT_PROMPT_PREFIX="%F{$PROMPT_COLOR_GIT}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"

}
