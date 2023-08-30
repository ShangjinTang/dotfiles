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

vim.api.nvim_create_autocmd({ "CursorHold", "LspAttach" }, {
    callback = function()
        if os.getenv("SHOW_LINE_DIAG") == "true" and vim.lsp.buf.server_ready() and vim.diagnostic.config().float then
            -- See: https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.open_float()
            vim.diagnostic.open_float({
                scope = "cursor",
                severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR },
                header = "", -- Default: "Diagnostic:"
                source = true, -- Whether show LSP (e.g. "Pyright: ") at beginning
                border = "rounded",
            })
        end
    end,
})
