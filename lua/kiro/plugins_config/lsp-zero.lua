local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require('lspkind')

local cmp_mappings = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete(),
}


lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        Error = "\u{ea87} ",
        Warn = "\u{ea6c} ",
        Hint = "󰮦 ",
        Info = "\u{ea74} "
    },
})

lsp.extend_lspconfig({
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
        }
    }
})

lsp.on_attach(function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, remap = false, desc = desc or '' }
    end
    -- Error = , Warn =  , Hint = 󰮦, Info = 
    local signs = { Error = "\u{ea87} ", Warn = "\u{ea6c} ", Hint = "󰮦 ", Info = "\u{ea74} " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts('Goto Definition'))
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts())
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts())
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts('View diagnostic'))
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts('Goto Next diagnostic'))
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts('Goto Previous diagnostic'))
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts('Code Action'))
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts('References'))
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts('Rename Symbol'))
    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts('Signature'))
    -- vim.api.nvim_create_autocmd('BufWritePre', { command = 'LspZeroFormat' })
end)

lsp.setup()

cmp.setup({
    enabled = function()
        local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
        -- this will disable cmp in the Telescope window
        if in_prompt then
            return false
        end
        -- local context = require("cmp.config.context")
        -- return not (context.in_treesitter_capture("comment") or context.in_syntax_group("Comment"))
        return true
    end,
    mapping = cmp_mappings,
    sources = {
        { name = 'copilot',  group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'luasnip',  group_index = 2 },
        { name = 'buffer',   group_index = 2 },
        { name = 'path',     group_index = 2 },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            max_width = 50,
            symbol_map = { Copilot = "" }
        })
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    -- experimental = {
    --     ghost_text = true,
    -- },
})

vim.diagnostic.config({
    virtual_text = true
})
