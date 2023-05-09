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
lvim.transparent_window = true

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

-- Additional Plugins <https://www.lunarvim.org/docs/configuration/plugins/user-plugins>
lvim.plugins = {
    
    -- Themes
    {
        "navarasu/onedark.nvim",
        dependencies = {
            "nvim-lualine/lualine.nvim",
        },
        config = function()
            require("onedark").setup({
            })
            require('lualine').setup {
                options = {
                  theme = 'onedark'
                }
            }
            require('onedark').load()
        end
    },
    {
        "shaunsingh/nord.nvim",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "nvim-lualine/lualine.nvim",
            "akinsho/bufferline.nvim",
        },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'nord'
                }
            })
            local highlights = require("nord").bufferline.highlights({
                italic = true,
                bold = true,
            })
            require("bufferline").setup({
                options = {
                    separator_style = "thin",
                },
                highlights = highlights,
            })
        end
    },

    -----------------------------------------------------------------

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

    -- Reference: https://github.com/dhananjaylatkar/cscope_maps.nvim
    {
        "dhananjaylatkar/cscope_maps.nvim",
        lazy = true,
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

    -- Reference: https://github.com/ethanholz/nvim-lastplace
    {
        "ethanholz/nvim-lastplace",
        lazy = false,
        config = function()
            require("cscope_maps").setup({
            })
        end
    },

    -- Reference: https://github.com/folke/noice.nvim
    {
        "folke/noice.nvim",
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("notify").setup({
                background_colour = "#282A36"
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
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = false, -- position the cmdline and popupmenu together
                    long_message_to_split = false, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end
    },

    -- Reference: https://github.com/gbprod/substitute.nvim
    {
        "gbprod/substitute.nvim",
        lazy = true,
        config = function()
            require("substitute").setup({
            })
            vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
            vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
            vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
            vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })
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
        lazy = true,
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
        lazy = true,
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
        lazy = true,
        event = "VeryLazy",
        cmd = "ZenMode",
        config = function()
            require("zen-mode").setup({
            })
        end
    },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
