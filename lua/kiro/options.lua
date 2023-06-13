-- Vim options
vim.opt.nu             = true
vim.opt.relativenumber = true
vim.cmd [[ autocmd TermOpen * setlocal nonumber norelativenumber ]]
vim.opt.wrap     = false
vim.opt.undofile = true


-- tab options
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true

-- color column
vim.opt.cursorline     = true

-- open window options
vim.opt.splitright     = true
vim.opt.splitbelow     = true

-- scroll options
vim.opt.scrolloff      = 10

vim.g.dap_buffers      = {
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
}

vim.tbl_extend('keep', vim.g.non_file_buffers, vim.g.dap_buffers)

vim.g.lualine_disabled_filetypes = {
    'packer',
    'dashboard',
    'undotree',
    'diff',
}

vim.g.loaded_netrw               = 1
vim.g.loaded_netrwPlugin         = 1

vim.opt.termguicolors            = true
vim.opt.mousemev                 = true

vim.opt.sessionoptions           = 'blank,buffers,curdir,folds,help,' ..
    'tabpages,winsize,winpos,terminal,localoptions'


-- Save fold settings when saving a file
vim.cmd [[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
    augroup END

augroup save_folds
    autocmd!
    autocmd BufWritePre ?* mkview
    autocmd BufWritePost ?* silent! loadview
    augroup END

augroup format_options
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
]]
