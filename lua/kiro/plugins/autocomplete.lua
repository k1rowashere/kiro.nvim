local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
                .nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match('%s')
            == nil
end

return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        { 'onsails/lspkind.nvim' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        {
            'zbirenbaum/copilot.lua',
            opts = {
                suggestion = { enabled = false },
                panel = { enabled = false },
            },
        },
        {
            'zbirenbaum/copilot-cmp',
            dependencies = 'nvim-tree/nvim-web-devicons',
            config = true,
        },
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        local luasnip = require('luasnip')
        local cmp = require('cmp')
        local lspkind = require('lspkind')

        require('lsp-zero.cmp').extend()

        cmp.setup({
            enabled = function()
                local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype')
                    == 'prompt'
                if in_prompt then return false end
                return true
            end,
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-Space>'] = cmp.mapping.complete(),
            },
            sources = {
                { name = 'copilot', group_index = 2 },
                { name = 'nvim_lsp', group_index = 2 },
                { name = 'luasnip', group_index = 2 },
                { name = 'buffer', group_index = 2 },
                { name = 'path', group_index = 2 },
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    max_width = 50,
                    symbol_map = { Copilot = '' },
                }),
            },
            -- experimental = {
            --     ghost_text = true,
            -- },
        })
    end,
}
