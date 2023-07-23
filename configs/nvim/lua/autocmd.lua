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
vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead",
}, {
    pattern = ".tasks",
    callback = function()
        vim.cmd([[ set filetype=ini ]])
    end,
})

vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead",
}, {
    pattern = ".tmux.conf*",
    callback = function()
        vim.cmd([[ set filetype=tmux ]])
    end,
})

vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead",
}, {
    pattern = ".gitmux.conf*",
    callback = function()
        vim.cmd([[ set filetype=yaml ]])
    end,
})

--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd({
    "InsertEnter",
}, {
    callback = function()
        vim.cmd([[ set nonumber ]])
        vim.cmd([[ set norelativenumber ]])
    end,
})

vim.api.nvim_create_autocmd({
    "InsertLeave",
}, {
    callback = function()
        vim.cmd([[ set number ]])
        vim.cmd([[ set relativenumber ]])
    end,
})

--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead",
}, {
    pattern = "*.md",
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
    end,
})

--------------------------------------------------------------------------------
