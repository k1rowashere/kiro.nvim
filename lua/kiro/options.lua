-- Vim options
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.undofile = true
vim.o.swapfile = false
vim.o.updatetime = 300

-- search options
vim.o.ignorecase = true
vim.o.smartcase = true

-- fold options
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
-- vim.o.foldmethod = 'expr'
-- vim.o.foldtext = ''
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = true

-- tab options
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- color column
vim.o.cursorline = true
vim.o.colorcolumn = '999'

vim.o.signcolumn = 'yes'

-- open window options
vim.o.splitright = true
vim.o.splitbelow = true

-- scroll options
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.termguicolors = true
vim.o.mousemev = true
vim.o.sessionoptions = 'buffers,curdir,folds,globals,localoptions,skiprtp,tabpages,winsize,winpos,terminal'
