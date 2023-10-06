--------------------------------------------------------------------------------
-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>

-- let treesitter use bash highlight for zsh files as well
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "zsh",
--     callback = function()
--         require("nvim-treesitter.highlight").attach(0, "bash")
--     end,
-- })

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

if os.getenv("NVIM_SHOW_DIAG_ON_HOVER") == "true" then
    vim.api.nvim_create_autocmd({ "CursorHold", "LspAttach" }, {
        callback = function()
            local diagnostic_serverity_map = {
                error = vim.diagnostic.severity.ERROR,
                warn = vim.diagnostic.severity.WARN,
                info = vim.diagnostic.severity.INFO,
                hint = vim.diagnostic.severity.HINT,
            }
            local severity = diagnostic_serverity_map[os.getenv("NVIM_SHOW_DIAG_ON_HOVER_SERVERITY_MIN")]
            if severity and vim.diagnostic.config().float then
                -- See: https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.open_float()
                vim.diagnostic.open_float({
                    scope = "cursor",
                    severity = { min = severity, max = vim.diagnostic.severity.ERROR },
                    header = "", -- Default: "Diagnostic:"
                    source = true, -- Whether show LSP (e.g. "Pyright: ") at beginning
                    border = "rounded",
                })
            end
        end,
    })
end

--------------------------------------------------------------------------------
