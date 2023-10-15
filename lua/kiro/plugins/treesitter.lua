return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        opts = {
            auto_install = true,
            rainbow = {
                enable = true,
                disable = { 'NvimTree', 'packer' },
                extended_mode = true,
            },
            highlight = {
                enable = true,
                disable = { 'NvimTree', 'packer' },
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<M-w>',
                    node_incremental = '<M-w>',
                    node_decremental = '<M-C-w>',
                    scope_incremental = '<M-e>',
                },
            },
        },
        main = 'nvim-treesitter.configs',
    },
    { 'HiPhish/rainbow-delimiters.nvim' },
    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
        opts = {
            max_lines = 10,
            multiline_threshold = 2,
        },
    },
    {
        'ckolkey/ts-node-action',
        dependencies = { 'nvim-treesitter' },
        opts = {},
    },
    {
        'stevearc/aerial.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        opts = {},
    },
}
