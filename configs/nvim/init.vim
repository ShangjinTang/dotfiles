lua require("LunarVim.init")

lua << EOF
    require("vim-init")
    require("plug-which-key")
    -- Note: autocmd should be placed at end of plugins
    require("autocmd")
EOF

" ===================================================================
" catppuccin theme

let background=$TERMINAL_THEME

if background ==? 'dark'
    " Reference: https://github.com/catppuccin/vim/blob/main/colors/catppuccin_frappe.vim
    set background=dark
    let g:colors_name='catppuccin_frappe'
    set t_Co=256

    let s:rosewater = "#F2D5CF"
    let s:flamingo = "#EEBEBE"
    let s:pink = "#F4B8E4"
    let s:mauve = "#CA9EE6"
    let s:red = "#E78284"
    let s:maroon = "#EA999C"
    let s:peach = "#EF9F76"
    let s:yellow = "#E5C890"
    let s:green = "#A6D189"
    let s:teal = "#81C8BE"
    let s:sky = "#99D1DB"
    let s:sapphire = "#85C1DC"
    let s:blue = "#8CAAEE"
    let s:lavender = "#BABBF1"

    let s:text = "#C6D0F5"
    let s:subtext1 = "#B5BFE2"
    let s:subtext0 = "#A5ADCE"
    let s:overlay2 = "#949CBB"
    let s:overlay1 = "#838BA7"
    let s:overlay0 = "#737994"
    let s:surface2 = "#626880"
    let s:surface1 = "#51576D"
    let s:surface0 = "#414559"

    let s:base = "#303446"
    let s:mantle = "#292C3C"
    let s:crust = "#232634"
endif

if background ==? 'light'
    " Reference: https://github.com/catppuccin/vim/blob/main/colors/catppuccin_latte.vim
    set background=light
    let g:colors_name='catppuccin_latte'
    set t_Co=256

    let s:rosewater = "#DC8A78"
    let s:flamingo = "#DD7878"
    let s:pink = "#EA76CB"
    let s:mauve = "#8839EF"
    let s:red = "#D20F39"
    let s:maroon = "#E64553"
    let s:peach = "#FE640B"
    let s:yellow = "#DF8E1D"
    let s:green = "#40A02B"
    let s:teal = "#179299"
    let s:sky = "#04A5E5"
    let s:sapphire = "#209FB5"
    let s:blue = "#1E66F5"
    let s:lavender = "#7287FD"

    let s:text = "#4C4F69"
    let s:subtext1 = "#5C5F77"
    let s:subtext0 = "#6C6F85"
    let s:overlay2 = "#7C7F93"
    let s:overlay1 = "#8C8FA1"
    let s:overlay0 = "#9CA0B0"
    let s:surface2 = "#ACB0BE"
    let s:surface1 = "#BCC0CC"
    let s:surface0 = "#CCD0DA"

    let s:base = "#EFF1F5"
    let s:mantle = "#E6E9EF"
    let s:crust = "#DCE0E8"
endif

function! s:hi(group, guisp, guifg, guibg, gui, cterm)
let cmd = ""
if a:guisp != ""
    let cmd = cmd . " guisp=" . a:guisp
endif
if a:guifg != ""
    let cmd = cmd . " guifg=" . a:guifg
endif
if a:guibg != ""
    let cmd = cmd . " guibg=" . a:guibg
endif
if a:gui != ""
    let cmd = cmd . " gui=" . a:gui
endif
if a:cterm != ""
    let cmd = cmd . " cterm=" . a:cterm
endif
if cmd != ""
    exec "hi " . a:group . cmd
endif
endfunction

call s:hi("normal", "none", s:text, s:base, "none", "none")
call s:hi("visual", "none", "none", s:surface1,"bold", "bold")
call s:hi("conceal", "none", s:overlay1, "none", "none", "none")
call s:hi("colorcolumn", "none", "none", s:surface0, "none", "none")
call s:hi("cursor", "none", s:base, s:text, "none", "none")
call s:hi("lcursor", "none", s:base, s:text, "none", "none")
call s:hi("cursorim", "none", s:base, s:text, "none", "none")
call s:hi("cursorcolumn", "none", "none", s:mantle, "none", "none")
call s:hi("cursorline", "none", "none", s:surface0, "none", "none")
call s:hi("directory", "none", s:blue, "none", "none", "none")
call s:hi("diffadd", "none", s:base, s:green, "none", "none")
call s:hi("diffchange", "none", s:base, s:yellow, "none", "none")
call s:hi("diffdelete", "none", s:base, s:red, "none", "none")
call s:hi("difftext", "none", s:base, s:blue, "none", "none")
call s:hi("endofbuffer", "none", "none", "none", "none", "none")
call s:hi("errormsg", "none", s:red, "none", "bolditalic"    , "bold,italic")
call s:hi("vertsplit", "none", s:crust, "none", "none", "none")
call s:hi("folded", "none", s:blue, s:surface1, "none", "none")
call s:hi("foldcolumn", "none", s:overlay0, s:base, "none", "none")
call s:hi("signcolumn", "none", s:surface1, s:base, "none", "none")
call s:hi("incsearch", "none", s:surface1, s:pink, "none", "none")
call s:hi("cursorlinenr", "none", s:lavender, "none", "none", "none")
call s:hi("linenr", "none", s:surface1, "none", "none", "none")
call s:hi("matchparen", "none", s:peach, "none", "bold", "bold")
call s:hi("modemsg", "none", s:text, "none", "bold", "bold")
call s:hi("moremsg", "none", s:blue, "none", "none", "none")
call s:hi("nontext", "none", s:overlay0, "none", "none", "none")
call s:hi("pmenu", "none", s:overlay2, s:surface0, "none", "none")
call s:hi("pmenusel", "none", s:text, s:surface1, "bold", "bold")
call s:hi("pmenusbar", "none", "none", s:surface1, "none", "none")
call s:hi("pmenuthumb", "none", "none", s:overlay0, "none", "none")
call s:hi("question", "none", s:blue, "none", "none", "none")
call s:hi("quickfixline", "none", "none", s:surface1, "bold", "bold")
call s:hi("search", "none", s:pink, s:surface1, "bold", "bold")
call s:hi("specialkey", "none", s:subtext0, "none", "none", "none")
call s:hi("spellbad", s:red, "none", "none", "underline", "underline")
call s:hi("spellcap", s:yellow, "none", "none", "underline", "underline")
call s:hi("spelllocal", s:blue, "none", "none", "underline", "underline")
call s:hi("spellrare", s:green, "none", "none", "underline", "underline")
call s:hi("statusline", "none", s:text, s:mantle, "none", "none")
call s:hi("statuslinenc", "none", s:surface1, s:mantle, "none", "none")
call s:hi("tabline", "none", s:surface1, s:mantle, "none", "none")
call s:hi("tablinefill", "none", "none", s:mantle, "none", "none")
call s:hi("tablinesel", "none", s:green, s:surface1, "none", "none")
call s:hi("title", "none", s:blue, "none", "bold", "bold")
call s:hi("visualnos", "none", "none", s:surface1, "bold", "bold")
call s:hi("warningmsg", "none", s:yellow, "none", "none", "none")
call s:hi("wildmenu", "none", "none", s:overlay0, "none", "none")
call s:hi("comment", "none", s:surface2, "none", "none", "none")
call s:hi("constant", "none", s:peach, "none", "none", "none")
call s:hi("identifier", "none", s:flamingo, "none", "none", "none")
call s:hi("statement", "none", s:mauve, "none", "none", "none")
call s:hi("preproc", "none", s:pink, "none", "none", "none")
call s:hi("type", "none", s:blue, "none", "none", "none")
call s:hi("special", "none", s:pink, "none", "none", "none")
call s:hi("underlined", "none", s:text, s:base, "underline", "underline")
call s:hi("error", "none", s:red, "none", "none", "none")
call s:hi("todo", "none", s:base, s:yellow, "bold", "bold")

call s:hi("string", "none", s:green, "none", "none", "none")
call s:hi("character", "none", s:teal, "none", "none", "none")
call s:hi("number", "none", s:peach, "none", "none", "none")
call s:hi("boolean", "none", s:peach, "none", "none", "none")
call s:hi("float", "none", s:peach, "none", "none", "none")
call s:hi("function", "none", s:blue, "none", "none", "none")
call s:hi("conditional", "none", s:red, "none", "none", "none")
call s:hi("repeat", "none", s:red, "none", "none", "none")
call s:hi("label", "none", s:peach, "none", "none", "none")
call s:hi("operator", "none", s:sky, "none", "none", "none")
call s:hi("keyword", "none", s:pink, "none", "none", "none")
call s:hi("include", "none", s:pink, "none", "none", "none")
call s:hi("storageclass", "none", s:yellow, "none", "none", "none")
call s:hi("structure", "none", s:yellow, "none", "none", "none")
call s:hi("typedef", "none", s:yellow, "none", "none", "none")
call s:hi("debugpc", "none", "none", s:crust, "none", "none")
call s:hi("debugbreakpoint", "none", s:overlay0, s:base, "none", "none")

hi link define preproc
hi link macro preproc
hi link precondit preproc
hi link specialchar special
hi link tag special
hi link delimiter special
hi link specialcomment special
hi link debug special
hi link exception error
hi link statuslineterm statusline
hi link statuslinetermnc statuslinenc
hi link terminal normal
hi link ignore comment

" set terminal colors for playing well with plugins like fzf
let g:terminal_ansi_colors = [
\ s:surface1, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:subtext1,
\ s:surface2, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:subtext0
\ ]

" ===================================================================
" Space is global leader key

noremap <Space> <Nop>

" ----------------------------------------------------------

" Set root for project
let projectroot = ['.git', '.root', '.project', '.workspace', 'WORKSPACE', 'Cargo.toml', 'compile_commands.json', 'cscope.out']

" ===================================================================
" async run
" Reference: https://github.com/skywind3000/asyncrun.vim/wiki/Better-way-for-C-and-Cpp-development-in-Vim-8
let g:asyncrun_bell = 1
let g:VimuxCloseOnExit = 1
let g:VimuxRunnerName = "vimuxout"
let g:asyncrun_open = 8
let g:asyncrun_rootmarks = projectroot
let g:asynctasks_term_reuse = 1
let g:asynctasks_config_name = '.task.ini'
if exists("$TMUX")
    let g:asynctasks_term_pos='tmuxsol'
else
    let g:asynctasks_term_pos='toggleterm'
endif

function! AsyncRunWith(commands)
    if exists("$TMUX")
        execute 'AsyncRun -mode=term -pos=tmuxsol -focus=0 ' . a:commands
    else
        execute 'AsyncRun -mode=term -pos=toggleterm -focus=0 ' . a:commands
    endif
endfunction

function! AsyncRunSilentlyWith(commands)
    execute 'AsyncRun -mode=term -pos=hide -close ' . a:commands
endfunction

function! ExecuteBufferWith(commands)
    call AsyncRunWith('-cwd=$(VIM_FILEDIR) ' . a:commands . ' $(VIM_FILENAME)')
endfunction

function! ExecuteBufferSilentlyWith(commands)
    call AsyncRunSilentlyWith('-cwd=$(VIM_FILEDIR) ' . a:commands . ' $(VIM_FILENAME)')
endfunction

function! ExecuteInBufferDirWith(commands)
    call AsyncRunWith('-cwd=$(VIM_FILEDIR) ' . a:commands)
endfunction

function! ExecuteInRootWith(commands)
    call AsyncRunWith('-cwd=<root> ' . a:commands)
endfunction

" ----------------------------------------------------------
" ### ctags / gutentags

" ctags
" search current directory first, then search up to home
set tags=./tags,tags;$HOME

" ====================================================================
" ====================================================================
" ## Key Mappings (map & noremap)

" Set key to toggle number & relativenumber on/off
noremap <silent> <F2> :set nonumber! norelativenumber!<CR>

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

" ## Remove whitespace at end of line
command! FixWhitespace :%s/\s\+$//e

" ----------------------------------------------------------
" " ## Replace selected word
" replace current word from current line to last line (confirm required)
nnoremap <leader>sw :.,$s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>
" replace current word from first line to last line (confirm required)
nnoremap <leader>sa :%s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>

" ----------------------------------------------------------
" ## Automatically set paste mode when pasting in insert mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" ----------------------------------------------------------

augroup cursormovedi
    autocmd!
    " set no highlight search after enter insert mode and move cursor
    autocmd CursorMovedI * set nohlsearch
    nnoremap n :set hlsearch<CR>n
    nnoremap N :set hlsearch<CR>N
    nnoremap / :set hlsearch<CR>/
    nnoremap ? :set hlsearch<CR>?
    nnoremap * :set hlsearch<CR>*
    nnoremap # :set hlsearch<CR>#
augroup end

augroup misc
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup end

" ====================================================================
" ====================================================================
