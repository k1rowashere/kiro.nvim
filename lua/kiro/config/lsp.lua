require('mason').setup({})
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require('mason-lspconfig').setup_handlers({
    -- default handler
    function(server_name) lspconfig[server_name].setup({}) end,

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
            [vim.diagnostic.severity.HINT] = '󰮦',
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


-- lsp.set_server_config({
--     capabilities = {
--         textDocument = {
--             foldingRange = {
--                 dynamicRegistration = false,
--                 lineFoldingOnly = true,
--             },
--         },
--     },
-- })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<M-Enter>', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
        vim.keymap.set('n', '<f3>', function() vim.lsp.buf.format { async = true } end, opts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then return end

        -- Format on Save
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = ev.buf })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = ev.buf,
                callback = function() vim.lsp.buf.format() end,
            })
        end

        if client.server_capabilities.inlayHintProvider then
            vim.keymap.set('n', 'gh', function() vim.lsp.inlay_hint(ev.buf) end, opts)
        end
    end,
})
