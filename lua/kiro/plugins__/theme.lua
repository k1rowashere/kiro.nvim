local function color(colorscheme)
    vim.cmd.set('termguicolors')
    vim.cmd.colorscheme(colorscheme)

    local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end
    local cmp = 'CmpItem'
    local fg = '#EEEEEE'
    local val = function(bg) return { fg = fg, bg = bg } end
    -- swap bg and fg

    hl('PmenuSel', { fg = '#282C34', bg = 'NONE' })
    hl('Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

    hl(cmp .. 'AbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
    hl(cmp .. 'AbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
    hl(cmp .. 'AbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
    hl(cmp .. 'Menu', { fg = '#C792EA', bg = 'NONE', italic = true })
    hl(cmp .. 'KindCopilot', val('#6CC644'))
    hl(cmp .. 'KindField', val('#B5585F'))
    hl(cmp .. 'KindProperty', val('#B5585F'))
    hl(cmp .. 'KindEvent', val('#B5585F'))
    hl(cmp .. 'KindText', val('#9FBD73'))
    hl(cmp .. 'KindEnum', val('#9FBD73'))
    hl(cmp .. 'KindKeyword', val('#9FBD73'))
    hl(cmp .. 'KindConstant', val('#D4BB6C'))
    hl(cmp .. 'KindConstructor', val('#D4BB6C'))
    hl(cmp .. 'KindReference', val('#D4BB6C'))
    hl(cmp .. 'KindFunction', val('#A377BF'))
    hl(cmp .. 'KindStruct', val('#A377BF'))
    hl(cmp .. 'KindClass', val('#A377BF'))
    hl(cmp .. 'KindModule', val('#A377BF'))
    hl(cmp .. 'KindOperator', val('#A377BF'))
    hl(cmp .. 'KindVariable', val('#7E8294'))
    hl(cmp .. 'KindFile', val('#7E8294'))
    hl(cmp .. 'KindUnit', val('#D4A959'))
    hl(cmp .. 'KindSnippet', val('#D4A959'))
    hl(cmp .. 'KindFolder', val('#D4A959'))
    hl(cmp .. 'KindMethod', val('#6C8ED4'))
    hl(cmp .. 'KindValue', val('#6C8ED4'))
    hl(cmp .. 'KindEnumMember', val('#6C8ED4'))
    hl(cmp .. 'KindInterface', val('#58B5A8'))
    hl(cmp .. 'KindColor', val('#58B5A8'))
    hl(cmp .. 'KindTypeParameter', val('#58B5A8'))

    hl('TSContext', { bg = '#181826' })
end

return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        cond = vim.g.colorscheme == 'catppuccin',
        lazy = false,
        priority = 1000,
        opts = {
            flavor = 'mocha',
            integrations = {
                indent_blankline = { scope_color = 'lavender' },
                aerial = true,
                mason = true,
                treesitter_context = true,
                lsp_trouble = true,
            },
        },
        config = function(_, opts)
            -- opts.integrations.areial = true
            require('catppuccin').setup(opts)
            color('catppuccin')
        end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        cond = vim.g.colorscheme == 'rose-pine',
        lazy = false,
        priority = 1000,
        opts = {
            highlight_groups = {
                ColorColumn = { bg = 'rose' },
                CursorLine = { bg = 'foam', blend = 5 },
            },
        },
        config = function(_, opts)
            require('rose-pine').setup(opts)
            color('rose-pine')
        end,
    },
    {
        'xiyaowong/transparent.nvim',
        lazy = false,
        priority = 100,
        opts = {
            extra_groups = {
                'Normal',
                'NormalFloat',
                'NvimTreeNormal',
                'folded',
                'GitSignsAdd',
                'GitSignsChange',
                'GitSignsDelete',
                'FloatBorder',
                'TelescopeNormal',
                'TelescopeBorder',
                'TelescopePromptNormal',
                'WhichKeyFloat',
            },
            exclude_groups = {},
        },
    },
}
