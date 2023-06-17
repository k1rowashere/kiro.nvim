return {
    'VonHeikemen/lsp-zero.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    branch = 'v2.x',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'jose-elias-alvarez/null-ls.nvim' },
    },
    config = function()
        local lsp = require('lsp-zero.init').preset({})

        -- Fix Undefined global 'vim'
        lsp.nvim_workspace()

        lsp.ensure_installed({
            'tsserver',
            'eslint',
            'rust_analyzer',
            'lua_ls',
            'clangd',
        })

        lsp.set_preferences({
            suggest_lsp_servers = true,
            sign_icons = {
                Error = ' ',
                Warn = ' ',
                Hint = '󰮦 ',
                Info = ' ',
            },
        })

        lsp.format_on_save({
            format_opts = {
                async = true,
                timeout_ms = 10000,
            },
            servers = {
                ['rust_analyzer'] = { 'rust' },
                ['clangd'] = { 'c', 'cpp', 'cs', 'cuda', 'proto' },
                ['null-ls'] = {
                    -- prettier
                    'angular',
                    'css',
                    'flow',
                    'graphql',
                    'html',
                    'json',
                    'jsx',
                    'javascript',
                    'less',
                    'markdown',
                    'scss',
                    'typescript',
                    'vue',
                    'yaml',
                    --
                    'lua',
                },
            },
        })

        lsp.extend_lspconfig({
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            },
        })

        lsp.on_attach(function(_, bufnr)
            local signs =
                { Error = ' ', Warn = ' ', Hint = '󰮦 ', Info = ' ' }

            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            lsp.default_keymaps({ buffer = bufnr })
        end)

        lsp.setup()

        require('kiro.plugins_config.null-ls')
        require('kiro.plugins_config.lspconfig')

        vim.diagnostic.config({ virtual_text = true })
    end,
}
