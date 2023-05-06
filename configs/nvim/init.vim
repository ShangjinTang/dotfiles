source ~/.config/nvim/plug.vim

lua require("LunarVim.init")
lua require("vim-init")
lua require("plug-coc")
lua require("plug-dap-cpp")
lua require("plug-telescope")
lua require("plug-which-key")
lua require("plug-zen-mode")

noremap <Space> <Nop>

" ----------------------------------------------------------

" Set root for project
let projectroot = ['.git', '.root', '.project', '.workspace', 'WORKSPACE', 'Cargo.toml', 'compile_commands.json']

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*
else
    set wildignore+=*/.git/*,*/.DS_Store
endif

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" ===================================================================
" Generic Functions
" Reference:
"   filename-modifiers: https://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers

function! ExecuteWithCurrentFile(commands)
    " 'silent': to prevent prompt 'Press ENTER or type command to continue'
    " 'redraw': fix screen black after executing
    execute $"silent !{a:commands} %:p" | redraw!
endfunction

" ----------------------------------------------------------
" ----------------------------------------------------------
" ### NERDTree
" Reference: https://github.com/dmerejkowsky/vim-nerdtree/blob/master/doc/NERD_tree.txt
let NERDTreeShowBookmarks = 1
let NERDTreeBookmarksSort = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', 'cscope.*$[[file]]', '^tags$[file[]]']

augroup nerdtree
    autocmd!
    " Disable relative number for NERDTree
    autocmd FileType nerdtree set norelativenumber
    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " Close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree' && b:NERDTree.isTabTree()) | quit | endif
augroup end
autocmd FileType nerdtree set norelativenumber
nnoremap <leader><leader> :NERDTreeToggle<CR>

" ----------------------------------------------------------
" bracket highlighting
let g:rainbow_conf = {'ctermfgs': [162, 166, 28, 24, 91]}
let g:rainbow_active = 1

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
        execute $"AsyncRun -mode=term -pos=tmuxsol {a:commands}"
    else
        execute $"AsyncRun -mode=term {a:commands}"
    endif
endfunction

function! CMakeDebugWithTarget(target)
    call AsyncRunWith($"-cwd=<root> cmakebuild -t {a:target}")
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
" ### CurtineIncSw
" ,: language specific; is: Include Switch
autocmd FileType c,cpp map <silent> ,is :call CurtineIncSw()<CR>

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

" cscope
" use capitalize key binding; lowercase is for vim-coc
" Reference: http://cscope.sourceforge.net/cscope_vim_tutorial.html
if has("cscope")
    set cscopetag
    set csto=1
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose

    nnoremap <C-\>S :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>G :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>C :cs find c <C-R>=expand("<cword>")<CR><CR>
    " nnoremap <C-\>T :cs find t <C-R>=expand("<cword>")<CR><CR>
    " nnoremap <C-\>E :cs find e <C-R>=expand("<cword>")<CR><CR>
    " nnoremap <C-\>F :cs find f <C-R>=expand("<cfile>")<CR><CR>
    " nnoremap <C-\>I :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>D :cs find d <C-R>=expand("<cword>")<CR><CR>
endif


" ====================================================================
" ====================================================================
" ## Key Mappings (map & noremap)

" Force Quit
noremap <silent> <leader>q :qa!<CR>

" Set key to toggle number & relativenumber on/off
noremap <silent> <F2> :set nonumber! norelativenumber!<CR>:GitGutterToggle<CR>

" vim
" edit vimrc
nnoremap <silent> <leader>fe :e $MYVIMRC<CR>
" Reload vim without restart
nnoremap <silent> <leader>fR :so $MYVIMRC<CR>

" source code plugins

" vscode
nnoremap <silent> <leader>oc :call ExecuteWithCurrentFile("code")<CR>

" fzf.vim
" set floating window
if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-r40%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.4, 'height': 0.9, 'xoffset': 1, 'yoffset': 0.45} }
endif
let g:fzf_preview_window = ['up,80%', 'ctrl-/']

" git shortcuts, starts with <leader>g
" fzf
" git commits in this repository
nnoremap <silent> <leader>gl :Commits<CR>
" git commits for current file
nnoremap <silent> <leader>gf :BCommits<CR>
" git diff
nnoremap <silent> <leader>gd :GFiles?<CR>
" vim-fugitive
nnoremap <silent> <leader>gb :Git blame<CR>
" vim-gitgutter
let g:gitgutter_map_keys = 0
nnoremap <silent> <leader>g] :GitGutterNextHunk<CR>
nnoremap <silent> <leader>g[ :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>gs :GitGutterStageHunk<CR>
nnoremap <silent> <leader>gu :GitGutterUndoHunk<CR>
nnoremap <silent> <leader>gp :GitGutterPreviewHunk<CR>


" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
" nnoremap <silent> <C-\>:TmuxNavigatePrevious<CR>

" ----------------------------------------------------------
" Uncomment below to disable arrow keys, force use hjkl for cursor move
" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

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
    autocmd InsertEnter * :GitGutterSignsDisable
    autocmd InsertLeave * set number
    autocmd InsertLeave * set relativenumber
    autocmd InsertLeave * :GitGutterSignsEnable
augroup end

augroup misc
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup end


" ====================================================================
" ====================================================================
" ## Terminal Background

if $TERMINAL_THEME == 'light'
    set background=light
    colorscheme PaperColor
else
    set background=dark
    if $TERMINAL_THEME == 'dark'
        colorscheme PaperColor
        let t:is_transparent = 1
    endif
    if $TERMINAL_THEME == 'nord'
        colorscheme nord
        let t:is_transparent = 1
    endif
    function! Toggle_transparent_background()
        if t:is_transparent == 0
            highlight Normal ctermbg=Black guibg=Black
            let t:is_transparent = 1
        else
            highlight Normal ctermbg=NONE guibg=NONE
            if $TERMINAL_THEME == 'nord'
                highlight Comment ctermfg=Gray guifg=Gray
            endif
            let t:is_transparent = 0
        endif
    endfunction
    call Toggle_transparent_background()
    nnoremap <leader>0 :call Toggle_transparent_background()<CR>

    highlight LineNr ctermbg=NONE guibg=NONE
    highlight clear SignColumn
endif

" ====================================================================
" ====================================================================

if $VIM_COC_ENABLE == 0
    " ----------------------------------------------------------
    " ### SuperTab
    " Do not create new space after select completion by <Space>
    inoremap <expr> <Space> pumvisible() ? "\<C-y>" : " "
    " Do not create new line after select completion by <Enter>
    let g:SuperTabCrMapping = 1

else
    " ----------------------------------------------------------
    " ### coc

    let g:coc_global_extensions = [
        \ 'coc-vimlsp',
        \ 'coc-clangd',
        \ 'coc-cmake',
        \ 'coc-java',
        \ 'coc-pyright',
        \ 'coc-sh',
        \ 'coc-rust-analyzer',
        \ 'coc-tsserver',
        \ 'coc-yaml',
        \ 'coc-json',
        \ 'coc-xml',
        \ 'coc-toml',
        \ 'coc-markdownlint',
        \ 'coc-snippets',
        \ 'coc-pairs',
        \ 'coc-yank'
        \ ]

    " coc-fzf
    let g:coc_fzf_preview = 'up:90%'
    let g:coc_fzf_preview_fullscreen = 0
    let g:coc_fzf_location_delay = 1  " fix auto jump to first line after close floating window
    let g:coc_fzf_opts = []
endif
