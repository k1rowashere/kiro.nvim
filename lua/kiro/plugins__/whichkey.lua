return {
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            operators = { gb = 'Comment', gc = 'Comment' },
            window = { border = 'single' },
        },
        config = function(_, opts)
            local wk = require('which-key')
            wk.setup(opts)
            wk.register({
                ['<leader>'] = {
                    f = { name = 'Telescope' },
                    t = { 'Toggle Terminal' },
                    h = { name = 'Git Hunk' },
                },
                ['g'] = {
                    [','] = { 'Toggle end `,`' },
                    [';'] = { 'Toggle end `;`' },
                },
            })
        end,
    },
}
