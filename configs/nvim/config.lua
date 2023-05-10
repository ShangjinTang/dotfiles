--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- general
lvim.log.level = "info"
lvim.format_on_save = {
    enabled = true,
    pattern = "*.lua",
    timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "onedark"
lvim.transparent_window = os.getenv("TERMINAL_TRANSPARENT")

vim.opt.background = os.getenv("TERMINAL_THEME")

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/configuration/language-features/language-servers>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/configuration/language-features/linting-and-formatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     exe = "eslint",
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

lvim.builtin.telescope.pickers = {
    find_files = {
        layout_config = {
            width = { 0.8, max = 120 },
        },
    },
    git_files = {
        layout_config = {
            width = { 0.8, max = 120 },
        },
    },
    grep_string = {
        layout_config = {
            width = { 0.8, max = 120 },
        },
    },
    live_grep = {
        layout_config = {
            width = { 0.8, max = 120 },
        },
    },
}

-- Additional Plugins <https://www.lunarvim.org/docs/configuration/plugins/user-plugins>
lvim.plugins = {

    -- Plugins will be lazy-loaded when one of the following is true:
    --   - The plugin only exists as a dependency in your spec
    --   - It has an event, cmd, ft or keys key
    --   - lazy = true

    -- Themes
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        dependencies = {
            "nvim-lualine/lualine.nvim",
            "akinsho/bufferline.nvim",
        },
        config = function()
            require("onedark").setup({
                style = os.getenv("TERMINAL_THEME"),
                transparent = os.getenv("TERMINAL_TRANSPARENT"),
                lualine = {
                    transparent = os.getenv("TERMINAL_TRANSPARENT"),
                },
            })
            require('lualine').setup {
                options = {
                    theme = 'onedark',
                },
            }
            local bufferline = require('bufferline')
            bufferline.setup({
                options = {
                    diagnostics = "nvim_lsp",
                    offsets = { { filetype = "NvimTree", text = "File Explorer", } },
                    separator_style = "thin",
                    style_preset = bufferline.style_preset.no_italic,
                },
            })
            require("which-key").setup({
                window = {
                    border = "single",
                    winblend = 20,
                },
            })
            require('onedark').load()
        end
    },

    -----------------------------------------------------------------

    -- Reference: https://github.com/skywind3000/asyncrun.vim
    {
        "skywind3000/asyncrun.vim",
        event = "VeryLazy",
        cmd = "AsyncRun",
        dependencies = {
            "skywind3000/asynctasks.vim",
            "preservim/vimux",
        },
    },

    -- Reference: https://github.com/MattesGroeger/vim-bookmarks
    {
        "MattesGroeger/vim-bookmarks",
        event = "VeryLazy",
    },

    -- Reference: https://github.com/akinsho/bufferline.nvim
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup({
            })
        end
    },

    -- Reference: https://github.com/google/vim-codefmt
    {
        "google/vim-maktaba",
        lazy = true,
    },
    {
        "google/vim-glaive",
        lazy = true,
        dependencies = {
            "google/vim-maktaba",
        },
    },
    {
        "google/vim-codefmt",
        -- lazy = true,
        dependencies = {
            "google/vim-glaive",
        },
        config = function()
            vim.cmd([[
                call glaive#Install()
                " TODO: move Glaive configuration here and enable 'lazy = true' above
            ]])
        end
    },

    -- Reference: https://github.com/dhananjaylatkar/cscope_maps.nvim
    {
        "dhananjaylatkar/cscope_maps.nvim",
        event = "VeryLazy",
        dependencies = {
            "which-key.nvim",
        },
        config = function()
            require("cscope_maps").setup({
                use_telescope = true,
            })
        end
    },

    -- Reference: https://github.com/theHamsta/nvim-dap-virtual-text
    {
        "theHamsta/nvim-dap-virtual-text",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-dap-virtual-text").setup({
            })
        end
    },

    -- Reference: https://github.com/nvim-telescope/telescope-dap.nvim
    {
        "nvim-telescope/telescope-dap.nvim",
        event = "VeryLazy",
        cmd = "Telescope dap",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
            "folke/which-key.nvim",
        },
    },

    -- Reference: https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
    {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        event = "VeryLazy",
        cmd = { "ToggleDiag", "ToggleDiagDefault", "ToggleDiagOn", "ToggleDiagOff", },
        config = function()
            require("toggle_lsp_diagnostics").init({
                start_on = true, -- Toggle diagnostics on or off on start
            })
        end
    },

    -- Reference: https://github.com/tpope/vim-fugitive
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        cmd = { "Git", "G" },
    },

    -- Reference: https://github.com/tpope/vim-fugitive
    {
        "junegunn/fzf.vim",
        event = "VeryLazy",
        cmd = { "Files", "GFiles", "Buffers", "Colors", "Rg", "Lines", "BLines", "Tags", "BTags", "Marks", "Windows",
            "Locate", "History", "Snippets", "Commits", "BCommits", "Commands", "Maps", "Helptags", "Filetypes" },
    },

    -- Reference: https://github.com/williamboman/mason-lspconfig.nvim
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason").setup({
            })
            require("mason-lspconfig").setup({
            })
            -- LSP: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            require("lspconfig").clangd.setup({})
            require("lspconfig").vimls.setup({})
            require("lspconfig").lua_ls.setup({})
            require("lspconfig").pyright.setup({})
            require("lspconfig").bashls.setup({})
        end
    },

    -- Reference: https://github.com/jay-babu/mason-nvim-dap.nvim
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-nvim-dap").setup({
                -- See: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
                ensure_installed = { "python", "cppdbg" }
            })
        end
    },

    -- Reference: https://github.com/williamboman/mason-lspconfig.nvim
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
            })
            -- LSP: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            require("lspconfig").clangd.setup({})
            require("lspconfig").vimls.setup({})
            require("lspconfig").lua_ls.setup({})
            require("lspconfig").pyright.setup({})
            require("lspconfig").bashls.setup({})
            require("lspconfig").marksman.setup({})
        end
    },

    -- Reference: https://github.com/ethanholz/nvim-lastplace
    {
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup({
            })
        end
    },

    -- Reference: https://github.com/folke/noice.nvim
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("notify").setup({
                background_colour = require("onedark.colors").bg0,
            })
            require("noice").setup({
                cmdline = {
                    view = "cmdline",
                    enable = false,
                },
                messages = {
                    enable = false,
                },
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end
    },

    -- Reference: https://github.com/gbprod/airblade/vim-rooter
    {
        "airblade/vim-rooter",
        event = "VeryLazy",
    },

    -- Reference: https://github.com/SirVer/ultisnips
    {
        "honza/vim-snippets",
        event = "VeryLazy",
        dependencies = {
            "SirVer/ultisnips",
        },
    },

    -- Reference: https://github.com/gbprod/substitute.nvim
    {
        "gbprod/substitute.nvim",
        lazy = true,
        config = function()
            require("substitute").setup({
            })
        end
    },

    -- Reference: https://github.com/gbprod/christoomey/vim-tmux-navigator
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },

    -- Reference: https://github.com/folke/todo-comments.nvim
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("todo-comments").setup({
            })
        end
    },

    -- Reference: https://github.com/kylechui/nvim-surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    },

    -- Reference: https://github.com/folke/trouble.nvim
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        config = function()
            local actions = require("telescope.actions")
            local trouble = require("trouble.providers.telescope")
            local telescope = require("telescope")
            telescope.setup {
                defaults = {
                    mappings = {
                        i = { ["<c-t>"] = trouble.open_with_trouble },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
                    },
                },
            }
        end
    },

    -- Reference: https://github.com/dstein64/vim-startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },

    -- Reference: https://github.com/gelguy/wilder.nvim
    {
        "gelguy/wilder.nvim",
        event = { "VeryLazy", "CmdlineEnter" },
        dependencies = {
            "romgrk/fzy-lua-native",
        },
        config = function()
            local wilder = require('wilder')
            wilder.setup({ modes = { ':', '/', '?' } })

            wilder.set_option('pipeline', {
                wilder.branch(
                    wilder.python_file_finder_pipeline({
                        file_command = { 'rg', '--files' },
                        dir_command = { 'fd', '-td' },
                        filters = { 'fuzzy_filter', 'difflib_sorter' },
                    }),
                    wilder.substitute_pipeline({
                        pipeline = wilder.python_search_pipeline({
                            skip_cmdtype_check = 1,
                            pattern = wilder.python_fuzzy_pattern({
                                start_at_boundary = 0,
                            }),
                        }),
                    }),
                    wilder.cmdline_pipeline({
                        fuzzy = 2,
                        fuzzy_filter = wilder.lua_fzy_filter(),
                    }),
                    {
                        wilder.check(function(ctx, x) return x == '' end),
                        wilder.history(),
                    },
                    wilder.python_search_pipeline({
                        pattern = wilder.python_fuzzy_pattern({
                            start_at_boundary = 0,
                        }),
                    })
                ),
            })

            local highlighters = {
                wilder.pcre2_highlighter(),
                wilder.lua_fzy_highlighter(),
            }

            local popupmenu_renderer = wilder.popupmenu_renderer(
                wilder.popupmenu_border_theme({
                    border = 'rounded',
                    winblend = 20,
                    empty_message = wilder.popupmenu_empty_message_with_spinner(),
                    highlighter = highlighters,
                    left = {
                        ' ',
                        wilder.popupmenu_devicons(),
                        wilder.popupmenu_buffer_flags({
                            flags = ' a + ',
                            icons = { ['+'] = '', a = '', h = '' },
                        }),
                    },
                    right = {
                        ' ',
                        wilder.popupmenu_scrollbar(),
                    },
                })
            )

            local wildmenu_renderer = wilder.wildmenu_renderer({
                highlighter = highlighters,
                separator = ' · ',
                left = { ' ', wilder.wildmenu_spinner(), ' ' },
                right = { ' ', wilder.wildmenu_index() },
            })

            wilder.set_option('renderer', wilder.renderer_mux({
                [':'] = popupmenu_renderer,
                ['/'] = wildmenu_renderer,
                substitute = wildmenu_renderer,
            }))
        end
    },

    -- Reference: https://github.com/gbprod/yanky.nvim
    {
        "gbprod/yanky.nvim",
        event = "VeryLazy",
        cmd = "Telescope yank_history",
        config = function()
            require("yanky").setup({
            })
            require("telescope").load_extension("yank_history")
        end
    },

    -- Reference: https://github.com/folke/zen-mode.nvim
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        cmd = "ZenMode",
        config = function()
            require("zen-mode").setup({
            })
        end
    },

    -- Reference: https://github.com/ludovicchabant/vim-gutentags
    {
        "ludovicchabant/vim-gutentags",
        event = "VeryLazy",
    },
}

-- specify the python3 we use as nvim python
-- Alternative: set NVIM_PY3_PATH in shellrc and use os.getenv("NVIM_PY3_PATH") to get
local python3_host_prog_handle = io.popen("which python3")
if (python3_host_prog_handle) then
    vim.g.python_host_prog = python3_host_prog_handle:read("*a")
    python3_host_prog_handle:close()
end

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
