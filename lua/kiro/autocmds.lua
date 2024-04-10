local M = {}

local g = function(name) vim.api.nvim_create_augroup(name, {}) end
local fmt = g('format_on_save')

vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        group = g('highlight_yank'),
        callback = function() vim.highlight.on_yank() end
    }
)
vim.api.nvim_create_autocmd('BufWritePre', { group = g('save_folds'), command = 'mkview' })
vim.api.nvim_create_autocmd('BufWritePost', { group = g('save_folds'), command = 'silent! loadview' })
vim.api.nvim_create_autocmd('BufEnter', { group = g('format_options'), command = 'set fo-=o' })

-- Auto save session
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = vim.api.nvim_create_augroup('Save Session', {}),
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'nofile' then
                return
            end
        end
        require('session_manager').save_current_session()
    end,
})


vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then return end

        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = fmt, buffer = ev.buf })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = fmt,
                buffer = ev.buf,
                callback = function() vim.lsp.buf.format() end,
            })
        end

        require('kiro.keymaps').lsp(ev.buf, client)
    end,
})

return M
