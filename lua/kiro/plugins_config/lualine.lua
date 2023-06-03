return function()
    local rose_pine_mod = require('lualine.themes.rose-pine')

    rose_pine_mod.inactive.a = { bg = '#1e1e2a' }
    rose_pine_mod.inactive.b = { bg = '#1e1e2a' }
    rose_pine_mod.inactive.c = { bg = '#1e1e2a' }

    rose_pine_mod.normal.c = { bg = '#383146' }
    rose_pine_mod.insert.c = { bg = '#313348' }
    rose_pine_mod.command.c = { bg = '#382A42' }
    rose_pine_mod.visual.c = { bg = '#342F4A' }
    rose_pine_mod.replace.c = { bg = '#34324B' }

    -- rose_pine_mod.insert.c = { bg = '#9ccfd8' }
    -- rose_pine_mod.command.c = { bg = '#eb6f92' }
    -- rose_pine_mod.visual.c = { bg = '#c4a7e7' }
    -- rose_pine_mod.replace.c = { bg = '#c0caf5' }

    require('lualine').setup {
        options = {
            theme = rose_pine_mod,
            disabled_filetypes = {
                statusline = vim.g.lualine_disabled_filetypes
            },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = { { 'filename', path = 4 } },
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
        extensions = { 'fugitive', 'nvim-tree', 'trouble' }
    }
end
