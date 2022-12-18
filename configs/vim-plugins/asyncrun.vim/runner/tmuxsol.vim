" Customized by Sol

function! asyncrun#runner#tmuxsol#run(opts)
    if exists('*VimuxRunCommand') == 0
        return asyncrun#utils#errmsg('require benmills/vimux')
    endif
    let cwd = getcwd()
    " call VimuxRunCommand('cd ' . shellescape(cwd) . '; ' . a:opts.cmd)
    call VimuxClearTerminalScreen()
    call VimuxRunCommand('cd ' . shellescape(cwd))
    call VimuxClearTerminalScreen()
    call VimuxRunCommand(a:opts.cmd)
endfunc

