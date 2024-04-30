return function()
    local lspconfig = require('lspconfig')
    local servers = {
        vhdl_ls = {},
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    completion = { callSnippet = 'Replace' },
                },
            },
        },
        rust_analyzer = false,
        pylsp = {
            settings = { pylsp = { plugins = { jedi = { environment = require('kiro.utils').which_python() } } } },
        },
        tailwindcss = {
            init_options = { userLanguages = { rust = 'html' } },
            root_dir = lspconfig.util.root_pattern('{tailwind, postcss}.config.{js, cjs}'),
            extend_filetypes = { 'rust' },
        },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('mason').setup({})
    vim.schedule(function()
        require('mason-lspconfig').setup_handlers({
            function(server_name)
                local server = servers[server_name] or {}
                -- explicit disable
                if not server then return end

                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                lspconfig[server_name].setup(server)

                if server.extend_filetypes then
                    vim.list_extend(lspconfig[server_name].filetypes, server.extend_filetypes)
                end
            end,
        })
    end)

    vim.diagnostic.config({
        severity_sort = true,
        -- update_in_insert = true, -- Slow Performance
        float = { border = 'rounded' },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = '',
                [vim.diagnostic.severity.WARN] = '',
                [vim.diagnostic.severity.HINT] = '',
                [vim.diagnostic.severity.INFO] = '',
            },
        },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
end
