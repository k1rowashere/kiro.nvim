vim.loader.enable()
vim.g.mapleader = ' '

UV = vim.uv or vim.loop

-- init Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not UV.fs_stat(lazypath) then
    local repo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath })
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- AUTOCMDTESTING = 'BufEnter *?'
AUTOCMDTEST = 'User LazyBufEnter'

require('lazy').setup('kiro.plugins', {
    change_detection = { notify = false },
    install = { colorscheme = { 'catppuccin-mocha' } },
    ui = { border = 'rounded' },
})

require('kiro.autocmds')
require('kiro.options')
require('kiro.keymaps')
require('kiro.config.lsp')
