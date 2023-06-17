return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        dependencies = 'mrjones2014/nvim-ts-rainbow',
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
    { 'nvim-treesitter/nvim-treesitter-context', lazy = false },
    {
        'ckolkey/ts-node-action',
        dependencies = { 'nvim-treesitter' },
        opts = {},
    },
}
