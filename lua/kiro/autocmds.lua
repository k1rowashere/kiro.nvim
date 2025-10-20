local M = {}

local g = function(name) vim.api.nvim_create_augroup(name, {}) end
local autocmd = vim.api.nvim_create_autocmd

local relnum = g('relativenumber_toggle')

-- set tabwidth to 2 spaces for html files
autocmd('FileType', {
    pattern = { 'html', 'htmldjango' },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- set linewrap on big files (more than 100KB)
autocmd('BufReadPre', {
    callback = function(ev)
        if require('kiro.utils').is_big_file(nil, ev.buf) then
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
            vim.opt_local.breakindent = true
            vim.opt_local.showbreak = '↪'
            vim.opt_local.display = 'lastline'
            vim.opt_local.foldmethod = 'manual'
            vim.cmd.syntax('off')
        end
    end,
})

-- Fix: starts the lsp after session is loaded
-- autocmd({ 'SessionLoadPost', 'User' }, {
--     pattern = 'LazyBufEnter',
--     callback = vim.schedule_wrap(function() vim.cmd('LspStart') end),
-- })

-- Deffers the BufEnter Lazy command to the next idle time
autocmd('BufEnter', {
    pattern = '*?',
    nested = true,
    callback = vim.schedule_wrap(function() vim.api.nvim_exec_autocmds('User', { pattern = 'LazyBufEnter' }) end),
    once = true,
})

-- Set relativenumber only in normal mode
autocmd('InsertEnter', {
    group = relnum,
    callback = function(ev)
        if vim.o.relativenumber then
            vim.o.relativenumber = false
            autocmd('InsertLeave', {
                buffer = ev.buf,
                group = relnum,
                callback = function() vim.o.relativenumber = true end,
                once = true,
            })
        end
    end,
})

autocmd('TextYankPost', {
    group = g('highlight_yank'),
    callback = function() vim.highlight.on_yank() end,
})
autocmd('BufEnter', { group = g('format_options'), command = 'set fo-=o' })

-- Auto save session
autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('Save Session', {}),
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'nofile' then return end
        end
        require('session_manager').save_current_session()
    end,
})

autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then return end
        require('kiro.keymaps').lsp(ev.buf, client)
    end,
})

return M
