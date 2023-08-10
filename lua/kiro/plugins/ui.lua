return {
    { 'stevearc/dressing.nvim', event = 'VeryLazy', opts = {} },
    { 'kevinhwang91/nvim-hlslens', opts = {} },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = {
            show_current_context = true,
            show_current_context_start = true,
            show_trailing_blankline_indent = false,
            use_treesitter = true,
            char = '',
            context_char = '│',
            filetype_exclude = vim.g.non_file_buffers,
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
    { 'lewis6991/satellite.nvim', opts = {} },
    {
        'gorbit99/codewindow.nvim',
        lazy = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = { z_index = 50 },
    },
    { 'folke/twilight.nvim', cmd = 'Twilight', opts = {} },
    { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
}
