local dap = require('dap')

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.expand('~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'),
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
}
