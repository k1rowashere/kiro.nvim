local function dap_config()
    local dap = require('dap')

    -------------------------------- C/C++/Rust --------------------------------
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '/home/kirowashere/.local/share/nvim/mason/bin/OpenDebugAD7',
    }

    dap.configurations.cpp = {
        {
            name = 'Launch file',
            type = 'cppdbg',
            request = 'launch',
            program = function()
                return vim.fn.input({
                    promt = 'Path to executable: ',
                    default = vim.fn.getcwd() .. '/',
                    completion = 'file',
                })
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false,
                },
            },
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end

return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        config = dap_config,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        lazy = true,
        main = 'dapui',
        opts = {},
    },
}
