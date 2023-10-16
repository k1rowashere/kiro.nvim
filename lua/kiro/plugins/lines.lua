local lualine_opts = {
    options = {
        theme = 'auto',
        disabled_filetypes = {
            statusline = { 'dashboard', 'undotree' },
        },
        refresh = { statusline = 100 },
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
                    'lsp_client_name',
                    'spinner',
                },
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
        'aerial',
        'lazy',
    },
}

local function rm_devicon_bg(element)
    local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(
        element.filetype,
        { default = false }
    )
    if hl and vim.g.transparent_enabled then
        vim.cmd('highlight BufferLine' .. hl .. ' guibg=none')
    end

    return icon, hl
end

return {
    {
        'akinsho/bufferline.nvim',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
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
                    {
                        filetype = 'aerial',
                        text = '',
                        text_align = 'left',
                        separator = true,
                    },
                },
                numbers = 'ordinal',
                diagnostics = 'nvim_lsp',
                get_element_icon = rm_devicon_bg,
            },
        },
        config = function(_, opts)
            local highlights =
                require('catppuccin.groups.integrations.bufferline').get()

            opts.highlights = vim.tbl_extend('force', highlights(), {
                buffer_selected = { bg = 'none' },
                buffer_visible = { bg = 'none' },
            })

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
        opts = lualine_opts,
    },
    {
        'utilyre/barbecue.nvim',
        lazy = false,
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        opts = { theme = 'catppuccin-mocha' },
    },
}
