-- Vim options
vim.opt.nu             = true
vim.opt.relativenumber = true
vim.opt.wrap           = false

-- tab options
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true

-- color column
vim.opt.colorcolumn    = '80'
vim.cmd('colorscheme gruvbox-baby')
-- vim.opt.cursorline     = true

-- open window options
vim.opt.splitright                  = true
vim.opt.splitbelow                  = true

-- vim.api.nvim_set_hl(0, 'Normal', {bg='None'})
-- vim.api.nvim_set_hl(0, 'NormalFloat', {bg='None'})

vim.g.gruvbox_baby_background_color = 'dark'
vim.g.gruvbox_baby_telescope_theme  = 1


vim.g.airline_powerline_fonts = 1

vim.g.loaded_netrw            = 1
vim.g.loaded_netrwPlugin      = 1
vim.opt.termguicolors         = true
vim.opt.mousemev              = true
