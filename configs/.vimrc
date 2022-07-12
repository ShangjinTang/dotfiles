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
    set termguicolors
endif



" ====================================================================
" ====================================================================
" ## Plugins
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
    " source tree plugin
    Plug 'preservim/nerdtree'
    Plug 'vim-scripts/taglist.vim'
    " theme plugin
    Plug 'NLKNguyen/papercolor-theme'
call plug#end()

" ----------------------------------------------------------
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
let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.out$[[file]]', '^tags$[[file]]']

" ----------------------------------------------------------
" ### Theme papercolor
set background=light
colorscheme PaperColor
let g:airline_theme='papercolor'

" ----------------------------------------------------------
" ### ctags / cscope / taglist

" search current directory first, then search up to home
set tags=./tags,tags;$HOME

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
    nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Reference: http://vim-taglist.sourceforge.net/manual.html
let Tlist_WinWidth = 50
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Highlight_Tag = 0
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Compact_Format = 1
" let Tlist_Show_Menu = 1
" let Tlist_Use_Right_Window = 1
highlight MyTagListTitle guifg=#d70087
highlight MyTagListFileName guifg=#005f87



" ====================================================================
" ====================================================================
" ## Key Mappings (map & noremap)

let mapleader = "\<space>"

" Set key to toggle number & relativenumber
noremap <silent> <C-l> :set nonumber! norelativenumber!<cr>
" Set key to toggle number & relativenumber
noremap <silent> <C-p> :set invpaste<cr>

" vim buffer
nnoremap <silent> <leader>q :qa!<cr>     " Quit vim (close all buffers)
nnoremap <silent> <leader>w :bd<cr>      " Close current buffer
nnoremap <silent> <leader>[ :bp<cr>      " Switch to previous buffer
nnoremap <silent> <leader>] :bn<cr>      " Switch to next buffer

" source code plugins
noremap  <silent> <C-[> <C-t><cr>
nnoremap <silent> <leader><leader> :NERDTreeToggle<cr>
nnoremap <silent> <leader>t :TlistToggle<cr>

" ### Plugin map
noremap  <silent> <C-t> :FZF<cr>
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>g :Commits<cr>

" ----------------------------------------------------------
" ### Disable arrow keys, force use hjkl for cursor move
" TODO: remove these after familiar with hjkl
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" ----------------------------------------------------------
" ### Visual mode pressing * or # searches for the current selection
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
" ====================================================================
