local function color(colorscheme)
  vim.cmd.set('termguicolors')
  vim.cmd.colorscheme(colorscheme)

  -- Custom highlights
  vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    cond = vim.g.colorscheme == 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = { flavor = 'mocha' },
    config = function(_, opts)
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
