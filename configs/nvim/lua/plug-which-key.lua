-- Reference: https://github.com/folke/which-key.nvim

local wk = require("which-key")

wk.register({
    ["<leader>["] = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer" },
    ["<leader>]"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
    ["<leader><tab>"] = { "<cmd>b#<cr>", "Switch between buffers" },
    ["<leader>q"] = { "<cmd>qa!<cr>", "Force Quit" },
    ["<leader>w"] = { "<cmd>bd<cr>", "Close Buffer" },
    ["<leader>z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
})

wk.register({
    ["<leader>a"] = { name = "+AsyncRun" },
    ["<leader>as"] = { "<cmd>call AsyncRunWith('')<left><left>", "Asyncrun Command" },
    ["<leader>aq"] = { "<cmd>VimuxCloseRunner<cr>", "Quit Asyncrun Window" },
})

wk.register({
  ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
})

wk.register({
    ["<leader>f"] = { name = "+file" },
    ["<leader>ff"] = { "<cmd>Telescope find_files previewer=false<cr>", "Find File" },
    ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "File Grep" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles previewer=true<cr>", "Open Recent File" },
    ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
})

wk.register({
    ["<leader>gf"] = {
        function()
            require("lvim.core.telescope.custom-finders").find_project_files { previewer = false }
        end,
        "Find Git File",
    },
})

wk.register({
    ["<leader>o"] = { name = "+Open with" },
    ["<leader>oc"] = { "<cmd>call OpenCurrentFileWith('code')<cr>", "Open with vscode" },
})

wk.register({
    ["<leader>p"] = { name = "+project" },
    ["<leader>pp"] = { "<cmd>Telescope projects<cr>", "Recent Projects" },
    ["<leader>pf"] = {
        function()
            require("telescope.builtin").find_files({ cwd = vim.api.nvim_eval('FindRootDirectory()') })
        end,
        "Find Project File", },
})
