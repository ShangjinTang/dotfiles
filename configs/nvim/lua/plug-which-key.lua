-- Reference: https://github.com/folke/which-key.nvim

local wk = require("which-key")

wk.register({
    ["<leader>["] = { "<cmd>bp<cr>", "Previous Buffer" },
    ["<leader>]"] = { "<cmd>bn<cr>", "Next Buffer" },
    ["<leader><tab>"] = { "<cmd>b#<cr>", "Switch between last buffer & current buffer" },
    ["<leader>h"] = { "<cmd>Helptags<cr>", "Vim Helptags" },
    ["<leader>q"] = { "<cmd>qa!<cr>", "Force Quit" },
    ["<leader>w"] = { "<cmd>bd<cr>", "Close Buffer" },
    ["<leader>y"] = { "<cmd>CocList -A --normal yank<cr>", "Yank History" },
    ["<leader>z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
})

-- wk.register({
--     ["<leader>a"] = { name = "+asyncrun" },
--     ["<leader>as"] = { "<cmd><cr>", "Find File" },
--     ["<leader>aq"] = { "<cmd><cr>", "Asyncrun Command" },
--     ["<leader>fn"] = { "<cmd><cr>", "Quit Asyncrun" },
-- })

wk.register({
    ["<leader>b"] = { name = "+buffer" },
    ["<leader>bb"] = { "<cmd>Telescope buffers<cr>", "Switch to Another Buffer" },
    ["<leader>bd"] = { "<cmd>bd<cr>", "Delete Buffer" },
    ["<leader>bf"] = { "<cmd>bf<cr>", "First Buffer" },
    ["<leader>bl"] = { "<cmd>bl<cr>", "Last Buffer" },
    -- ["<leader>bp"] = { "<cmd>bp<cr>", "Previous Buffer" },
    -- ["<leader>bn"] = { "<cmd>bn<cr>", "Next Buffer" },
    ["<leader>bs"] = { "<cmd>Lines<cr>", "Search in Buffers" },
    ["<leader>bt"] = { "<cmd>BTags<cr>", "Search Tag in Current Buffer" },
})

wk.register({
    ["<leader>c"] = { name = "+coc.nvim" },
    ["<leader>ca"] = { "<cmd>bp<cr>", "Coc Code Action" },
    ["<leader>cc"] = { "<cmd>bn<cr>", "CocList commands" },
    ["<leader>cd"] = { "<cmd>bf<cr>", "CocList diagnostics" },
    ["<leader>ce"] = { "<cmd>bl<cr>", "CocList extensions" },
    ["<leader>cf"] = { "<cmd>bp<cr>", "Coc Fix Current Selection" },
    ["<leader>cj"] = { "<cmd>bn<cr>", "Coc Jump to Definition" },
    ["<leader>cn"] = { "<cmd>Lines<cr>", "CocNext" },
    ["<leader>co"] = { "<cmd>Lines<cr>", "CocList Outline" },
    ["<leader>cp"] = { "<cmd>Lines<cr>", "CocPrev" },
    ["<leader>cr"] = { "<cmd>BTags<cr>", "Reformat" },
    ["<leader>cs"] = { "<cmd>BTags<cr>", "Rename Symbol" },
})

wk.register({
    ["<leader>f"] = { name = "+file" },
    ["<leader>fg"] = { "<cmd>Rg<cr>", "File Grep" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
})

wk.register({
    ["<leader>o"] = { name = "+openwith" },
    -- ["<leader>oc"] = { "<cmd>Rg<cr>", "Open with code" },
})
