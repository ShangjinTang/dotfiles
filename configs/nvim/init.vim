lua require("LunarVim.init")

lua << EOF
    require("vim-init")
    require("plug-which-key")
    -- Note: autocmd should be placed at end of plugins
    require("autocmd")
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
" " ## Replace selected word with confirm popup
" replace current word forward with boundaries
nnoremap <leader>s* :.,$s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>
" replace current word forward without boundaries
nnoremap <leader>sg* :.,$s@<C-R>=expand("<cword>")<CR>@@gc<Left><Left><Left>

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
