local function mod_theme()
    local theme = require('lualine.themes.rose-pine')
    local theme_mod = {
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
    return vim.tbl_deep_extend('force', theme, theme_mod)
end

return {
    options = {
        theme = mod_theme(),
        disabled_filetypes = {
            statusline = vim.g.lualine_disabled_filetypes,
        },
        refresh = { statusline = 100 },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
            {
                require('auto-session.lib').current_session_name,
                on_click = function()
                    require('auto-session.session-lens').search_session()
                end,
            },
            { 'filename', path = 4 },
        },
        lualine_x = {
            'diagnostics',
            {
                'lsp_progress',
                display_components = { 'lsp_client_name', 'spinner' },
                timer = { spinner = 100 },
                spinner_symbols = {
                    '⠋',
                    '⠙',
                    '⠹',
                    '⠸',
                    '⠼',
                    '⠴',
                    '⠦',
                    '⠧',
                    '⠇',
                    '⠏',
                },
            },
            'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
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
    },
}
