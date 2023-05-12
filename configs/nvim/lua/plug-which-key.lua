-- Reference: https://github.com/folke/which-key.nvim

local wk = require("which-key")

-- <C-a> is already registered as "Toggle Terminal" in LunarVim terminal.lua

wk.register({
    ["s"] = { require('substitute').operator, "Substitute Operator" },
    ["ss"] = { require('substitute').line, "Substitute Line" },
    ["S"] = { require('substitute').eol, "Substitute to End of Line" },
})
wk.register({
        ["s"] = { require('substitute').operator, "Substitute Operator" },
    },
    { mode = "v" }
)

wk.register({
    ["<leader>y"] = { "<cmd>Telescope yank_history<cr>", "Yank History" },

    ["<C-p>"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
    ["K"] = { vim.lsp.buf.hover, "Hover" },
    ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
    ["gi"] = { "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation" },
    ["gt"] = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", "Goto References" },

    ["<leader>["] = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer" },
    ["<leader>]"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
    ["<leader><tab>"] = { "<cmd>b#<cr>", "Switch between buffers" },
    ["<leader>q"] = { "<cmd>qa!<cr>", "Force Quit" },
    ["<leader>z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },

    ["<leader>a"] = { name = "+AsyncRun" },
    -- FIXME: this cannot work as <cmd> should end with <>
    ["<leader>as"] = { "<cmd>call AsyncRunWith('')<left><left>", "Asyncrun Command" },
    ["<leader>aq"] = { "<cmd>VimuxCloseRunner<cr>", "Quit Asyncrun Window" },

    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },

    ["<leader>f"] = { name = "+File" },
    ["<leader>ff"] = { "<cmd>Telescope find_files previewer=false<cr>", "Find File" },
    ["<leader>fw"] = { "<cmd>Telescope grep_string<cr>", "File Grep Current Word" },
    ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "File Live Grep" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles previewer=true<cr>", "Open Recent File" },
    ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },

    ["<leader>d"] = { name = "+Dap" },
    -- mostly follow gdb/ldb mappings
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "b(reakpoint)" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "c(ontinue)" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "run to cursor" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.step_into()<cr>", "s(tep) [step into]" },
    ["<leader>dn"] = { "<cmd>lua require'dap'.step_over()<cr>", "n(ext) [step over]" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "finish [step out]" },
    -- DapUI
    ["<leader>dd"] = { function()
        require 'dap'.disconnect()
        require 'dapui'.toggle({ reset = true })
    end, "Disconnect" },
    ["<leader>du"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle Dap UI" },
    -- Dap + Telescope
    ["<leader>dl"] = { function() require 'telescope'.extensions.dap.list_breakpoints {} end, "Dap list breakpoints" },
    ["<leader>dv"] = { function() require 'telescope'.extensions.dap.variables {} end, "Dap variables" },
    ["<leader>df"] = { function() require 'telescope'.extensions.dap.frames {} end, "Dap frames" },
    ["<leader>D"] = { function() require 'telescope'.extensions.dap.commands {} end, "Dap commands" },

    ["<leader>gf"] = {
        function()
            require("lvim.core.telescope.custom-finders").find_project_files { previewer = false }
        end,
        "Find Git File",
    },

    ["<leader>ld"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Buffer Diagnostics" },
    ["<leader>lD"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },

    ["<leader>o"] = { name = "+Open with" },
    ["<leader>oc"] = { "<cmd>call OpenCurrentFileWith('code')<cr>", "Open with VsCode" },

    ["<leader>p"] = { name = "+Project" },
    ["<leader>pp"] = { "<cmd>Telescope projects<cr>", "Recent Projects" },
    ["<leader>pf"] = {
        function()
            require("telescope.builtin").find_files({ cwd = vim.api.nvim_eval('FindRootDirectory()') })
        end,
        "Find Project File",
    },
    ["<leader>pw"] = {
        function()
            require("telescope.builtin").grep_string({ cwd = vim.api.nvim_eval('FindRootDirectory()') })
        end,
        "Project Grep Current Word",
    },
    ["<leader>pg"] = {
        function()
            require("telescope.builtin").live_grep({ cwd = vim.api.nvim_eval('FindRootDirectory()') })
        end,
        "Project Live Grep",
    },

    ["<leader>w"] = { name = "+word" },
    ["<leader>ws"] = { name = "word substitute from current selection" },
    ["<leader>wS"] = { name = "word substitute from first line" },
})
