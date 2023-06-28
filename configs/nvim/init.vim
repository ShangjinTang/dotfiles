lua require("LunarVim.init")

lua << EOF
    require("vim-init")
    require("plug-dap-cpp")
    require("plug-which-key")
EOF

noremap <Space> <Nop>

" ----------------------------------------------------------

" Set root for project
let projectroot = ['.git', '.root', '.project', '.workspace', 'WORKSPACE', 'Cargo.toml', 'compile_commands.json']

" ===================================================================
" async run
" Reference: https://github.com/skywind3000/asyncrun.vim/wiki/Better-way-for-C-and-Cpp-development-in-Vim-8
let g:asyncrun_bell = 1
let g:VimuxCloseOnExit = 1
let g:VimuxRunnerName = "vimuxout"
let g:asyncrun_open = 8
let g:asyncrun_rootmarks = projectroot
if exists("$TMUX")
    let g:asynctasks_term_pos='tmuxsol'
else
    let g:asynctasks_term_pos='quickfix'
endif

function! AsyncRunWith(commands)
    if exists("$TMUX")
        execute 'AsyncRun -mode=term -pos=tmuxsol -focus=0 ' . a:commands
    else
        execute 'AsyncRun -mode=term -focus=0 -rows=8 ' . a:commands
    endif
endfunction

function! ExecuteBufferWith(commands)
    call AsyncRunWith('-cwd=$(VIM_FILEDIR) ' . a:commands . ' $(VIM_FILENAME)')
endfunction

function! ExecuteBufferSilentlyWith(commands)
    " 'silent': to prevent prompt 'Press ENTER or type command to continue'
    call ExecuteBufferWith('-silent ' . a:commands)
endfunction

function! ExecuteInBufferDirWith(commands)
    call AsyncRunWith('-cwd=$(VIM_FILEDIR) ' . a:commands)
endfunction

function! ExecuteInRootWith(commands)
    call AsyncRunWith('-cwd=<root> ' . a:commands)
endfunction

" ----------------------------------------------------------
" code format
" References: https://github.com/google/vim-codefmt/blob/master/doc/codefmt.txt
if $VIM_CODEFMT_ENABLE == 1
    Glaive codefmt google_java_executable=`expand('java -jar $HOME/.dotfiles/configs/vim-plugins/vim-codefmt/google-java-format.jar --aosp')`
    augroup autoformat_settings
        autocmd!
        "------------------------------------------------------------
        autocmd FileType java AutoFormatBuffer google-java-format
        "------------------------------------------------------------
        " go install github.com/bazelbuild/buildtools/buildifier@latest'
        autocmd FileType bzl AutoFormatBuffer buildifier
        "------------------------------------------------------------
        " go install mvdan.cc/sh/v3/cmd/shfmt@latest
        " ArchLinux: sudo pacman -Sy shfmt
        autocmd FileType sh,bash,zsh AutoFormatBuffer shfmt
        "------------------------------------------------------------
        " go install mvdan.cc/gofumpt@latest
        autocmd FileType go AutoFormatBuffer gofmt
        "------------------------------------------------------------
        " ArchLinux: sudo pacman -Sy clang
        " Ubuntu: sudo apt-get -y install clang-format
        autocmd FileType c,cpp,cuda,proto,arduino AutoFormatBuffer clang-format
        "------------------------------------------------------------
        " npm install --global js-beautify
        autocmd FileType html,css,javascript,sass,scss,less,json AutoFormatBuffer js-beautify
        "------------------------------------------------------------
        " ArchLinux: sudo pacman -Sy python-black
        autocmd FileType python AutoFormatBuffer black
        "------------------------------------------------------------
        " rustup component add rustfmt
        autocmd FileType rust AutoFormatBuffer rustfmt
        "------------------------------------------------------------
        " autocmd FileType gn AutoFormatBuffer gn
        "------------------------------------------------------------
        " autocmd FileType vue AutoFormatBuffer prettier
        "------------------------------------------------------------
        " autocmd FileType dart AutoFormatBuffer dartfmt
        "------------------------------------------------------------
        " autocmd FileType swift AutoFormatBuffer swift-format
        "------------------------------------------------------------
    augroup end
endif

" ----------------------------------------------------------
" ### vim-rooter (Use :Rooter to toggle switch to root)
let g:rooter_patterns = projectroot
let g:rooter_manual_only = 1
" let g:rooter_silent_chdir = 1

" ----------------------------------------------------------
" ### ctags / gutentags

" ctags
" search current directory first, then search up to home
set tags=./tags,tags;$HOME

" gutentags
let g:gutentags_project_root = projectroot
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

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

" ----------------------------------------------------------
" ## Move lines up / down
" Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ## Remove whitespace at end of line
command! FixWhitespace :%s/\s\+$//e

" ----------------------------------------------------------
" " ## Replace selected word
" replace current word from current line to last line (confirm required)
nnoremap <leader>Sw :.,$s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>
" replace current word from first line to last line (confirm required)
nnoremap <leader>SW :%s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>

" ----------------------------------------------------------
" ## Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-r>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-r>=@/<CR><CR>
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

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
    autocmd BufWritePre *.norg if &filetype == 'norg' | silent! call mkdir(expand('%:p:h'), 'p') | endif
augroup end

" ====================================================================
" ====================================================================

