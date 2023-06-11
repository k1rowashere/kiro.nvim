return function()
    local dap = require('dap')


    -------------------------------- C/C++/Rust --------------------------------
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '/home/kirowashere/.local/share/nvim/mason/bin/OpenDebugAD7',
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input(
                    'Path to executable: ',
                    vim.fn.getcwd() .. '/',
                    'file'
                )
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false
                },
            },
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end
