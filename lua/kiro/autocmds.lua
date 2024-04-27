local M = {}

local g = function(name) vim.api.nvim_create_augroup(name, {}) end
local autocmd = vim.api.nvim_create_autocmd

local relnum = g('relativenumber_toggle')
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
