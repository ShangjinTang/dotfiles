" Reference: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
    " --------------------------------------------------
    " nvim telescope
    Plug 'nvim-telescope/telescope.nvim' | Plug 'nvim-lua/plenary.nvim'
    " --------------------------------------------------
    " nvim which-key
    Plug 'folke/which-key.nvim'
    " --------------------------------------------------
    " nvim zen-mode
    Plug 'folke/zen-mode.nvim', { 'on': ['ZenMode', 'ZenMode!'] }
    " --------------------------------------------------
    " --------------------------------------------------
    " --------------------------------------------------
    " wilder in command line bar (requires: `pip3 install pynvim`)
    function! UpdateRemotePlugins(...)
        " Needed to refresh runtime files
        let &rtp=&rtp
        UpdateRemotePlugins
    endfunction
    Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
    Plug 'roxma/nvim-yarp' | Plug 'roxma/vim-hug-neovim-rpc'
    " --------------------------------------------------
    " airline (status bar) & themes
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
    " vim themes
    Plug 'arcticicestudio/nord-vim' | Plug 'NLKNguyen/papercolor-theme'
    " bracket highlighting
    Plug 'luochen1990/rainbow'
    " --------------------------------------------------
    " git plugins
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " --------------------------------------------------
    " fuzzy finder
    Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
    " --------------------------------------------------
    " project management
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'airblade/vim-rooter'
    " --------------------------------------------------
    " use same keys navigate between tmux/vim
    Plug 'christoomey/vim-tmux-navigator'
    " async run (with tmux)
    Plug 'skywind3000/asyncrun.vim' | Plug 'skywind3000/asynctasks.vim' | Plug 'preservim/vimux'
    " --------------------------------------------------
    " comment plugins
    Plug 'tpope/vim-commentary' | Plug 'tpope/vim-surround'
    " --------------------------------------------------
    " google code format
    Plug 'google/vim-codefmt' | Plug 'google/vim-maktaba' | Plug 'google/vim-glaive'
    " generate tags
    Plug 'ludovicchabant/vim-gutentags'
    " snippets
    Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'
    " switch between c/c++ header & source file
    Plug 'ericcurtin/CurtineIncSw.vim', { 'for': ['c','cpp'] }
    " --------------------------------------------------
    " debugging for startup slow
    Plug 'dstein64/vim-startuptime'
    " --------------------------------------------------
    " restore last place while opening same file
    Plug 'farmergreg/vim-lastplace'
    " --------------------------------------------------
    " start screen
    Plug 'mhinz/vim-startify'
    " --------------------------------------------------
    " directory tree
    Plug 'preservim/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle'] }
    " --------------------------------------------------
    " " vim color generator
    " Plug 'lifepillar/vim-colortemplate'
    " coc code completion
    if $VIM_COC_ENABLE == 1
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
    else
        " tab completion plugin (conflict with coc)
        Plug 'ervandew/supertab'
    endif
call plug#end()
