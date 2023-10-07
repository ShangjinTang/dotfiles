--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
----------------------------------------------------------------------
-- General Settings

-- vim options
-- specify the python3 we use as nvim python
vim.g.python3_host_prog = os.getenv("PYTHON3_HOST_PROG")
-- save "TERMINAL_THEME" ('light' / 'dark')
vim.opt.background = os.getenv("TERMINAL_THEME")

lvim.log.level = "info"
lvim.leader = "space"

-- themes
lvim.transparent_window = os.getenv("TERMINAL_TRANSPARENT")

-- icons
-- lvim.use_icons = false

----------------------------------------------------------------------
-- Simple builtin configs

-- alpha
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- gitsigns: git blame virtual text at current line
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.current_line_blame_formatter =
    "   <abbrev_sha>  <author>, <author_time:%Y-%m-%d> - <summary>"

-- lir: disabled for conflict with oil.nvim
lvim.builtin.lir.active = false

-- nvim-tree

lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.view = {
    adaptive_size = false,
    side = "left",
    width = math.floor(vim.go.columns / 5),
    float = {
        enable = vim.go.columns < 120,
        quit_on_focus_loss = false,
    },
}
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.filters.dotfiles = true

-- project
lvim.builtin.project.manual_mode = false
lvim.builtin.project.silent_chdir = false
lvim.builtin.project.patterns = {
    ".git",
    ".root",
    ".project",
    ".workspace",
    "WORKSPACE",
    "Cargo.toml",
    "compile_commands.json",
    "cscope.out",
}

----------------------------------------------------------------------
-- lualine

local lualine_components = require("lvim.core.lualine.components")
lvim.builtin.lualine = {
    style = "lvim",
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
            -- "mode",
            lualine_components.mode,
        },
        lualine_b = {
            lualine_components.treesitter,
            { "filename", path = 1 },
            { "filetype", icon_only = true },
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
            function()
                return lvim.icons.ui.Project .. " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            end,
        },
        lualine_z = {
            "progress",
        },
    },
}

----------------------------------------------------------------------
-- treesitter

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
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
    "proto",
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

----------------------------------------------------------------------
-- null-ls

-- linters, formatters and code actions <https://www.lunarvim.org/docs/configuration/language-features/linting-and-formatting>
if os.getenv("NVIM_FORMAT_ON_SAVE") == "true" then
    lvim.format_on_save = {
        enabled = true,
        -- pattern = "*.lua",
        timeout = 1000,
    }
else
    lvim.format_on_save.enabled = false
end
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    -- cargo install stylua
    { command = "stylua", filetypes = { "lua" } },
    -- sudo pacman -Sy clang | sudo apt install -y clang-format
    { command = "clang_format", filetypes = { "c", "cpp", "cuda" } },
    -- npm install --global google-java-format
    { command = "google_java_format", extra_args = { "--aosp" }, filetypes = { "java" } },
    -- sudo pacman -Sy python-black | sudo apt install -y black
    { command = "black", filetypes = { "python" } },
    -- pip install isort
    { command = "isort", filetypes = { "python" } },
    -- sudo pacman -Sy shfmt | sudo apt install -y shfmt
    { command = "shfmt", extra_args = { "-sr", "-ci", "-i", "4" }, filetypes = { "sh", "bash" } },
    -- pip install beautysh
    { command = "beautysh", extra_args = { "-i", "4" }, filetypes = { "csh", "ksh", "zsh" } },
    -- rustup component add rustfmt
    { command = "rustfmt", filetypes = { "rust" } },
    -- go install github.com/bazelbuild/buildtools/buildifier@latest | npm install --global @bazel/buildifier
    { command = "buildifier", filetypes = { "bzl" } },
    -- cargo install cbfmt
    { command = "cbfmt", filetypes = { "markdown" } },
    -- npm install --global @bufbuild/buf
    { command = "buf", filetypes = { "proto" } },
    -- pip install cmakelang
    { command = "cmake-format", filetypes = { "cmake" } },
    -- pip install xmlformatter
    { command = "xmlformat", filetypes = { "xml" } },
    -- npm install --global prettier
    {
        command = "prettier",
        -- extra_args = { "--print-width", "120", "tabWidth", "4" },
        extra_args = { "--print-width", "120" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "yaml",
            "markdown",
            "markdown.mdx",
            "graphql",
            "handlebars",
        },
    },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
    -- go install github.com/bazelbuild/buildtools/buildifier@latest | npm install --global @bazel/buildifier
    { command = "buildifier", filetypes = { "bzl" } },
    -- npm install --global @bufbuild/buf
    { command = "buf", filetypes = { "proto" } },
    -- pip install cmakelang
    { command = "cmake-lint", filetypes = { "cmake" } },
    -- npm install --global jsonlint
    { command = "jsonlint", filetypes = { "json" } },
    -- pip install ruff
    { command = "ruff", filetypes = { "python" } },
    -- sudo pacman -Sy shellcheck | sudo apt install -y shellcheck
    { command = "shellcheck", filetypes = { "sh", "bash" }, args = { "--severity", "warning" } },
    -- zsh
    { command = "zsh", filetypes = { "zsh" } },
})

-- local code_actions = require("lvim.lsp.null-ls.code_actions")
-- code_actions.setup({
--     {
--         command = "eslint",
--         filetypes = { "typescript", "typescriptreact" },
--     },
-- })

----------------------------------------------------------------------
-- telescope

-- Telescope window width & height
lvim.builtin.telescope = {
    defaults = {
        layout_config = {
            width = { 0.8, max = 180 },
        },
        layout_strategy = "vertical",
    },
    pickers = {},
}
lvim.lsp.buffer_mappings = {
    normal_mode = {},
    insert_mode = {},
    visual_mode = {},
}

----------------------------------------------------------------------
-- plugins

-- Additional Plugins <https://www.lunarvim.org/docs/configuration/plugins/user-plugins>
lvim.plugins = {

    -- Plugins will be lazy-loaded when one of the following is true:
    --   - The plugin only exists as a dependency in your spec
    --   - It has an 'event', 'cmd', 'ft' or 'keys' key
    --   - Otherwise please specify 'lazy = true'

    -----------------------------------------------------------------
    -- NOTE: theme catppuccin

    -- Reference: https://github.com/catppuccin/nvim
    -- Color Palette: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/frappe.lua
    -- Color API (lua): 'require("catppuccin.palettes").get_palette().<COLOR>'
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        dependencies = {
            "nvim-lualine/lualine.nvim",
        },
        config = function()
            require("catppuccin").setup({
                -- flavour = "frappe", -- latte, frappe, macchiato, mocha
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
                no_bold = false, -- Force no bold
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
                    alpha = true,
                    flash = false,
                    gitsigns = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = false,
                    },
                    nvimtree = true,
                    markdown = true,
                    mason = true,
                    neogit = true,
                    neotest = true,
                    noice = true,
                    cmp = true,
                    dap = {
                        enabled = true,
                        enable_ui = true, -- enable nvim-dap-ui
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
                        inlay_hints = {
                            background = true,
                        },
                    },
                    navic = {
                        enabled = true,
                        custom_bg = "NONE",
                    },
                    notify = true,
                    treesitter_context = true,
                    treesitter = true,
                    overseer = true,
                    symbols_outline = true,
                    telekasten = true,
                    telescope = {
                        enabled = true,
                    },
                    lsp_trouble = true,
                    gitgutter = true,
                    illuminate = true,
                    which_key = true,
                },
            })
            require("notify").setup({
                background_colour = require("catppuccin.palettes").get_palette().base,
            })
            require("lvim.core.bufferline").setup({
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
            })
            lvim.colorscheme = "catppuccin"
            lvim.builtin.lualine.options.theme = "catppuccin"
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: AsyncRun & AsyncTasks

    -- Reference: https://github.com/skywind3000/asyncrun.vim
    {
        "skywind3000/asyncrun.vim",
        cmd = "AsyncRun",
        dependencies = {
            "preservim/vimux",
        },
    },

    -- Reference: https://github.com/skywind3000/asynctasks.vim
    {
        "skywind3000/asynctasks.vim",
        cmd = {
            "AsyncTask",
            "AsyncTaskList",
            "AsyncTaskLast",
            "AsyncTaskEdit",
            "AsyncTaskMacro",
            "AsyncTaskEnviron",
            "AsyncTaskProfile",
        },
        dependencies = {
            "skywind3000/asyncrun.vim",
        },
    },

    -- Reference: https://github.com/GustavoKatel/telescope-asynctasks.nvim
    {
        "GustavoKatel/telescope-asynctasks.nvim",
        lazy = true,
        dependencies = {
            "skywind3000/asynctasks.vim",
        },
    },

    -----------------------------------------------------------------
    -- NOTE: AI tools: ChatGPT & Copilot

    -- Reference: https://github.com/jackMort/ChatGPT.nvim
    -- {
    --     "jackMort/ChatGPT.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     config = function()
    --         require("chatgpt").setup({
    --             api_key_cmd = "echo -n $OPENAI_API_KEY",
    --             openai_params = {
    --                 model = "gpt-3.5-turbo",
    --                 frequency_penalty = 0,
    --                 presence_penalty = 0,
    --                 max_tokens = 2048,
    --                 temperature = 0,
    --                 top_p = 1,
    --                 n = 1,
    --             },
    --         })
    --     end,
    -- },

    -- Reference: https://github.com/dpayne/CodeGPT.nvim
    -- {
    --     "dpayne/CodeGPT.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "MunifTanjim/nui.nvim",
    --     },
    --     config = function()
    --         require("codegpt.config")
    --     end,
    -- },

    -- -- Reference: https://github.com/zbirenbaum/copilot-cmp
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "zbirenbaum/copilot.lua",
    --     },
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end,
    -- },
    -- -- Reference: https://github.com/zbirenbaum/copilot.lua
    -- -- Note: Use `:Copilot auth` to authenticate
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup()
    --     end,
    -- },

    -----------------------------------------------------------------
    -- NOTE: legacy code completion tools

    -- Reference: https://github.com/danymat/neogen
    {
        "danymat/neogen",
        cmd = "Neogen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local neogen = require("neogen")
            neogen.setup({
                snippet_engine = "luasnip",
            })
        end,
    },

    -- Reference: https://github.com/SirVer/ultisnips
    {
        "honza/vim-snippets",
        event = "VeryLazy",
        dependencies = {
            "SirVer/ultisnips",
        },
    },

    -----------------------------------------------------------------
    -- NOTE: file edit enhancement

    -- Reference: https://github.com/monaqa/dial.nvim
    {
        "monaqa/dial.nvim",
        keys = { { "<C-a>" }, { "<C-x>" } },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%m/%d"],
                    augend.date.alias["%H:%M"],
                    augend.constant.alias.bool,
                    -- augend.constant.new({
                    --     elements = { "and", "or" },
                    --     word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                    --     cyclic = true, -- "or" is incremented into "and".
                    -- }),
                    -- augend.constant.new({
                    --     elements = { "&&", "||" },
                    --     word = false,
                    --     cyclic = true,
                    -- }),
                },
            })
            vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
            vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
            vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true })
            vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
            vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
            vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
            vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
            vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
        end,
    },

    -- Reference: https://github.com/nvim-pack/nvim-spectre
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
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
        end,
    },

    -- Reference: https://github.com/kylechui/nvim-surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- Reference: https://github.com/windwp/nvim-ts-autotag
    {
        "windwp/nvim-ts-autotag",
        ft = { "php", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown", "xml" },
        config = function()
            require("nvim-ts-autotag").setup({})
        end,
    },

    -- Reference: https://github.com/gbprod/substitute.nvim
    {
        "gbprod/substitute.nvim",
        event = "VeryLazy",
        config = function()
            require("substitute").setup({})
        end,
    },

    -- Reference: https://github.com/stevearc/oil.nvim
    {
        "stevearc/oil.nvim",
        lazy = false, -- to make "nvim ." work
        config = function()
            require("oil").setup({
                columns = {
                    "icon",
                },
                buf_options = {
                    buflisted = true,
                    bufhidden = "hide",
                },
                default_file_explorer = true,
                keymaps = {
                    ["<CR>"] = "actions.select",
                    ["<BS>"] = "actions.parent",
                    ["<leader>-"] = "actions.select_split",
                    ["<leader>|"] = "actions.select_vsplit",
                    ["<C-t>"] = "actions.select_tab",
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = "actions.close",
                    ["<C-l>"] = "actions.refresh",
                    ["`"] = "actions.cd",
                    ["~"] = "actions.tcd",
                    ["<leader><leader>"] = "actions.open_cwd",
                    ["<leader>?"] = "actions.show_help",
                    ["<leader>."] = "actions.toggle_hidden",
                },
            })
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: file non-edit enhancement: move, highlight, show

    -- Reference: https://github.com/folke/flash.nvim
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        dependencies = {
            { "catppuccin/nvim", name = "catppuccin" },
        },
        config = function()
            require("catppuccin").setup({
                integrations = {
                    flash = true,
                },
            })
        end,
    },

    -- Reference: https://github.com/kevinhwang91/nvim-ufo
    {
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        init = function()
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        config = function(_, opts)
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local totalLines = vim.api.nvim_buf_line_count(0)
                local foldedLines = endLnum - lnum
                local suffix = (" ↙️ %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
                suffix = (" "):rep(rAlignAppndx) .. suffix
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end
            require("ufo").setup({
                fold_virt_text_handler = handler,
                provider_selector = function()
                    return { "treesitter", "indent" }
                end,
            })
        end,
    },

    -- Reference: https://github.com/norcalli/nvim-colorizer.lua
    {
        "norcalli/nvim-colorizer.lua",
        ft = { "css", "javascript", "html", "tmux", "yaml", "zsh", "json", "lua", "markdown" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("colorizer").setup({
                "css",
                "javascript",
                "html",
                "tmux",
                "yaml",
                "zsh",
                "json",
                "lua",
                "markdown",
            })
        end,
    },

    -- Reference: https://github.com/folke/todo-comments.nvim
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("todo-comments").setup({})
        end,
    },

    -- Reference: https://github.com/folke/zen-mode.nvim
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        config = function()
            require("zen-mode").setup({})
        end,
    },

    -- Reference: https://github.com/karb94/neoscroll.nvim
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            require("neoscroll").setup({
                mappings = {
                    "<C-u>",
                    "<C-d>",
                    "<C-b>",
                    "<C-f>",
                    "<C-y>",
                    "<C-e>",
                    "zt",
                    "zz",
                    "zb",
                    -- Add PageUp & PageDown
                    "<PageUp>",
                    "<PageDown>",
                },
            })
            local t = {}
            t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
            t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
            t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
            t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
            t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
            t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
            t["zt"] = { "zt", { "250" } }
            t["zz"] = { "zz", { "250" } }
            t["zb"] = { "zb", { "250" } }
            -- Add PageUp & PageDown
            t["<PageUp>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
            t["<PageDown>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
            require("neoscroll.config").set_mappings(t)
        end,
    },

    -- Reference: https://github.com/petertriho/nvim-scrollbar
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            local palette = require("catppuccin.palettes").get_palette()
            require("scrollbar").setup({
                handle = {
                    blend = 20,
                },
                marks = {
                    Search = { color = palette.base },
                    Error = { color = palette.red },
                    Warn = { color = palette.yellow },
                    Info = { color = palette.blue },
                    Hint = { color = palette.green },
                    Misc = { color = palette.mauve },
                },
            })
        end,
    },

    -- Reference: https://github.com/simrat39/symbols-outline.nvim
    {
        -- "simrat39/symbols-outline.nvim",
        "enddeadroyal/symbols-outline.nvim",
        branch = "bugfix/symbol-hover-misplacement",
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
        event = "VeryLazy",
        config = function()
            require("symbols-outline").setup({})
        end,
    },

    -- Reference: https://github.com/ethanholz/nvim-lastplace
    {
        "ethanholz/nvim-lastplace",
        lazy = false,
        config = function()
            require("nvim-lastplace").setup({})
        end,
    },

    -- Reference: https://github.com/AckslD/nvim-neoclip.lua
    {
        "AckslD/nvim-neoclip.lua",
        event = "VeryLazy",
        dependencies = {
            { "kkharji/sqlite.lua", module = "sqlite" },
            { "nvim-telescope/telescope.nvim" },
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
            require("neoclip").setup({
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

    -- Reference: https://github.com/christoomey/vim-tmux-navigator
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },

    -----------------------------------------------------------------
    -- NOTE: git

    -- Reference: https://github.com/sindrets/diffview.nvim
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
    },

    -- Reference: https://github.com/tpope/vim-fugitive
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },

    -----------------------------------------------------------------
    -- NOTE: markdown

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
                home = vim.fn.expand("~/note/"),
            })
        end,
    },

    -- Reference: https://github.com/jakewvincent/mkdnflow.nvim
    {
        "jakewvincent/mkdnflow.nvim",
        ft = "markdown",
        config = function()
            require("mkdnflow").setup({
                modules = {
                    bib = true,
                    buffers = true,
                    conceal = true,
                    cursor = true,
                    folds = true,
                    links = true,
                    maps = false,
                    lists = true,
                    paths = true,
                    tables = true,
                    yaml = false,
                },
                links = {
                    transform_explicit = function(text)
                        text = text:gsub(" ", "-")
                        text = text:lower()
                        -- text = os.date("%Y-%m-%d_") .. text
                        return text
                    end,
                },
                to_do = {
                    symbols = { " ", "-", "x" },
                    update_parents = true,
                    not_started = " ",
                    in_progress = "-",
                    complete = "x",
                },
            })
        end,
    },

    -- Reference: https://github.com/AckslD/nvim-FeMaco.lua
    {
        "AckslD/nvim-FeMaco.lua",
        ft = { "markdown" },
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
        end,
    },

    -- Reference: https://github.com/iamcco/markdown-preview.nvim
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: C & C++

    -- Reference: https://github.com/jakemason/ouroboros.nvim
    {
        "jakemason/ouroboros",
        ft = { "c", "cpp" },
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -----------------------------------------------------------------
    -- NOTE: mason debuggers, code runners

    -- Reference: https://github.com/jay-babu/mason-nvim-dap.nvim
    {
        "jay-babu/mason-nvim-dap.nvim",
        ft = { "python", "c", "cpp", "rust" },
        dependencies = {
            "williamboman/mason.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            require("mason-nvim-dap").setup({
                -- See: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
                ensure_installed = { "python", "cppdbg", "codelldb" },
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    -- requires: python3 -m pip install debugpy
                    python = function(config)
                        config.adapters = {
                            type = "executable",
                            command = vim.fn["exepath"]("python3"),
                            args = {
                                "-m",
                                "debugpy.adapter",
                            },
                        }
                        require("mason-nvim-dap").default_setup(config) -- don't forget this!
                    end,
                },
            })
            local dap = require("dap")
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
        end,
    },

    -- Reference: https://github.com/theHamsta/nvim-dap-virtual-text
    {
        "theHamsta/nvim-dap-virtual-text",
        ft = { "python", "c", "cpp", "rust" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end,
    },

    -- Reference: https://github.com/nvim-telescope/telescope-dap.nvim
    {
        "nvim-telescope/telescope-dap.nvim",
        ft = { "python", "c", "cpp", "rust" },
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
            "folke/which-key.nvim",
        },
        config = function()
            require("telescope").load_extension("dap")
        end,
    },

    -- Reference: https://github.com/michaelb/sniprun
    {
        "michaelb/sniprun",
        event = "VeryLazy",
        build = "sh ./install.sh 1",
        config = function()
            local palette = require("catppuccin.palettes").get_palette()
            require("sniprun").setup({
                display = {
                    "Classic", --# display results in the command-line  area
                    "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
                    -- "VirtualText", --# display results as virtual text
                    "TempFloatingWindow", --# display results in a floating window
                    -- "LongTempFloatingWindow", --# same as above, but only long results. To use with VirtualText[Ok/Err]
                    -- "Terminal", --# display results in a vertical split
                    -- "TerminalWithCode", --# display results and code history in a vertical split
                    -- "NvimNotify", --# display with the nvim-notify plugin
                    -- "Api"                      --# return output to a programming interface
                },
                snipruncolors = {
                    SniprunVirtualTextOk = { bg = palette.mauve, fg = "#000000" },
                    SniprunFloatingWinOk = { fg = palette.mauve },
                    SniprunVirtualTextErr = { bg = palette.red, fg = "#000000" },
                    SniprunFloatingWinErr = { fg = palette.red },
                },
            })
        end,
    },

    -- Reference: https://github.com/nvim-neotest/neotest
    {
        "nvim-neotest/neotest",
        ft = { "python", "rust" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust",
            "folke/neodev.nvim",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({}),
                    require("neotest-rust")({}),
                },
            })
            require("neodev").setup({
                library = { plugins = { "neotest" }, types = true },
            })
            vim.api.nvim_create_autocmd({
                "BufWrite",
            }, {
                pattern = { "test_*.py", "*_test.py" },
                callback = function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
            })
            vim.api.nvim_create_autocmd({
                "BufWrite",
            }, {
                pattern = { "test_*.rs", "*_test.rs" },
                callback = function()
                    require("neotest").run.run(vim.fn.getcwd())
                end,
            })
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: cscope & ctags

    -- Reference: https://github.com/ludovicchabant/vim-gutentags
    {
        "dhananjaylatkar/vim-gutentags",
        ft = { "c", "cpp", "java" },
        dependencies = {
            "dhananjaylatkar/cscope_maps.nvim",
            "folke/which-key.nvim",
            "nvim-telescope/telescope.nvim",
            -- "ibhagwan/fzf-lua",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.gutentags_modules = { "cscope_maps" } -- This is required. Other config is optional
            vim.g.gutentags_cscope_build_inverted_index_maps = 1
            vim.g.gutentags_file_list_command = "fd -e c -e h -e cpp -e java"
            vim.g.gutentags_cache_dir = tags_dir
            vim.g.gutentags_project_root = {
                ".git",
                ".root",
                ".project",
                ".workspace",
                "WORKSPACE",
                "Cargo.toml",
                "compile_commands.json",
                "cscope.out",
            }
            vim.g.gutentags_ctags_tagfile = ".tags"
            vim.g.gutentags_ctags_extra_args = { "--fields=+niazS", "--extra=+q", "--c++-kinds=+pxI", "--c-kinds=+px" }
            -- vim.g.gutentags_trace = 1
        end,
        config = function()
            require("cscope_maps").setup({
                disable_maps = true,
                skip_input_prompt = true,
                cscope = {
                    db_file = "./cscope.out",
                    exec = "cscope", -- "cscope" or "gtags-cscope"
                    picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
                    skip_picker_for_single_result = false, -- "false" or "true"
                    db_build_cmd_args = { "-Rbqkv" },
                    statusline_indicator = nil,
                },
            })
            local tags_dir = vim.fn.expand("~/.cache/tags")
            if vim.fn.isdirectory(tags_dir) == 0 then
                vim.fn.mkdir(tags_dir, "p")
            end
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: mason LSPs, mason null-ls, treesitter

    -- Reference: https://github.com/williamboman/mason-lspconfig.nvim
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                -- See:
                --   https://github.com/williamboman/mason-lspconfig.nvim/tree/main#available-lsp-servers
                --   https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
                ensure_installed = {
                    "asm_lsp", -- Assembly (GAS/NASM, GO)
                    "bashls", -- Bash
                    "clangd", -- C/C++
                    "cmake", -- CMake
                    "dockerls", -- Docker
                    "docker_compose_language_service", -- Docker Compose
                    "jdtls", -- Java
                    "lua_ls", -- Lua
                    "marksman", -- Markdown
                    "pyright", -- Python
                    "rust_analyzer", -- Rust
                    "taplo", -- TOML
                    "vimls", -- VimL
                    "lemminx", -- XML
                    "yamlls", -- YAML
                    -- FrontEnd
                    "cssls", -- CSS
                    "html", -- HTML
                    "tsserver", -- TypeScript
                },
            })
        end,
    },

    -- Reference: https://github.com/jay-babu/mason-null-ls.nvim
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                -- See: https://mason-registry.dev/registry/list
                ensure_installed = {
                    "tree-sitter-cli",
                    -- Formatters & Linters
                    "buf",
                    "buildifier",
                    "cmakelang",
                    -- Formatters
                    "beautysh",
                    "black",
                    "cbfmt",
                    "clang_format",
                    "google_java_format",
                    "isort",
                    "jsonlint",
                    "prettier",
                    "rustfmt",
                    "shfmt",
                    "stylua",
                    "xmlformatter",
                    -- Linters
                    "ruff",
                    "shellcheck",
                },
            })
        end,
    },

    -- Reference: https://github.com/nvimdev/lspsaga.nvim
    {
        "nvimdev/lspsaga.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            -- See: https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
            require("lspsaga").setup({
                finder = {
                    methods = {
                        tyd = "textDocument/typeDefinition",
                    },
                    keys = {
                        shuttle = "<Tab>",
                        toggle_or_open = "<CR>",
                        vsplit = "|",
                        split = "-",
                        tabe = "+",
                        quit = "q",
                        close = "<C-c>k",
                    },
                },
                definition = {
                    keys = {
                        edit = "<CR>",
                        vsplit = "|",
                        split = "-",
                        tabe = "+",
                        quit = "q",
                        close = "<C-c>k",
                    },
                },
                lightbulb = {
                    enable = true,
                    sign = false,
                },
            })
        end,
    },

    -- Reference: https://github.com/folke/neodev.nvim
    {
        "folke/neodev.nvim",
        ft = "lua",
        config = function()
            require("neodev").setup({})
        end,
    },

    -- Reference: https://github.com/folke/trouble.nvim
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        config = function()
            local actions = require("telescope.actions")
            local trouble = require("trouble.providers.telescope")
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    mappings = {
                        i = { ["<c-t>"] = trouble.open_with_trouble },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
                    },
                },
            })
        end,
    },

    -- Reference: https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
    {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        event = "LspAttach",
        config = function()
            require("toggle_lsp_diagnostics").init({
                start_on = true,
                -- See: https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
                underline = true,
                virtual_text = false,
                update_in_insert = true,
            })
        end,
    },

    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("treesitter-context").setup({})
        end,
    },

    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V", -- linewise
                            ["@class.outer"] = "<c-v>", -- blockwise
                        },
                        include_surrounding_whitespace = true,
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[b"] = "@block.outer",
                            ["[c"] = "@class.outer",
                            ["[["] = { query = "@fold", query_group = "folds", desc = "Prev fold" },
                        },
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]b"] = "@block.outer",
                            ["]c"] = { query = "@class.outer", desc = "Next class start" },
                            ["]["] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[B"] = "@block.outer",
                            ["[C"] = "@class.outer",
                            ["[]"] = { query = "@fold", query_group = "folds", desc = "Prev fold" },
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]B"] = "@block.outer",
                            ["]C"] = "@class.outer",
                            ["]]"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        -- goto_next = {
                        --     ["]d"] = "@conditional.outer",
                        -- },
                        -- goto_previous = {
                        --     ["[d"] = "@conditional.outer",
                        -- },
                    },
                },
            })
        end,
    },

    -- Reference: https://github.com/simrat39/rust-tools.nvim
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = {
            "neovim/nvim-lspconfig",
            -- "nvim-lua/plenary.nvim",
            -- "mfussenegger/nvim-dap",
        },
        config = function()
            require("rust-tools").setup({})
            require("rust-tools").inlay_hints.disable()
        end,
    },

    -- Reference: https://github.com/saecki/crates.nvim
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("crates").setup({})
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: nvim: project management

    -- Reference: https://github.com/junegunn/fzf.vim
    {
        "junegunn/fzf.vim",
        event = "VeryLazy",
        dependencies = {
            "junegunn/fzf",
        },
    },

    -- Reference: https://github.com/MattesGroeger/vim-bookmarks
    {
        "MattesGroeger/vim-bookmarks",
        event = "VeryLazy",
        init = function()
            vim.g.bookmark_no_default_key_mappings = 1
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: nvim: status line & notifications

    -- Reference: https://github.com/folke/noice.nvim
    {
        "folke/noice.nvim",
        lazy = false,
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
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = true, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })
            -- override the lualine configuration
            lvim.builtin.lualine.sections.lualine_a = {
                lualine_components.mode,
                {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                },
            }
        end,
    },

    -- Reference: https://github.com/gelguy/wilder.nvim
    {
        "gelguy/wilder.nvim",
        event = "VeryLazy",
        dependencies = {
            "romgrk/fzy-lua-native",
        },
        config = function()
            local wilder = require("wilder")
            wilder.setup({ modes = { ":", "/", "?" } })

            wilder.set_option("pipeline", {
                wilder.branch(
                    wilder.python_file_finder_pipeline({
                        file_command = { "rg", "--files" },
                        dir_command = { "fd", "-td" },
                        filters = { "fuzzy_filter", "difflib_sorter" },
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
                        wilder.check(function(ctx, x)
                            return x == ""
                        end),
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

            local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                border = "rounded",
                winblend = 20,
                empty_message = wilder.popupmenu_empty_message_with_spinner(),
                highlighter = highlighters,
                left = {
                    " ",
                    wilder.popupmenu_devicons(),
                    wilder.popupmenu_buffer_flags({
                        flags = " a + ",
                        icons = { ["+"] = "", a = "", h = "" },
                    }),
                },
                right = {
                    " ",
                    wilder.popupmenu_scrollbar(),
                },
            }))

            local wildmenu_renderer = wilder.wildmenu_renderer({
                highlighter = highlighters,
                separator = " · ",
                left = { " ", wilder.wildmenu_spinner(), " " },
                right = { " ", wilder.wildmenu_index() },
            })

            wilder.set_option(
                "renderer",
                wilder.renderer_mux({
                    [":"] = popupmenu_renderer,
                    ["/"] = wildmenu_renderer,
                    substitute = wildmenu_renderer,
                })
            )
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: CLI integrations

    -- Reference: https://github.com/jvgrootveld/telescope-zoxide
    {
        "jvgrootveld/telescope-zoxide",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("telescope").load_extension("zoxide")
        end,
    },

    -----------------------------------------------------------------
    -- NOTE: uncategorized

    -- Reference: https://github.com/ojroques/nvim-osc52
    {
        "ojroques/nvim-osc52",
        event = "VeryLazy",
    },

    -- Reference: https://github.com/rafcamlet/nvim-luapad
    {
        "rafcamlet/nvim-luapad",
        cmd = "Luapad",
        config = function()
            require("luapad").setup({})
        end,
    },

    -- Reference: https://github.com/kevinhwang91/nvim-bqf
    {
        "kevinhwang91/nvim-bqf",
        event = "VeryLazy",
        dependencies = {
            "junegunn/fzf",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("bqf").setup({
                preview = {
                    winblend = 0, -- transparent background
                },
            })
        end,
    },

    -- Reference: https://github.com/ThePrimeagen/vim-be-good
    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    },

    -- Reference: https://github.com/stevearc/dressing.nvim
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("dressing").setup({})
        end,
    },

    -- Reference: https://github.com/Shatur/neovim-session-manager
    {
        "Shatur/neovim-session-manager",
        -- Autoload not works if "lazy = true"
        lazy = false,
        config = function()
            local session_manager = require("session_manager")
            local config = require("session_manager.config")
            session_manager.setup({
                sessions_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
                autoload_mode = config.AutoloadMode.CurrentDir, -- [ Disabled / CurrentDir / LastSession ]: autoload when 'nvim' without arguments
                autosave_last_session = true,
                autosave_ignore_not_normal = true,
                autosave_ignore_dirs = {
                    vim.fn.expand("~"),
                },
                autosave_ignore_filetypes = {
                    "alpha",
                    "gitcommit",
                    "gitrebase",
                },
                autosave_ignore_buftypes = {},
                autosave_only_in_session = true,
                max_path_length = 0,
            })
            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "SessionSavePost",
                callback = function()
                    vim.notify("Session Saved")
                end,
            })
            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "SessionLoadPost",
                callback = function()
                    vim.notify("Session Loaded")
                end,
            })
        end,
        init = function()
            vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"
        end,
    },

    -- Reference: https://github.com/Marskey/telescope-sg
    {
        "Marskey/telescope-sg",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ast_grep = {
                        command = {
                            "sg",
                            "--json=stream",
                        },
                        grep_open_files = false,
                        lang = nil,
                    },
                },
            })
            require("telescope").load_extension("ast_grep")
        end,
    },

    -- NOTE: dropbar requires nvim >= 0.10.0
    -- Reference: https://github.com/Bekaboo/dropbar.nvim
    -- {
    --     "Bekaboo/dropbar.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("dropbar").setup({})
    --     end,
    --     init = function()
    --         -- disable breadcrumbs (navic) to solve bar not showing path issue
    --         lvim.builtin.breadcrumbs.active = false
    --     end,
    -- },
}

----------------------------------------------------------------------
-- LSP
-- Note: this section should after section 'lvim.plugins' to resolve dependencies correctly

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
    "clangd",
    "pyright",
    "lua_ls",
    "rust_analyzer", -- disable it as it's already configured in rust-tools.nvim
})

local lspmanager = require("lvim.lsp.manager")

lspmanager.setup("clangd", {
    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "cuda",
        -- "proto",
    },
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
})

lspmanager.setup("pyright", {})

lspmanager.setup("lua_ls", {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
        },
    },
})

-- Manually set server for lvim.lsp.automatic_configuration.skipped_servers:
--   { "markdown", "rst", "plaintext", "toml", "proto" }
lspmanager.setup("marksman", {})
lspmanager.setup("taplo", {})
