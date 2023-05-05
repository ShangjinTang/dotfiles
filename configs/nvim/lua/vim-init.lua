-- ### Leader Key
vim.g.mapleader = ' '
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- ### Indent, tab, and spaces
vim.opt.autoindent = true                 -- Indent according to previous line.
vim.opt.expandtab = true                  -- Use spaces instead of tabs.
vim.opt.smarttab = true                   -- On - tabstop & shiftwidth, off - tabstop.
vim.opt.softtabstop = 4                   -- Tab key indents by 4 spaces.
vim.opt.shiftwidth = 4                    -- >> indents by 4 spaces.
vim.opt.shiftround = true                 -- >> indents to next multiple of 'shiftwidth'.

-- ### Display and show
vim.opt.history = 1000                    -- Sets how many lines of history VIM has to remember
vim.opt.cursorline = true                 -- Find the current line quickly.
vim.opt.display = lastline                -- Show as much as possible of the last line.
vim.opt.list = true                       -- Show non-printable characters.
vim.opt.matchtime = 1                     -- Tenths of a second to show the matching parent.
vim.opt.number = true                     -- Show current line number on the left.
vim.opt.relativenumber = true             -- Show relative line number of above/below lines on the left.
vim.opt.showmatch = true                  -- Show matching brackets when text indicator is over them.
vim.opt.so = 7                            -- Lines padding to bottom/top while moving with j/k.
vim.opt.synmaxcol = 240                   -- Only highlight the first 240 columns.

-- ### Cursor Move
vim.opt.backspace = 'indent,eol,start'    -- Allow backspacing over the indent, eol and start in Insert mode.
vim.opt.whichwrap = 'b,s,<,>,[,],h,l'     -- Allow cursor left/right to move to the previous/next line.

-- ### Status Line
vim.opt.laststatus = 2                    -- Always show statusline.

-- ### Command Line
vim.opt.cmdheight = 2                     -- Height of the command line.
vim.opt.report = 0                        -- Always report changed lines.
vim.opt.ruler = true                      -- Always show current position
vim.opt.showcmd = true                    -- Show {partial} command in the last line of the screen.
vim.opt.wildmenu = true                   -- Turn on the Wild menu.

-- ### Search
vim.opt.incsearch = true                  -- Highlight while searching with / or ?.
vim.opt.hlsearch = true                   -- Keep matches highlighted.
vim.opt.ignorecase = true                 -- Ignore case in search patterns.
vim.opt.smartcase = true                  -- Override the 'ignorecase' option if the search pattern contains upper case characters.
vim.opt.wrapscan = true                   -- Searches wrap around end-of-file.

-- ### Redraw Performance
vim.opt.lazyredraw = true                 -- Only redraw when necessary.
vim.opt.ttyfast = true                    -- Faster redrawing.

-- ### Multi Files & Split Window
vim.opt.hidden = true                     -- Switch between buffers without having to save first.
vim.opt.splitbelow = true                 -- Open new windows below the current window for :split.
vim.opt.splitright = true                 -- Open new windows right of the current window for :vsplit.

-- ### Number Formats
vim.opt.nrformats = 'bin,hex'          -- Do not recognize 0.. as octal number for command <C-a> and <C-x>

-- ### Use Unix as the standard file type
vim.opt.ffs = 'unix,dos,mac'

-- ### Turn backup off, since most stuff is in git anyway...
-- vim.opt.nobackup = true
-- vim.opt.nowb = true
-- vim.opt.noswapfile = true

-- ### No annoying sound on errors
-- vim.opt.noerrorbells = true
-- vim.opt.novisualbell = true
-- vim.opt.t_vb = ''
-- vim.opt.tm = 500

-- ### Persistent Undo
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
vim.opt.undofile = true
