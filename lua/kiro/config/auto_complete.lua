---@diagnostic disable: missing-fields
return function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    local opts = {
        window = {
            documentation = cmp.config.window.bordered(),
            completion = {
                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                col_offset = -3,
                side_padding = 0,
                border = 'rounded',
            },
        },
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = 'symbol_text',
                    maxwidth = 50,
                    symbol_map = { Copilot = '' },
                    before = require('tailwind-tools.cmp').lspkind_format,
                })(entry, vim_item)

                if entry.source.name == 'calc' then vim_item.kind = '󰃬 calc' end

                local strings = vim.split(kind.kind, '%s', { trimempty = true })
                kind.kind = ' ' .. (strings[1] or '') .. ' '
                kind.menu = '    (' .. (strings[2] or '') .. ')'

                return kind
            end,
        },
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = require('kiro.keymaps').cmp(cmp, luasnip),
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
        sources = cmp.config.sources({ { name = 'git' } }, { { name = 'buffer' } }),
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
        window = { completion = cmp.config.window.bordered() },
        formatting = { fields = { 'abbr' } },
    })

    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
        window = { completion = cmp.config.window.bordered() },
        formatting = { fields = { 'abbr' } },
    })
end
