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
let g:asyncrun_open = 8
let g:asyncrun_rootmarks = projectroot
let g:asynctasks_term_pos='toggleterm'

function! AsyncRunWith(commands)
    execute 'AsyncRun -mode=term -pos=toggleterm -focus=0 ' . a:commands
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

" ## Remove whitespace at end of line
command! FixWhitespace :%s/\s\+$//e

" ----------------------------------------------------------
" " ## Replace selected word
" replace current word from current line to last line (confirm required)
nnoremap <leader>sw :.,$s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>
" replace current word from first line to last line (confirm required)
nnoremap <leader>sa :%s@\<<C-R>=expand("<cword>")<CR>\>@@gc<Left><Left><Left>

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

" ----------------------------------------------------------
" switch.vim

" Don't use default mappings
let g:speeddating_no_mappings = 1
let b:switch_custom_definitions = [ [], ]
augroup switch_definition_on_filetype
    autocmd!
    autocmd FileType markdown let b:switch_custom_definitions = [
                \ ['[ ]', '[x]'],
                \ ['# ', '## ', '### ', '#### ', '##### ', '###### ' ],
                \ ]
    autocmd FileType norg let b:switch_custom_definitions = [
                \ ['( )', '(-)', '(x)', '(=)', '(!)'],
                \ ['* ', '** ', '*** ', '**** ', '***** ', '****** ' ],
                \ ]
augroup end

nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
nnoremap <silent> <Plug>(SwitchInLineReverse) :<C-u>call SwitchLineReverse(v:count1)<cr>
nmap <C-a> <Plug>(SwitchInLine)
nmap <C-x> <Plug>(SwitchInLineReverse)

fun! SwitchLine(cnt)
    let tick = b:changedtick
    let start = getcurpos()
    for n in range(a:cnt)
        Switch
    endfor
    if b:changedtick != tick
        return
    endif
    while v:true
        let pos = getcurpos()
        normal! w
        if pos[1] != getcurpos()[1] || pos == getcurpos()
            break
        endif
        for n in range(a:cnt)
            Switch
        endfor
        if b:changedtick != tick
            return
        endif
    endwhile
    call setpos('.', start)
endfun

fun! SwitchLineReverse(cnt)
    let tick = b:changedtick
    let start = getcurpos()
    for n in range(a:cnt)
        SwitchReverse
    endfor
    if b:changedtick != tick
        return
    endif
    while v:true
        let pos = getcurpos()
        normal! w
        if pos[1] != getcurpos()[1] || pos == getcurpos()
            break
        endif
        for n in range(a:cnt)
            SwitchReverse
        endfor
        if b:changedtick != tick
            return
        endif
    endwhile
    call setpos('.', start)
endfun

" ====================================================================
" ====================================================================

