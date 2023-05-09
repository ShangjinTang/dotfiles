" Reference: https://github.com/junegunn/vim-plug
call plug#begin()

    " ======================================================================
    " vim script plugins
    " --------------------------------------------------
    " git plugin
    Plug 'tpope/vim-fugitive'
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
    " google code format
    Plug 'google/vim-codefmt' | Plug 'google/vim-maktaba' | Plug 'google/vim-glaive'
    " generate tags
    Plug 'ludovicchabant/vim-gutentags'
    " snippets
    Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'
    " --------------------------------------------------
    " restore last place while opening same file
    Plug 'farmergreg/vim-lastplace'
call plug#end()
