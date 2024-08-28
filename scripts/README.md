# Bash Shell Script Convention

1. All shell scripts must use `bash` instead of `zsh` for compatibility.
2. Name begin with '\_' is an internal script and should not be called directly.
3. Bash scripts should be simple and normally receives no more than 2 arguments.

# Python Script Convention

1. Always use python3.
2. Naming convention: TargetArea-TargetAction (use hyphen instead of underscore).
3. Use `argparse` is preferred, '--help' must be supported.
