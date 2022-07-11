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

local git_branch='$(git_prompt_info)'

PROMPT=""

# Check if we are on SSH or not
if [ $SESSION_TYPE = "ssh" ]; then
    PROMPT+="%K{255}%F{238}%m%f%k " # SSH
else
    PROMPT+="" # no SSH
fi

# Green/Blue anchor based on the return result
PROMPT+="%(?:%F{28}➤ :%F{124}➤ )%f "
# Current directory (starts with '~' if possible)
PROMPT+="%~ "
# Git branch for server (local: tmux)
if [ $SESSION_TYPE = "ssh" ]; then
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
