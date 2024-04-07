return {
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
        'mg979/vim-visual-multi',
        keys = { '<C-n>', '<C-p>', '<C-Down>', '<C-Up>' },
        config = function() vim.cmd('VMTheme nord') end,
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
