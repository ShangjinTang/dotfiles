# Powerlevel10k prompt segments for mise
#
# https://github.com/romkatv/powerlevel10k
# https://github.com/jdxcode/mise
# [Feature request: add segment for rtx](https://github.com/romkatv/powerlevel10k/issues/2212)
#
# Usage in ~/.zshrc:
#
#   # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#   [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
#   [[ -f ~/.p10k.mise.zsh ]] && source ~/.p10k.mise.zsh
#

() {
    function prompt_rtx() {
        local enabled_tools=("ruby" "python" "go" "node" "rust" "dotnet" "flutter" "lua" "java" "perl" "erlang" "elixir" "postgres" "php" "haskell" "julia")
        local plugins=("${(@f)$(mise ls --current --installed 2>/dev/null | awk '!/\(symlink\)/ && $3!="~/.tool-versions" && $3!="~/.config/mise/config.toml" {print $1, $2}')}")
        local plugin
        for plugin in ${(k)plugins}; do
            local parts=("${(@s/ /)plugin}")
            local tool=${(U)parts[1]}
            local version=${parts[2]}
            for enabled_tool in "${enabled_tools[@]}"; do
                if [[ ${(L)tool} == ${(L)enabled_tool} ]]; then
                    p10k segment -r -i "${tool}_ICON" -s $tool -t "$version"
                fi
            done
        done
    }

    typeset -g POWERLEVEL9K_RTX_FOREGROUND=6

    typeset -g POWERLEVEL9K_RTX_RUBY_FOREGROUND=1
    typeset -g POWERLEVEL9K_RTX_PYTHON_FOREGROUND=6
    typeset -g POWERLEVEL9K_RTX_GOLANG_FOREGROUND=6
    typeset -g POWERLEVEL9K_RTX_NODEJS_FOREGROUND=2
    typeset -g POWERLEVEL9K_RTX_RUST_FOREGROUND=4
    typeset -g POWERLEVEL9K_RTX_DOTNET_CORE_FOREGROUND=5
    typeset -g POWERLEVEL9K_RTX_FLUTTER_FOREGROUND=4
    typeset -g POWERLEVEL9K_RTX_LUA_FOREGROUND=4
    typeset -g POWERLEVEL9K_RTX_JAVA_FOREGROUND=4
    typeset -g POWERLEVEL9K_RTX_PERL_FOREGROUND=6
    typeset -g POWERLEVEL9K_RTX_ERLANG_FOREGROUND=1
    typeset -g POWERLEVEL9K_RTX_ELIXIR_FOREGROUND=5
    typeset -g POWERLEVEL9K_RTX_POSTGRES_FOREGROUND=6
    typeset -g POWERLEVEL9K_RTX_PHP_FOREGROUND=5
    typeset -g POWERLEVEL9K_RTX_HASKELL_FOREGROUND=3
    typeset -g POWERLEVEL9K_RTX_JULIA_FOREGROUND=2

    # Substitute the default asdf prompt element
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]/asdf/mise}")
}
