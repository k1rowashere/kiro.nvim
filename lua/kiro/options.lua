-- Vim options
vim.opt.nu             = true
vim.opt.relativenumber = true
vim.opt.wrap           = false
vim.opt.undofile       = true

-- tab options
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true

-- color column
vim.opt.colorcolumn    = '80'
vim.opt.cursorline     = true
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })


-- open window options
vim.opt.splitright                  = true
vim.opt.splitbelow                  = true

-- scroll options
vim.opt.scrolloff                   = 10

-- vim.api.nvim_set_hl(0, 'Normal', {bg='None'})
-- vim.api.nvim_set_hl(0, 'NormalFloat', {bg='None'})

vim.g.gruvbox_baby_background_color = 'dark'
vim.g.gruvbox_baby_telescope_theme  = 1


vim.g.airline_powerline_fonts = 1

vim.g.loaded_netrw            = 1
vim.g.loaded_netrwPlugin      = 1

vim.opt.termguicolors         = true
vim.opt.mousemev              = true

vim.o.sessionoptions          = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"


-- Copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
