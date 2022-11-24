# Bash Shell Scripts

Note:

1. All shell scripts must use `bash` instead of `zsh` for compatability.
2. Name begin with '\_' is a partial-implemented script and should not be called directly.
3. Bash scripts should be simple and normally receives no more than 2 arguments. For complex scripts, use python.
4. If you think the name is too long, use 'alias' or 'abbr' plugin in zsh.

## FZF Integrations

### cscope

- **fzf_cscope_find_c** FUNCTION: find functions calling this FUNCTION
- **fzf_cscope_find_d** FUNCTION: find functions called by this FUNCTION
- **fzf_cscope_find_g** FUNCTION: find this FUNCTION definition
- **fzf_cscope_find_s** SYMBOL: find this SYMBOL

### git

- **fzf_git_log_follow [FILE|DIR]**: find git commits which modified FILE|DIR using `git log --follow`
- **fzf_git_show [COMMIT]**: show file change in specific COMMIT using `git show`
- **fzf_git_status**: git show current status (both unstaged and staged) using `git status`

### ripgrep

- **fzf_rg [PATTERN]**: find PATTERN with rg

### wd

- **fzf_wd [PATTERN]**: find PATTERN in wd warp points and warp paths

---

# Python Shell Scripts

Note:

1. Always use python3.
2. Name convention: TargetArea-TargetAction (use hyphen instead of underscore).
3. Argparse is preferred, '--help' must be supported.

### aosp-download

