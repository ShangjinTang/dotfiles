source ~/.config/nvim/plug.vim

lua require("LunarVim.init")
lua require("vim-init")
lua require("plug-dap-cpp")
lua require("plug-telescope")
lua require("plug-which-key")
lua require("plug-zen-mode")

" clangd requires: clang>=11
lua require("lspconfig").clangd.setup{}
" vimls requires: `npm install -g vim-language-server`
lua require("lspconfig").vimls.setup{}

noremap <Space> <Nop>

" ----------------------------------------------------------

" Set root for project
let projectroot = ['.git', '.root', '.project', '.workspace', 'WORKSPACE', 'Cargo.toml', 'compile_commands.json']

" ===================================================================
" Generic Functions
" Reference:
"   filename-modifiers: https://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers

function! OpenCurrentFileWith(commands)
    " 'silent': to prevent prompt 'Press ENTER or type command to continue'
    execute 'silent !' . a:commands . ' ' . expand('%:p')
endfunction

" ----------------------------------------------------------
" ----------------------------------------------------------
" async run
" Reference: https://github.com/skywind3000/asyncrun.vim/wiki/Better-way-for-C-and-Cpp-development-in-Vim-8
let g:asyncrun_bell = 1
let g:VimuxCloseOnExit = 1
let g:VimuxRunnerName = "vimuxout"
let g:asyncrun_open = 8
let g:asyncrun_rootmarks = projectroot

function! AsyncRunWith(commands)
    if exists("$TMUX")
        execute 'AsyncRun -mode=term -pos=tmuxsol ' . a:commands
    else
        execute 'AsyncRun -mode=term ' . a:commands
    endif
endfunction

function! CMakeDebugWithTarget(target)
    call AsyncRunWith('-cwd=<root> cmakebuild -t ' . a:target)
endfunction

" :: AsyncRun with prompt
" 1: compile&run single file
" 2: compile&run files under current directory
" 3: "make all" in <root> directory
" 4: "make run" in <root> directory
" 5: "make <target>" in <root> directory
augroup asyncrun
    autocmd!
    " Async Command Line
    nnoremap <leader>as :call AsyncRunWith("")<Left><Left>
    nnoremap <leader>aq :VimuxCloseRunner<CR>
    " C & C++
    " Requires script: 'rc' (run c) or 'rcxx' (run c++)
    autocmd FileType c nnoremap <silent> <C-\>1 :call AsyncRunWith("cd $(VIM_FILEDIR); rc $(VIM_FILEPATH) --clean_output")<CR>
    autocmd FileType c nnoremap <silent> <C-\>2 :call AsyncRunWith("cd $(VIM_FILEDIR); rc --clean_output")<CR>
    autocmd FileType cpp nnoremap <silent> <C-\>1 :call AsyncRunWith("cd $(VIM_FILEDIR); rcxx $(VIM_FILEPATH) --clean_output")<CR>
    autocmd FileType cpp nnoremap <silent> <C-\>2 :call AsyncRunWith("cd $(VIM_FILEDIR); rcxx --clean_output")<CR>
    autocmd FileType c,cpp nnoremap <silent> <C-\>3 :call CMakeDebugWithTarget("all")<CR>
    autocmd BufRead,BufNewFile CMakeLists.txt nnoremap <silent> <C-\>3 :call CMakeDebugWithTarget("all")<CR>
    autocmd FileType c,cpp nnoremap <silent> <C-\>4 :call CMakeDebugWithTarget("run")<CR>
    autocmd BufRead,BufNewFile CMakeLists.txt nnoremap <silent> <C-\>4 :call CMakeDebugWithTarget("run")<CR>
    autocmd FileType c,cpp nnoremap <C-\>5 :call CMakeDebugWithTarget("")<Left><Left>
    autocmd BufRead,BufNewFile CMakeLists.txt nnoremap <C-\>5 :call CMakeDebugWithTarget("")<Left><Left>
    " Rust
    autocmd FileType rust nnoremap <silent> <C-\>1 :call AsyncRunWith("cd $(VIM_FILEDIR); rustc $(VIM_FILEPATH) && ./$(VIM_FILENOEXT) && rm ./$(VIM_FILENOEXT)")<CR>
    autocmd FileType rust nnoremap <silent> <C-\>3 :call AsyncRunWith("-cwd=<root> cargo build")<CR>
    autocmd FileType rust nnoremap <silent> <C-\>4 :call AsyncRunWith("-cwd=<root> cargo run")<CR>
    " Python3
    autocmd FileType python nnoremap <silent> <C-\>1 :call AsyncRunWith("cd $(VIM_FILEDIR); python3 $(VIM_FILEPATH)")<CR>
    " Bash
    autocmd FileType bash nnoremap <silent> <C-\>1 :call AsyncRunWith("cd $(VIM_FILEDIR); bash $(VIM_FILEPATH)")<CR>
augroup end

" ----------------------------------------------------------
" code format
if $VIM_CODEFMT_ENABLE == 1
    call glaive#Install()
    Glaive codefmt google_java_executable=`expand('java -jar $HOME/.dotfiles/configs/vim-plugins/vim-codefmt/google-java-format.jar --aosp')`
    augroup autoformat_settings
        autocmd!
        " execute 'go install github.com/bazelbuild/buildtools/buildifier@latest'
        autocmd FileType bzl AutoFormatBuffer buildifier
        autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
        autocmd FileType dart AutoFormatBuffer dartfmt
        autocmd FileType go AutoFormatBuffer gofmt
        autocmd FileType gn AutoFormatBuffer gn
        autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
        autocmd FileType java AutoFormatBuffer google-java-format
        " Alternative: autocmd FileType python AutoFormatBuffer autopep8
        autocmd FileType python AutoFormatBuffer yapf
        autocmd FileType rust AutoFormatBuffer rustfmt
        autocmd FileType vue AutoFormatBuffer prettier
        autocmd FileType swift AutoFormatBuffer swift-format
    augroup end
endif

" ----------------------------------------------------------
" ### vim-rooter (Use :Rooter to toggle switch to root)
let g:rooter_patterns = projectroot
let g:rooter_manual_only = 1
" let g:rooter_silent_chdir = 1

" ----------------------------------------------------------
" ### ctags / gutentags / cscope

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

" source code plugins

" vscode
nnoremap <silent> <leader>oc :call OpenCurrentFileWith("code")<CR>

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
" nnoremap <silent> <C-\>:TmuxNavigatePrevious<CR>

" ----------------------------------------------------------
" ## Move lines up / down
" Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ----------------------------------------------------------
" ## Quick Replace
nnoremap <leader>ss :.,$s@<C-R>=expand("<cword>")<CR>@@gc<Left><Left>
" replace current word from current line to last line (confirm required)
nnoremap <leader>sw :.,$s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>
nnoremap <leader>sW :.,$s@\<<C-R>=expand("<cWORD>")<CR>\>@@gc<Left><Left><Left>
" replace current word from first line to last line (confirm required)
nnoremap <leader>sa :%s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>
nnoremap <leader>sA :%s@\<<C-R>=expand("<cWORD>")<CR>\>@@gc<Left><Left><Left>
" replace current word in last visual selection
nnoremap <leader>sv :%s@\%V\<<C-R>=expand("<cword>")<CR>\>@@g<Left><Left>
nnoremap <leader>sV :%s@\%V\<<C-R>=expand("<cWORD>")<CR>\>@@g<Left><Left>

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

augroup inserttoggle
    autocmd!
    " disable line numbers in insert mode
    autocmd InsertEnter * set nonumber
    autocmd InsertEnter * set norelativenumber
    autocmd InsertLeave * set number
    autocmd InsertLeave * set relativenumber
augroup end

augroup misc
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup end


" ====================================================================
" ====================================================================
" ## Terminal Background

set background=light
colorscheme onedark
let t:is_transparent = 0

" ====================================================================
" ====================================================================

