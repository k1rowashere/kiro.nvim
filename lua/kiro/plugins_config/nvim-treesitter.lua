return function()
    require('nvim-treesitter.configs').setup({
        auto_install = true,
        rainbow = {
            enable = true,
            disable = { 'NvimTree', 'packer' },
            extended_mode = true,
        },
        highlight = {
            enable = true,
            disable = { 'NvimTree', 'packer' },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<M-w>',
                node_incremental = '<M-w>',
                node_decremental = '<M-C-w>',
                scope_incremental = '<M-e>'
            }
        },
    })
end
