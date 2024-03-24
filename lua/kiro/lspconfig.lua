local lspconfig = require('lspconfig')
local lsp = require('lsp-zero')

lspconfig.lua_ls.setup(vim.tbl_extend('force', lsp.nvim_lua_ls(), {
    settings = {
        Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
        },
    },
}))

lspconfig.rust_analyzer.setup({
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = 'clippy',
            },
            inlayHints = {
                closureReturnTypeHints = {
                    enable = 'always',
                },
            },
            procMacro = {
                ignored = {
                    leptos_macro = {
                        'component',
                        'server',
                    },
                },
            },
        },
    },
})

vim.list_extend(lspconfig.tailwindcss.filetypes, { 'rust' })
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup({
    capabilities = capabilities,
    settings = {
        css = {
            lint = {
                unknownAtRules = 'ignore',
            },
        },
    },
})

vim.diagnostic.config({ virtual_text = true })
