return function()
    return {
        options = {
            theme = 'auto',
            disabled_filetypes = {
                statusline = { 'alpha', 'undotree' },
            },
            refresh = { statusline = 100 },
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = { { 'filename', path = 4 } },
            lualine_x = {
                'diagnostics',
                {
                    'lsp_progress',
                    display_components = {
                        'spinner',
                        'lsp_client_name',
                        { 'title' },
                    },
                    timer = { spinner = 100 },
                    spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
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
            'quickfix',
            'nvim-dap-ui',
            'toggleterm',
            -- 'aerial',
            'oil',
            'lazy',
            'trouble',
        },
    }
end
