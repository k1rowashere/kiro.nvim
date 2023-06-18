return {
    { 'ThePrimeagen/harpoon', lazy = true },
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
        'beauwilliams/focus.nvim',
        event = 'WinEnter',
        opts = {
            height = 30,
            quickfixheight = 10,
            excluded_filetypes = { 'fterm', 'term', 'toggleterm' },
            compatible_filetrees = { 'nvimtree', 'undotree' },
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
