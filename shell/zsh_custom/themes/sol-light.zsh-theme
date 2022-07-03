# ZSH PROMPT
# Reference: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

# Light theme

# Green/Blue anchor based on the return result
PROMPT="%(?:%F{28}➤:%F{124}➤)%f  "
# Current directory (starts with '~' if possible)
PROMPT+="%~ "
# Use '%' as prompt symbol
PROMPT+="%% "

