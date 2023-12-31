local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
        },
    },
})


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
})

--Enable (broadcasting) snippet capability for completion
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
