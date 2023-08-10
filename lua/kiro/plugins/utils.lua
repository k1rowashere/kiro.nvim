return {
    {
        'ThePrimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
        lazy = true,
    },
    {
        'ThePrimeagen/refactoring.nvim',
        opts = {},
    },
    { 'tpope/vim-repeat', lazy = false },
    { 'Darazaki/indent-o-matic', event = 'BufEnter *?' },
    {
        'matze/vim-move',
        keys = {
            { mode = { 'v', 'n' }, '<A-j>' },
            { mode = { 'v', 'n' }, '<A-k>' },
            { mode = { 'v', 'n' }, '<A-h>' },
            { mode = { 'v', 'n' }, '<A-l>' },
        },
    },
    {
        'nvim-focus/focus.nvim',
        event = 'WinEnter',
        init = function()
            local ignore_filetypes = { 'NvimTree', 'undotree' }
            local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

            local augroup =
                vim.api.nvim_create_augroup('FocusDisable', { clear = true })

            vim.api.nvim_create_autocmd('WinEnter', {
                group = augroup,
                callback = function(_)
                    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
                        vim.b.focus_disable = true
                    end
                end,
                desc = 'Disable focus autoresize for BufType',
            })

            vim.api.nvim_create_autocmd('FileType', {
                group = augroup,
                callback = function(_)
                    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                        vim.b.focus_disable = true
                    end
                end,
                desc = 'Disable focus autoresize for FileType',
            })
        end,
        opts = {
            autoresize = {
                height_quickfix = 10,
            },
            ui = {
                signcolumn = false,
            },
        },
    },
    {
        'mg979/vim-visual-multi',
        keys = { '<C-n>', '<C-p>', '<C-Down>', '<C-Up>' },
        config = function() vim.cmd('VMTheme nord') end,
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, DESC = 'Toggle Block Comment' },
        },
        opts = {},
    },
    {
        'folke/todo-comments.nvim',
        event = 'BufEnter',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },
    {
        'saifulapm/chartoggle.nvim',
        keys = { 'g,', 'g;' },
        opts = { leader = 'g', keys = { ',', ';' } },
    },
    {
        'kylechui/nvim-surround',
        keys = { 'c', 'd', 'y', { 'S', mode = 'x' } },
        config = true,
    },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
}
