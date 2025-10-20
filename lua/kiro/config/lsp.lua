local mason_reg = require('mason-registry')
local package_list = mason_reg.get_installed_package_names()

for _, package in pairs(package_list) do
    local spec = mason_reg.get_package(package).spec
    -- if spec doesn't have 'neovim' then it is not and LSP (linter/formatter/debugger)
    if spec['neovim'] then vim.lsp.enable(spec['neovim']['lspconfig']) end
end

local servers = {
    html = { filetypes = { 'html', 'htmldjango' } },
    clangd = { cmd = { 'clangd', '--clang-tidy' } },
    tailwindcss = {
        init_options = { userLanguages = { rust = 'html' } },
        filetypes = { 'rust' },
    },
}

vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })

for name, config in pairs(servers) do
    -- join config filetypes with existing ones
    if config.filetypes then config.filetypes = vim.list_extend(config.filetypes, vim.lsp.config[name].filetypes) end

    vim.lsp.config(name, config)
end

vim.diagnostic.config({
    severity_sort = true,
    -- update_in_insert = true, -- Slow Performance
    float = { border = 'rounded' },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '❌',
            [vim.diagnostic.severity.WARN] = '⚠️',
            [vim.diagnostic.severity.HINT] = '💡',
            [vim.diagnostic.severity.INFO] = 'ℹ️',
        },
    },
})

vim.lsp.handlers['textDocument/switchSourceHeader'] = function(_, uri)
    if not uri or uri == '' then
        vim.api.nvim_echo({ { 'Corresponding file cannot be determined' } }, false, {})
        return
    end
    local file_name = vim.uri_to_fname(uri)
    vim.api.nvim_cmd({
        cmd = 'edit',
        args = { file_name },
    }, {})
end
