local function dap_config()
    local dap = require('dap')

    -- Async wrapper
    local run = dap.run
    dap.run = function(...)
        local args = vim.F.pack_len(...)
        coroutine.resume(
            coroutine.create(function() run(vim.F.unpack_len(args)) end)
        )
    end

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
                local coro = assert(coroutine.running())

                local cwd = vim.fn.getcwd()
                local build = '/build/debug/'

                vim.schedule(function()
                    vim.ui.input({
                        prompt = 'Executable: ',
                        default = build,
                        completion = 'file',
                    }, function(input)
                        coroutine.resume(coro, input)
                    end)
                end)

                local result = coroutine.yield()

                if vim.fn.executable(result) == 1 then
                    return cwd .. result
                elseif vim.fn.executable(build .. result) == 1 then
                    return cwd .. build .. result
                else
                    return result
                end
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

    -------------------------------- C/C++/Rust --------------------------------
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
