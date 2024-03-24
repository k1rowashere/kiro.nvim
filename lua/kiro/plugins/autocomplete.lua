local has_words_before = function()
    if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then return false end
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$')
            == nil
end

return {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        { 'onsails/lspkind.nvim' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-calc' },
        { 'hrsh7th/cmp-cmdline' },
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
        {
            'L3MON4D3/LuaSnip',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load({
                    paths = './snippets',
                    fix_pairs = true,
                })
            end,
        },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local cmp_action = require('lsp-zero').cmp_action()
        local luasnip = require('luasnip')

        local opts = {
            window = {
                -- completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
                completion = {
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                    col_offset = -3,
                    side_padding = 0,
                },
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        symbol_map = { Copilot = '' },
                    })(entry, vim_item)
                    if entry.source.name == 'calc' then vim_item.kind = '󰃬 text' end
                    local strings = vim.split(kind.kind, '%s', { trimempty = true })
                    kind.kind = ' ' .. (strings[1] or '') .. ' '
                    kind.menu = '    (' .. (strings[2] or '') .. ')'

                    return kind
                end,
            },
            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({
                            behavior = cmp.SelectBehavior.Insert,
                        })
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-Space>'] = cmp_action.toggle_completion(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-1),
                ['<C-d>'] = cmp.mapping.scroll_docs(1),
            }),
            sources = {
                { name = 'copilot' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'calc' },
            },
            experimental = { ghost_text = true },
        }
        cmp.setup(opts)

        cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            }),
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            window = {
                completion = cmp.config.window.bordered(),
            },
            formatting = { fields = { 'abbr' } },
        })
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } },
            window = {
                completion = cmp.config.window.bordered(),
            },
            formatting = { fields = { 'abbr' } },
        })
    end,
}
