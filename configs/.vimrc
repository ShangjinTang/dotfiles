" # VIM bashrc by shangjin.tang@gmail.com

" ====================================================================
" ====================================================================
" ## General Settings
filetype indent on              " Enable filetype indent.
filetype plugin on              " Enable filetype plugin.
set history=1000                " Sets how many lines of history VIM has to remember.
syntax enable

" ### Indent, tab, and spaces
set autoindent                 " Indent according to previous line.
set expandtab                  " Use spaces instead of tabs.
set smarttab                   " On - tabstop & shiftwidth, off - tabstop.
set softtabstop=4              " Tab key indents by 4 spaces.
set shiftwidth=4               " >> indents by 4 spaces.
set shiftround                 " >> indents to next multiple of 'shiftwidth'.

" ### Display and show
set cursorline                 " Find the current line quickly.
set display=lastline           " Show as much as possible of the last line.
" set list                       " Show non-printable characters.
set matchtime=1                " Tenths of a second to show the matching parent.
set number                     " Show current line number on the left.
set relativenumber             " Show relative line number of above/below lines on the left.
set showmatch                  " Show matching brackets when text indicator is over them.
set so=7                       " Lines padding to bottom/top while moving with j/k.
set synmaxcol=200              " Only highlight the first 200 columns.
" ### Cursor Move
set backspace=indent,eol,start " Allow backspacing over the indent, eol and start in Insert mode.
set whichwrap+=<,>,h,l         " Allow cursor left/right to move to the previous/next line.

" ### Status Line
set laststatus=2               " Always show statusline.

" ### Command Line
set cmdheight=2                " Height of the command line.
set report=0                   " Always report changed lines.
set ruler                      " Always show current position
set showcmd                    " Show {partial} command in the last line of the screen.
set wildmenu                   " Turn on the Wild menu.

" ### Search
set incsearch                  " Highlight while searching with / or ?.
set hlsearch                   " Keep matches highlighted.
set ignorecase                 " Ignore case in search patterns.
set smartcase                  " Override the 'ignorecase' option if the search pattern contains upper case characters.
set wrapscan                   " Searches wrap around end-of-file.

" ### Redraw Performance
set lazyredraw                 " Only redraw when necessary.
set ttyfast                    " Faster redrawing.

" ### Mutli Files & Split Window
set hidden                     " Switch between buffers without having to save first.
set splitbelow                 " Open new windows below the current window for :split.
set splitright                 " Open new windows right of the current window for :vsplit.

" ### Number Formats
set nrformats=bin,hex          " Do not recognize 0.. as octal number for command <C-a> and <C-x>

" ----------------------------------------------------------

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
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

" vim patch 7.4.1799 support termguicolors (true color)
if has("termguicolors")
    " set termguicolors
endif

set term=screen-256color



" ====================================================================
" ====================================================================
" ## Plugins
" ## vim-plug from https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
    " status bar plugins
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'arcticicestudio/nord-vim'
    " git plugins
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " fzf plugins
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    " bookmark plugin
    Plug 'MattesGroeger/vim-bookmarks'
    " comment plugin
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    " use same keys navigate between tmux/vim
    Plug 'christoomey/vim-tmux-navigator'
    " bracket highlighting
    Plug 'luochen1990/rainbow'
    " theme plugin
    Plug 'NLKNguyen/papercolor-theme'
    " google code format
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'
    " snippets
    Plug 'honza/vim-snippets'
    " async run
    Plug 'skywind3000/asyncrun.vim'
    Plug 'preservim/vimux'
    " generate tags
    Plug 'ludovicchabant/vim-gutentags'
    " switch between header and source file
    Plug 'ericcurtin/CurtineIncSw.vim'
    " startup time
    Plug 'dstein64/vim-startuptime'
    " coc code completion
    if $VIM_COC_ENABLE == 1
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    else
        " tab completion plugin (conflict with coc)
        Plug 'ervandew/supertab'
    endif
call plug#end()

" ----------------------------------------------------------
" ### airline
" Reference: https://github.com/vim-airline/vim-airline/blob/master/doc/airline.txt
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'  " show filepath on filenames comflict
let g:airline#extensions#tabline#fnamemod = ':t'  " only show filename (if filenames not comflict). use `:help filename-modifiers` to check all available options
let g:airline#extensions#tabline#buffer_nr_show = 1  " show file buffer number (index)
let g:airline#extensions#tabline#buffer_nr_format = '%s '

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace = ""
let g:airline_symbols.readonly = "[readonly]"
let g:airline_symbols.maxlinenr = ""
let g:airline_symbols.linenr = " L:"
let g:airline_symbols.colnr = " C:"
let g:airline_symbols.branch = "⎇"
let g:airline_symbols.notexists = " ?"
let g:airline_symbols.dirty = " !"

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
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '.project', '.workspace', 'Cargo.toml']

function! AsyncRunWith(commands)
    if exists("$TMUX")
        execute $"AsyncRun -mode=term -pos=tmuxsol {a:commands}"
    else
        execute $"AsyncRun -mode=term {a:commands}"
    endif
endfunction

function! CMakeDebugWithTarget(target)
    call AsyncRunWith($"-cwd=<root> cmake -S . -B build && cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug --target {a:target} .. && cp compile_commands.json .. && make {a:target}")
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
    nnoremap <C-\>: :call AsyncRunWith("")<Left><Left>
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
    Glaive codefmt google_java_executable=`expand('java -jar $HOME/.dotfiles/archive/vim_codefmt/google-java-format.jar --aosp')`
    augroup autoformat_settings
        autocmd!
        autocmd FileType bzl AutoFormatBuffer buildifier
        autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
        autocmd FileType dart AutoFormatBuffer dartfmt
        autocmd FileType go AutoFormatBuffer gofmt
        autocmd FileType gn AutoFormatBuffer gn
        autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
        autocmd FileType java AutoFormatBuffer google-java-format
        autocmd FileType python AutoFormatBuffer yapf
        " Alternative: autocmd FileType python AutoFormatBuffer autopep8
        autocmd FileType rust AutoFormatBuffer rustfmt
        autocmd FileType vue AutoFormatBuffer prettier
        autocmd FileType swift AutoFormatBuffer swift-format
    augroup end
endif

" ----------------------------------------------------------
" ### CurtineIncSw
map <silent> <C-\><C-o> :call CurtineIncSw()<CR>

" ----------------------------------------------------------
" ### ctags / gutentags / cscope

" ctags
" search current directory first, then search up to home
set tags=./tags,tags;$HOME

" gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project', '.workspace']
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

    nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    " nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    " nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    " nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif


" ====================================================================
" ====================================================================
" ## Key Mappings (map & noremap)

let mapleader = "\<Space>"

" Set key to toggle paste mode on/off
set pastetoggle=<C-p>
" Set key to toggle number & relativenumber on/off
noremap <silent> <leader>l :set nonumber! norelativenumber!<CR>

" vim buffer
nnoremap <silent> <leader>q :qa!<CR>     " Quit vim (close all buffers)
nnoremap <silent> <leader>w :bd<CR>      " Close current buffer
nnoremap <silent> <leader><Tab> :b#<CR>  " Switch between current buffer and previous buffer
nnoremap <silent> <leader>{ :bf<CR>      " Switch to first buffer
nnoremap <silent> <leader>} :bl<CR>      " Switch to last buffer
nnoremap <silent> <leader>[ :bp<CR>      " Switch to previous buffer
nnoremap <silent> <leader>] :bn<CR>      " Switch to next buffer
nnoremap <silent> <leader>1 :b1<CR>      " Switch to buffer 1
nnoremap <silent> <leader>2 :b2<CR>      " Switch to buffer 2
nnoremap <silent> <leader>3 :b3<CR>      " Switch to buffer 3
nnoremap <silent> <leader>4 :b4<CR>      " Switch to buffer 4
nnoremap <silent> <leader>5 :b5<CR>      " Switch to buffer 5
nnoremap <silent> <leader>6 :b6<CR>      " Switch to buffer 6
nnoremap <silent> <leader>7 :b7<CR>      " Switch to buffer 7
nnoremap <silent> <leader>8 :b8<CR>      " Switch to buffer 8
nnoremap <silent> <leader>9 :b9<CR>      " Switch to buffer 9


" source code plugins

" fzf
nnoremap <silent> <leader><leader> :FZF<CR>

" git shortcuts, starts with <leader>g
" fzf
nnoremap <silent> <leader>gl :Commits<CR>
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
" Disable arrow keys, force use hjkl for cursor move
" TODO: remove these after familiar with hjkl
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" ----------------------------------------------------------
" ## Move lines up / down
" Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ----------------------------------------------------------
" ## Quick Replace
" replace current word from current line to last line (confirm required)
nnoremap <leader>sw :.,$s/\<<C-R>=expand("<cword>")<CR>\>//gc<Left><Left><Left>
nnoremap <leader>sW :.,$s/\<<C-R>=expand("<cWORD>")<CR>\>//gc<Left><Left><Left>
" replace current word from first line to last line (confirm required)
nnoremap <leader>sa :%s/\<<C-R>=expand("<cword>")<CR>\>//gc<Left><Left><Left>
nnoremap <leader>sA :%s/\<<C-R>=expand("<cWORD>")<CR>\>//gc<Left><Left><Left>
" replace current word in last visual selection
nnoremap <leader>sv :%s/\%V\<<C-R>=expand("<cword>")<CR>\>//g<Left><Left>
nnoremap <leader>sV :%s/\%V\<<C-R>=expand("<cWORD>")<CR>\>//g<Left><Left>

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
    let g:airline_theme='papercolor'
else
    set background=dark
    if $TERMINAL_THEME == 'dark'
        colorscheme PaperColor
        let g:airline_theme='onedark'
        let t:is_transparent = 1
    endif
    if $TERMINAL_THEME == 'nord'
        colorscheme nord
        let g:airline_theme='nord'
        let t:is_transparent = 1
    endif
    function! Toggle_transparent_background()
        if t:is_transparent == 0
            hi Normal ctermbg=Black
            hi Visual ctermbg=DarkGray
            let t:is_transparent = 1
        else
            hi Normal guibg=NONE ctermbg=NONE
            let t:is_transparent = 0
        endif
    endfunction
    call Toggle_transparent_background()
    nnoremap <leader>0 :call Toggle_transparent_background()<CR>

    highlight LineNr ctermbg=NONE guibg=NONE
    highlight clear SignColumn
    highlight airline_c  ctermbg=NONE guibg=NONE
    highlight airline_tabfill ctermbg=NONE guibg=NONE
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

    let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-vimlsp', 'coc-clangd', 'coc-java', 'coc-python', 'coc-sh', 'coc-cmake', 'coc-snippets', 'coc-pairs', 'coc-yank']

    set updatetime=100

    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file.
    inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-@> to trigger completion.
    inoremap <silent><expr> <c-@> coc#refresh()


    " GoTo code navigation.
    nnoremap <silent> <C-\>G <Plug>(coc-definition)
    nnoremap <silent> <C-\>S <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call ShowDocumentation()<CR>

    function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nnoremap <C-\>r <Plug>(coc-rename)

    " GoTo prev/next fix.
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nnoremap <silent> <C-\>f[ <Plug>(coc-diagnostic-prev)
    nnoremap <silent> <C-\>f] <Plug>(coc-diagnostic-next)
    " AutoFix in the selected region.
    " Example: `COMMAND` + `ap` for current paragraph
    xnoremap <C-\>fr  <Plug>(coc-codeaction-selected)
    nnoremap <C-\>fr  <Plug>(coc-codeaction-selected)
    " AutoFix in current file (buffer)
    nnoremap <C-\>fa  <Plug>(coc-codeaction)
    " AutoFix to problem on the current line.
    nnoremap <C-\>ff  <Plug>(coc-fix-current)

    " yank
    nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

endif

" ====================================================================
" ====================================================================
