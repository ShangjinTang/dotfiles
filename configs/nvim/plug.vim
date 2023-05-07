" Reference: https://github.com/junegunn/vim-plug
call plug#begin()
    " ======================================================================
    " 1. nvim lua plugins (in LunarVim)
    " --------------------------------------------------
    " nvim telescope
    " Plug 'nvim-telescope/telescope.nvim' | Plug 'nvim-lua/plenary.nvim'
    " " --------------------------------------------------
    " nvim which-key
    " Plug 'folke/which-key.nvim'
    " ======================================================================
    " 2. nvim lua plugins (not in LunarVim)
    " --------------------------------------------------
    " nvim zen-mode
    Plug 'folke/zen-mode.nvim', { 'on': ['ZenMode', 'ZenMode!'] }
    " --------------------------------------------------
    " nvim bufferline
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' } | Plug 'nvim-tree/nvim-web-devicons'
    " --------------------------------------------------
    " nvim yanky
    Plug 'gbprod/yanky.nvim'
    " --------------------------------------------------
    " nvim themes
    Plug 'navarasu/onedark.nvim'
    Plug 'shaunsingh/nord.nvim'
    " ======================================================================
    " 3. vim script plugins
    " --------------------------------------------------
    " git plugins
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
    " comment plugins
    Plug 'tpope/vim-surround'
    " --------------------------------------------------
    " google code format
    Plug 'google/vim-codefmt' | Plug 'google/vim-maktaba' | Plug 'google/vim-glaive'
    " generate tags
    Plug 'ludovicchabant/vim-gutentags'
    " snippets
    Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'
    " --------------------------------------------------
    " debugging for startup slow
    Plug 'dstein64/vim-startuptime'
    " --------------------------------------------------
    " restore last place while opening same file
    Plug 'farmergreg/vim-lastplace'
call plug#end()
