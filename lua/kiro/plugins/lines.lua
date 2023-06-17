local function mod_theme()
    if vim.g.colorscheme == 'rose-pine' then
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
    return 'auto'
end

return {
    {
        'akinsho/bufferline.nvim',
        event = 'ColorScheme',
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                mode = 'buffers',
                separator_style = 'slope',
                hover = {
                    enabled = true,
                    delay = 100,
                    reveal = { 'close' },
                },
                offsets = {
                    {
                        filetype = 'NvimTree',
                        text = 'File Explorer',
                        text_align = 'left',
                        separator = true,
                    },
                    {
                        filetype = 'undotree',
                        text = 'Undo Tree',
                        text_align = 'left',
                        separator = true,
                    },
                },
                numbers = 'ordinal',
                diagnostics = 'nvim_lsp',
            },
        },
        config = function(_, opts)
            require('bufferline').setup(opts)
            vim.g.transparent_groups = vim.list_extend(
                vim.g.transparent_groups or {},
                vim.tbl_map(
                    function(v) return v.hl_group end,
                    vim.tbl_values(require('bufferline.config').highlights)
                )
            )
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'arkav/lualine-lsp-progress',
        },
        opts = {
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
                lualine_c = { { 'filename', path = 4 }, },
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
        },
    },
    {
        'luukvbaal/statuscol.nvim',
        event = 'BufEnter *?',
        config = function()
            local builtin = require('statuscol.builtin')

            require('statuscol').setup({
                -- ft_ignore = vim.g.non_file_buffers,
                segments = {
                    {
                        sign = { name = { '.*' }, maxwidth = 1, fillchar = ' ' },
                        click = 'v:lua.ScSa',
                    },
                    {
                        text = { builtin.lnumfunc, ' ' },
                        condition = { true, builtin.not_empty, },
                        click = 'v:lua.ScLa',
                    },
                    {
                        text = { builtin.foldfunc, ' ' },
                        click = 'v:lua.ScFa',
                    },
                },
            })
        end,
    },
    {
        'utilyre/barbecue.nvim',
        lazy = false,
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        opts = { theme = { normal = { bg = 'none' } } },
    },
}
