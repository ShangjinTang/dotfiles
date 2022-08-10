# Bash Shell Scripts

Note:

1. All shell scripts must use `bash` instead of `zsh` for compatability.
2. Name begin with '\_' is a partial-implemented script and should not be called directly.

## FZF Integrations

### cscope

- csc FUNCTION: find functions calling this FUNCTION
- csd FUNCTION: find functions called by this FUNCTION
- csg FUNCTION: find this FUNCTION definition
- css SYMBOL: find this SYMBOL

### git

- glf [FILE|DIR]: find git commits which modified FILE|DIR using `git log --follow`
- gsh [COMMIT]: show file change in specific COMMIT using `git show`
- gst: git show current status (both unstaged and staged) using `git status`

### ripgrep

- rf [PATTERN]: find PATTERN with rg

### wd

- wf [PATTERN]: find PATTERN in wd warp points and warp paths
