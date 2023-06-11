local rose_pine = require('lualine.themes.rose-pine')
local rose_pine_mod = {
    inactive = {
        a = { bg = '#1e1e2a' },
        b = { bg = '#1e1e2a' },
        c = { bg = '#1e1e2a' },
    },
    normal = { c = { bg = '#383146' } },
    insert = { c = { bg = '#313348' } },
    command = { c = { bg = '#382A42' } },
    visual = { c = { bg = '#342F4A' } },
    replace = { c = { bg = '#34324B' } },
}
rose_pine = vim.tbl_deep_extend('force', rose_pine, rose_pine_mod)

require('lualine').setup {
    options = {
        theme = rose_pine,
        disabled_filetypes = {
            statusline = vim.g.lualine_disabled_filetypes
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { require('auto-session.lib').current_session_name, { 'filename', path = 4 } },
        lualine_x = { 'diagnostics', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 4 } },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    -- tabline = {},
    extensions = {
        'fugitive',
        'quickfix',
        'nvim-tree',
        'trouble',
        'nvim-dap-ui',
        'toggleterm',
    }
}
