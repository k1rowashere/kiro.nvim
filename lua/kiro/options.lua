-- Vim options
vim.o.nu = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.undofile = true
vim.o.swapfile = false
vim.o.updatetime = 300

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

vim.g.dap_buffers = {
    'dap-repl',
    'dapui_scopes',
    'dapui_breakpoints',
    'dapui_stacks',
    'dapui_watches',
    'dapui_console',
}

-- Special windows/buffers
vim.g.non_file_buffers = {
    'NvimTree',
    'packer',
    'Trouble',
    'dashboard',
    'help',
    'man',
    'undotree',
    'diff',
    '',
}

vim.tbl_extend('keep', vim.g.non_file_buffers, vim.g.dap_buffers)

vim.g.lualine_disabled_filetypes = {
    'packer',
    'dashboard',
    'undotree',
    'diff',
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.termguicolors = true
vim.o.mousemev = true

-- vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,'
--     .. 'tabpages,winsize,winpos,terminal,localoptions'
vim.o.sessionoptions = 'blank,buffers,curdir,help,'
    .. 'tabpages,winsize,winpos,terminal,localoptions'
