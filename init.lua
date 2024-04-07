vim.loader.enable()
vim.g.mapleader = ' '

-- init Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('kiro.plugins')

require('kiro.options')
require('kiro.autocmds')
require('kiro.keymaps')
require('kiro.config.lsp')
