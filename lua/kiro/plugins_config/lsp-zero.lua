local lsp = require('lsp-zero')

lsp.preset('recommended')

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        Error = '\u{ea87} ',
        Warn = '\u{ea6c} ',
        Hint = '󰮦 ',
        Info = '\u{ea74} '
    },
})

lsp.format_on_save({
    format_opts = {
        async = true,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        -- if you have a working setup with null-ls
        -- you can specify filetypes it can format.
        -- ['null-ls'] = {'javascript', 'typescript'},
    }
})

lsp.extend_lspconfig({
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
        }
    }
})

lsp.on_attach(function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, remap = false, desc = desc or '' }
    end
    -- Error = , Warn =  , Hint = 󰮦, Info = 
    local signs = { Error = '\u{ea87} ', Warn = '\u{ea6c} ', Hint = '󰮦 ', Info = '\u{ea74} ' }
    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts('Goto Definition'))
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts('Hover'))
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts('View diagnostic'))
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts('Goto Next diagnostic'))
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts('Goto Previous diagnostic'))
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts('Code Action'))
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts('References'))
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts('Rename Symbol'))
    -- vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts('Signature'))
    -- vim.api.nvim_create_autocmd('BufWritePre', { command = 'LspZeroFormat' })
end)

lsp.setup()

require('kiro.plugins_config.nvim-cmp')
require('kiro.plugins_config.lspconfig')

vim.diagnostic.config({ virtual_text = true })
