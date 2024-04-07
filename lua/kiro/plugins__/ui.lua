return {
    { 'stevearc/dressing.nvim', event = 'VeryLazy', config = true },
    { 'kevinhwang91/nvim-hlslens', config = true },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        main = 'ibl',
        opts = {
            scope = { enabled = true },
            exclude = { filetypes = { 'dashboard', 'undotree' } },
        },
    },
    {
        'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'scss', 'javascript', 'html' },
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
        opts = {
            'scss',
            'html',
            css = { rgb_fn = true },
            javascript = { no_names = true },
        },
    },
    { 'lewis6991/satellite.nvim', config = true },
    {
        'gorbit99/codewindow.nvim',
        lazy = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = { z_index = 50 },
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
        },
        config = true,
    },
    {
        'folke/todo-comments.nvim',
        event = 'BufEnter',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },
    { 'folke/twilight.nvim', cmd = 'Twilight', config = true },
    { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
}
