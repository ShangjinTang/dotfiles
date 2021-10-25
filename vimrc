" # VIM bashrc by shangjin.tang@gmail.com

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
set pastetoggle=<F2>           " Key to swtich on/off paste mode.

" ### Display and show
set cursorline                 " Find the current line quickly.
set display=lastline           " Show as much as possible of the last line.
" set list                       " Show non-printable characters.
set matchtime=1                " Tenths of a second to show the matching paren.
" set relativenumber
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

" ====================================================================

" ## Key Combination (map & noremap)

let mapleader = "\<space>"               " Mapleader used for extra key combinations
" noremap <leader>w :w!<cr>              " Fast saving with mapleader
" command W w !sudo tee % > /dev/null    " (useful for handling the permission-denied error)
nnoremap <leader>q :qa!<cr>     " Close vim
nnoremap <leader>w :bd<cr>      " Close buffer
nnoremap <leader>[ :bp<cr>      " Switch to previous buffer
nnoremap <leader>] :bn<cr>      " Switch to next buffer


" ----------------------------------------------------------
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
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

" ====================================================================

" ### Others

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
    set termguicolors
endif
" ====================================================================

" ## vim-plug from https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
    " status bar plugin
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " git support plugin
    Plug 'tpope/vim-fugitive'
    " fzf plugin
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    " comment plugin
    Plug 'tpope/vim-commentary'
    " file tree plugin
    Plug 'preservim/nerdtree'
    " theme plugin
    Plug 'NLKNguyen/papercolor-theme'
call plug#end()

" ----------------------------------------------------------
" ### Plugin map
nnoremap <C-t> :FZF<cr>         " fzf CTRL-T
nnoremap <leader>f :Files<cr>   " fzf **<TAB>
nnoremap <leader>l :Commits<cr> " fzf & fugitive, show git commits

" ### airline
" Reference: https://github.com/vim-airline/vim-airline/blob/master/doc/airline.txt
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'  " show filepath on filenames comflict
let g:airline#extensions#tabline#fnamemod = ':t'  " only show filename (if filenames not comflict). use `:help filename-modifiers` to check all available options

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
" ### NERDTree
let NERDTreeShowBookmarks = 1
let NERDTreeQuitOnOpen = 1  " 1 = Close file, 2 = Close bookmark, 3 = Both
nnoremap <leader><leader> :NERDTreeToggle<cr>

" ----------------------------------------------------------
" ### Theme papercolor
set background=light
colorscheme PaperColor
let g:airline_theme='papercolor'

" ====================================================================
