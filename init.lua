vim.loader.enable()
vim.g.mapleader = ' '

-- init Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local repo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('kiro.plugins', {
    change_detection = { notify = false },
    install = { colorscheme = { 'catppuccin-mocha' } },
    ui = { border = 'rounded' },
})

require('kiro.autocmds')
require('kiro.options')
require('kiro.keymaps')
require('kiro.config.lsp')
