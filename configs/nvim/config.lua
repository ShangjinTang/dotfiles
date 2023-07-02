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

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "catppuccin"
lvim.transparent_window = os.getenv("TERMINAL_TRANSPARENT")

vim.opt.background = os.getenv("TERMINAL_THEME")

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

local lualine_components = require("lvim.core.lualine.components")
lvim.builtin.lualine = {
    style = 'lvim',
    options = {
        section_separators = {
            left = lvim.icons.ui.BoldDividerRight,
            right = lvim.icons.ui.BoldDividerLeft,
        },
        component_separators = {
            -- left = lvim.icons.ui.DividerRight,
            -- right = lvim.icons.ui.DividerLeft,
        },
    },
    sections = {
        lualine_a = {
            "mode"
        },
        lualine_b = {
            lualine_components.treesitter,
            { "filename", path = 1 },
        },
        lualine_c = {
            lualine_components.branch,
            lualine_components.diff,
        },
        lualine_x = {
            lualine_components.diagnostics,
            lualine_components.lsp,
        },
        lualine_y = {
            lualine_components.filetype,
        },
        lualine_z = {
            "progress",
            -- lualine_components.progress,
            -- lualine_components.location,
        },
    },
}

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "css",
    "cuda",
    "diff",
    "dockerfile",
    "git_config",
    "gitcommit",
    "gitignore",
    "html",
    "ini",
    "java",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "meson",
    "ninja",
    "norg",
    "regex",
    "rust",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
}

-- -- generic LSP settings <https://www.lunarvim.org/docs/configuration/language-features/language-servers>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
-- LSP: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Core Programming Lanugages

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

    -- Reference: https://github.com/navarasu/onedark.nvim
    -- {
    --     "navarasu/onedark.nvim",
    --     priority = 1000,
    --     dependencies = {
    --         "nvim-lualine/lualine.nvim",
    --     },
    --     config = function()
    --         require("onedark").setup({
    --             style = os.getenv("TERMINAL_THEME"),
    --             transparent = os.getenv("TERMINAL_TRANSPARENT"),
    --             lualine = {
    --                 transparent = os.getenv("TERMINAL_TRANSPARENT"),
    --             },
    --         })
    --         require('lualine').setup {
    --             options = {
    --                 theme = 'onedark',
    --             },
    --         }
    --         require("notify").setup({
    --             background_colour = require("onedark.colors").bg0,
    --         })
    --         require("which-key").setup({
    --             window = {
    --                 border = "single",
    --                 winblend = 20,
    --             },
    --         })
    --         require('onedark').load()
    --     end
    -- },

    -- Reference: https://github.com/catppuccin/nvim
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        dependencies = {
            "nvim-lualine/lualine.nvim",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            require("notify").setup({
                background_colour = require("catppuccin.palettes.frappe").base,
            })
            require("dap")
            local sign = vim.fn.sign_define
            sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
            local bufferline = require("lvim.core.bufferline")
            bufferline.setup {
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
            }
            require('lualine').setup {
                options = {
                    theme = "catppuccin"
                }
            }
            require("catppuccin").setup({
                flavour = "frappe", -- latte, frappe, macchiato, mocha
                background = {
                    -- :h background
                    light = "latte",
                    dark = "frappe",
                },
                transparent_background = os.getenv("TERMINAL_TRANSPARENT"),
                show_end_of_buffer = false, -- show the '~' characters after the end of buffers
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = false, -- Force no italic
                no_bold = false,   -- Force no bold
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    notify = true,
                    mini = false,
                    dap = {
                        enabled = true,
                        enable_ui = true, -- enable nvim-dap-ui
                    }
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                navic = {
                    enabled = true,
                    custom_bg = "NONE",
                },
            })
        end
    },

    -----------------------------------------------------------------

    -- Reference: https://github.com/windwp/nvim-ts-autotag
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup {
            }
        end
    },

    -- Reference: https://github.com/skywind3000/asyncrun.vim
    {
        "skywind3000/asyncrun.vim",
        event = "VeryLazy",
        cmd = "AsyncRun",
        dependencies = {
            "preservim/vimux",
        },
    },

    -- Reference: https://github.com/skywind3000/asynctasks.vim
    {
        "skywind3000/asynctasks.vim",
        event = "VeryLazy",
        cmd = { "AsyncTask", "AsyncTaskList", "AsyncTaskLast", "AsyncTaskEdit", "AsyncTaskMacro", "AsyncTaskEnviron",
            "AsyncTaskProfile" },
        dependencies = {
            "skywind3000/asyncrun.vim",
        },
    },

    -- Reference: https://github.com/GustavoKatel/telescope-asynctasks.nvim
    {
        "GustavoKatel/telescope-asynctasks.nvim",
        event = "VeryLazy",
        dependencies = {
            "skywind3000/asynctasks.vim",
        },
    },

    -- Reference: https://github.com/MattesGroeger/vim-bookmarks
    {
        "MattesGroeger/vim-bookmarks",
        event = "VeryLazy",
    },

    -- Reference: https://github.com/jackMort/ChatGPT.nvim
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "echo -n $OPENAI_API_KEY",
                chat = {
                    popup_input = {
                        submit = "<C-Enter>",
                    }
                },
                openai_params = {
                    model = "gpt-3.5-turbo",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    max_tokens = 2048,
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                },
            })
        end
    },

    -- Reference: https://github.com/sindrets/diffview.nvim
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    },

    -- Reference: https://github.com/norcalli/nvim-colorizer.lua
    {
        "norcalli/nvim-colorizer.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('colorizer').setup {
                'css',
                'javascript',
                'html',
                'tmux',
                'yaml',
                'zsh',
            }
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

    -- Reference: https://github.com/zbirenbaum/copilot-cmp
    {
        "zbirenbaum/copilot-cmp",
        dependencies = {
            "zbirenbaum/copilot.lua",
        },
        event = "VeryLazy",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    -- Reference: https://github.com/zbirenbaum/copilot.lua
    -- Note: Use `:Copilot auth` to authenticate
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup()
        end
    },

    -- Reference: https://github.com/iamcco/markdown-preview.nvim
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        event = "VeryLazy",
        config = function()
            vim.fn["mkdp#util#install"]()
        end
    },

    -- Reference: https://github.com/dhruvasagar/vim-table-mode
    {
        "dhruvasagar/vim-table-mode",
        ft = "markdown",
        event = "VeryLazy",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.cmd([[ call tablemode#Enable() ]])
                end,
            })
        end
    },

    -- Reference: https://github.com/AckslD/nvim-FeMaco.lua
    {
        "AckslD/nvim-FeMaco.lua",
        ft = { "markdown", "norg" },
        event = "VeryLazy",
        config = function()
            require("femaco").setup({
                post_open_float = function(winnr)
                    vim.cmd([[ set number ]])
                    vim.cmd([[ set norelativenumber ]])
                end,
                ensure_newline = function(base_filetype)
                    return true
                end,
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

    -- Reference: https://github.com/folke/flash.nvim
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Reference: https://github.com/williamboman/mason-lspconfig.nvim
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason").setup({
            })
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "cmake", -- requires 'sudo apt install python3-venv on Ubuntu'
                    "pyright",
                    "bashls",
                    "html",
                    "rust_analyzer",
                    "lua_ls",
                    "vimls",
                    "marksman",
                },
            })
        end
    },

    -- Reference: https://github.com/nvim-neorg/neorg
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            vim.cmd([[ set conceallevel=2 ]])
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                        }
                    },
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                note = "~/norg/note",
                            },
                            default_workspace = "note",
                            use_popup = false,
                        },
                    },
                    ["core.export"] = {},
                    ["core.qol.todo_items"] = {
                        config = {
                            order = {
                                { "undone",    " " },
                                { "pending",   "-" },
                                { "done",      "x" },
                                { "on_hold",   "=" },
                                { "important", "!" },
                            },
                        },
                    },
                },
            }
        end
    },

    -- Reference: https://github.com/SmiteshP/nvim-navic
    {
        "SmiteshP/nvim-navic",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },

    -- Reference: https://github.com/williamboman/mason-lspconfig.nvim
    {
        "simrat39/rust-tools.nvim",
        event = "VeryLazy",
        ft = "rust",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("rust-tools").setup({})
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
                    inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true,        -- add a border to hover docs and signature help
                },
            })
        end
    },

    -- Reference: https://github.com/nvim-pack/nvim-spectre
    {
        "nvim-pack/nvim-spectre",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("spectre").setup({
                live_update = true,
                default = {
                    find = {
                        cmd = "rg",
                        options = {},
                    },
                    replace = {
                        cmd = "sed",
                    },
                },
            })
        end
    },

    -- Reference: https://github.com/airblade/vim-rooter
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

    -- Reference: https://github.com/simrat39/symbols-outline.nvim
    {
        -- "simrat39/symbols-outline.nvim",
        'enddeadroyal/symbols-outline.nvim',
        branch = 'bugfix/symbol-hover-misplacement',
        event = "VeryLazy",
        config = function()
            require("symbols-outline").setup({
            })
        end
    },

    -- Reference: https://github.com/christoomey/vim-tmux-navigator
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


    -- Reference: https://github.com/renerocksai/telekasten.nvim
    {
        "renerocksai/telekasten.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "renerocksai/calendar-vim",
        },
        config = function()
            require("telekasten").setup({
                home = vim.fn.expand("~/note/")
            })
        end
    },

    -- Reference: https://github.com/nvim-neotest/neotest
    {
        "nvim-neotest/neotest",
        event = "VeryLazy",
        ft = "python",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "folke/neodev.nvim",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                    }),
                },
            })
            require("neodev").setup({
                library = { plugins = { "neotest" }, types = true },
            })
        end
    },

    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("treesitter-context").setup({
            })
        end
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

    {
        "AckslD/nvim-neoclip.lua",
        event = "VeryLazy",
        dependencies = {
            { 'kkharji/sqlite.lua',           module = 'sqlite' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            local function is_whitespace(line)
                return vim.fn.match(line, [[^\s*$]]) ~= -1
            end
            local function all(tbl, check)
                for _, entry in ipairs(tbl) do
                    if not check(entry) then
                        return false
                    end
                end
                return true
            end
            require('neoclip').setup({
                history = 10000,
                enable_persistent_history = true,
                continuous_sync = true,
                on_select = {
                    move_to_front = true,
                },
                on_paste = {
                    move_to_front = true,
                },
                on_replay = {
                    move_to_front = true,
                },
                filter = function(data)
                    return not all(data.event.regcontents, is_whitespace)
                end,
            })
        end,
    },

    -- Reference: https://github.com/ojroques/nvim-osc52
    {
        "ojroques/nvim-osc52",
        event = "VeryLazy",
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

local navic = require("nvim-navic")
local lsp_on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end
local lspconfig = require("lspconfig")
lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--limit-results=100",
        "--suggest-missing-includes",
        "-j=12",
        "--pch-storage=memory",
        "--offset-encoding=utf-16", -- Fix "warning: multiple different client offset_encodings detected" when using clangd with copilot
    },
    on_attach = lsp_on_attach,
}
lspconfig.cmake.setup({ -- requires: pip3 install cmake-language-server
    on_attach = lsp_on_attach,
})
lspconfig.pyright.setup({
    on_attach = lsp_on_attach,
})
lspconfig.bashls.setup({
    on_attach = lsp_on_attach,
})
lspconfig.rust_analyzer.setup({
    on_attach = lsp_on_attach,
})
-- NVIM / VIM
lspconfig.lua_ls.setup({
    on_attach = lsp_on_attach,
})
lspconfig.vimls.setup({
    on_attach = lsp_on_attach,
})
-- HTML / CSS / JavaScript
lspconfig.html.setup({
    on_attach = lsp_on_attach,
})
-- Markup Languages
lspconfig.marksman.setup({
    on_attach = lsp_on_attach,
})

-- specify the python3 we use as nvim python
vim.g.python3_host_prog = os.getenv("PYTHON3_HOST_PROG")



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>

-- let treesitter use bash highlight for zsh files as well
vim.api.nvim_create_autocmd("FileType", {
    pattern = "zsh",
    callback = function()
        require("nvim-treesitter.highlight").attach(0, "bash")
    end,
})

-- set filetype ini for .tasks (by asynctasks.vim)
vim.api.nvim_create_autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = ".tasks",
        callback = function()
            vim.cmd([[ set filetype=ini ]])
        end,
    }
)

vim.api.nvim_create_autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = ".tmux.conf*",
        callback = function()
            vim.cmd([[ set filetype=tmux ]])
        end,
    }
)

vim.api.nvim_create_autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = ".gitmux.conf*",
        callback = function()
            vim.cmd([[ set filetype=yaml ]])
        end,
    }
)

--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd(
    {
        "InsertEnter",
    },
    {
        callback = function()
            vim.cmd([[ set nonumber ]])
            vim.cmd([[ set norelativenumber ]])
        end,
    }
)

vim.api.nvim_create_autocmd(
    {
        "InsertLeave",
    },
    {
        callback = function()
            vim.cmd([[ set number ]])
            vim.cmd([[ set relativenumber ]])
        end,
    }
)

--------------------------------------------------------------------------------
