return function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require('which-key')
    wk.setup {}
    wk.register({
        ['<leader>'] = {
            f = { name = 'Telescope' },
            t = { 'Toggle Terminal' },
            h = { name = 'Git Hunk' },
            v = { name = 'LSP Tools' },
        },

    })
end
