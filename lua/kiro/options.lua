-- Vim options
vim.opt.nu               = true
vim.opt.relativenumber   = true
vim.opt.wrap             = false
vim.opt.undofile         = true

-- tab options
vim.opt.tabstop          = 4
vim.opt.shiftwidth       = 4
vim.opt.expandtab        = true

-- color column
vim.opt.colorcolumn      = '80'
vim.opt.cursorline       = true

-- open window options
vim.opt.splitright       = true
vim.opt.splitbelow       = true

-- scroll options
vim.opt.scrolloff        = 10

-- Special windows/buffers
vim.g.non_file_buffers   = {
    'NvimTree',
    'packer',
    'Trouble',
    'dashboard',
    'help',
    'man',
    '',
}

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors    = true
vim.opt.mousemev         = true

vim.opt.sessionoptions   = 'blank,buffers,curdir,folds,help,' ..
    'tabpages,winsize,winpos,terminal,' ..
    'localoptions'

-- Copilot
-- vim.g.copilot_no_tab_map      = true
-- vim.g.copilot_assume_mapped   = true
-- vim.g.copilot_tab_fallback    = ""

-- Fold options
-- Save fold settings when saving a file
vim.cmd [[
    augroup remember_folds
        au!
        au BufWritePre *.* mkview
        au BufWritePost *.* silent loadview
    augroup END
]]

vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99
vim.o.foldlevelstart = -1
vim.o.foldenable     = true

vim.o.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Packer auto compile
vim.api.nvim_create_autocmd('BufWritePost',
    {
        group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
        pattern = 'plugins.lua',
        command = 'source <afile> | PackerCompile',
    })

vim.api.nvim_create_autocmd('BufEnter',
    {
        pattern = '*',
        command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
    })
