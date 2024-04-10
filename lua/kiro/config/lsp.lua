require('mason').setup({})
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')

require('mason-lspconfig').setup_handlers({
    -- default handler
    function(server_name)
        lspconfig[server_name].setup({})
    end,

    ['rust_analyzer'] = function() end,

    ['lua_ls'] = function()
        lspconfig.lua_ls.setup({
            settings = {
                Lua = { diagnostics = { globals = { 'vim' } } },
            },
        })
    end,

    ['tailwindcss'] = function()
        lspconfig.tailwindcss.setup({
            init_options = {
                userLanguages = {
                    rust = 'html',
                },
            },
            root_dir = function(fname)
                local root_pattern = require('lspconfig').util.root_pattern(
                    'tailwind.config.cjs',
                    'tailwind.config.js',
                    'postcss.config.js'
                )
                return root_pattern(fname)
            end,
        })
        vim.list_extend(lspconfig.tailwindcss.filetypes, { 'rust' })
    end
})

vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = true,
    float = { border = 'rounded' },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = ''
        }
    }
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)
