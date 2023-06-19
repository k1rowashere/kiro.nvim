return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'Telescope' },
    },
    { 'folke/trouble.nvim', lazy = true },
    {
        'mbbill/undotree',
        cmd = { 'UndotreeOpen', 'UndotreeToggle' },
    },
    {
        'akinsho/toggleterm.nvim',
        keys = '<leader>t',
        opts = {
            size = 20,
            open_mapping = '<leader>t',
            insert_mappings = false,
        },
    },
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        ft = { 'markdown' },
        opts = {},
    },
}
