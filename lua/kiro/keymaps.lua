local M = {}

local map = vim.keymap.set

--- @param opts table | string | nil
--- @return table
local opts = function(opts)
    local desc = type(opts) == 'string' and opts or opts and opts.desc
    local o = { noremap = true, silent = true, expr = false, desc = desc }

    return o
end

map('n', '<esc>', vim.cmd.noh)
map({ 'i', 'n', 'v', 'x' }, '<C-c>', '<Esc>')
map({ 'n', 'i' }, '<F1>', '<nop>')
map('n', '<C-i>', '<C-I>')

map('t', '<esc><esc>', '<C-\\><C-n>', opts('Exit Terminal Mode'))
map({ 'i', 't' }, '<C-BS>', '<C-w>', opts('Delete Previous Word'))

map('n', '[d', vim.diagnostic.goto_prev, opts('Previous Diagnostic'))
map('n', ']d', vim.diagnostic.goto_next, opts('Next Diagnostic'))

-- Register stuff
map('x', '<leader>p', [["_dP]], opts('Paste Over'))
map({ 'n', 'v', 'x' }, '<leader>v', '"_', opts('Void Register'))
map({ 'n', 'v', 'x' }, '<leader>c', '"+', opts('System Clipboard'))

-- Buffer & Tab Navigation
-- if <leader> is held, then a tab will cycle through buffers
local recently_used = false
local timer = UV.new_timer()

local function do_cmd(cmd)
    if not timer then error('Failed to create timer') end

    vim.cmd(cmd)
    recently_used = true

    if not timer:is_closing() then timer:stop() end

    timer:start(750, 0, function()
        timer:stop()
        recently_used = false
    end)
end

local next = function() do_cmd('bnext') end
local prev = function() do_cmd('bprevious') end

map('n', '<leader><tab>', next, opts('Cycle Buffers'))
map('n', '<leader><S-tab>', prev, opts('Cycle Buffers Reversed'))
map('n', '<tab>', function()
    if recently_used then next() end
end, opts())
map('n', '<S-tab>', function()
    if recently_used then prev() end
end, opts())

-- TODO: replace with bd plugin
map('n', '<leader>q', '<cmd>bd<cr>', opts('Close Buffer'))
map('n', '<leader>!q', '<cmd>bd!<cr>', opts('Force Close Buffer'))
map('n', '<leader>wq', '<cmd>w<cr><cmd>bd<CR>', opts('Write then Close Buffer'))

-- TODO: Tab Navigation
map('n', '<leader><leader><tab>', '<cmd>tabNext<cr>', opts('Next Tab'))

M.bufferline = { { '<leader><leader>', '<cmd>BufferLinePick<cr>', desc = 'Pick Buffer' } }
for i = 1, 9 do
    M.bufferline[i + 1] = {
        '<leader><leader>' .. i,
        '<cmd>BufferLineGoToBuffer' .. i .. '<cr>',
        desc = 'Goto Buffer (' .. i .. ')',
    }
end

M.cmp = function(cmp, luasnip)
    return {
        ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-1),
        ['<C-d>'] = cmp.mapping.scroll_docs(1),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-n>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-f>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }
end

M.diffview = {
    when_closed = { { '<leader>hd', '<cmd>DiffviewOpen<cr>', desc = 'Toggle Diffview' } },
    -- uses `vim.keymap.set` format:
    when_open = { { 'n', '<leader>hd', '<cmd>DiffviewClose<cr>', opts('Close Diffview') } },
}

M.gitsigns = function(bufnr)
    local gs = package.loaded.gitsigns
    local o = function(opt)
        return vim.tbl_extend('keep', opt, { noremap = true, silent = true, expr = false, buffer = bufnr })
    end

    -- Navigation
    map('n', ']h', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(gs.next_hunk)
        return '<Ignore>'
    end, o({ expr = true, desc = 'Next Hunk' }))

    map('n', '[h', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(gs.prev_hunk)
        return '<Ignore>'
    end, o({ expr = true, desc = 'Previous Hunk' }))

    map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
    map(
        'v',
        '<leader>hs',
        function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        o({ desc = 'Stage hunk' })
    )
    map(
        'v',
        '<leader>hr',
        function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        o({ desc = 'Reset hunk' })
    )
    map('n', '<leader>hS', gs.stage_buffer, o({ desc = 'Stage buffer' }))
    map('n', '<leader>hu', gs.undo_stage_hunk, o({ desc = 'Undo stage hunk' }))
    map('n', '<leader>hR', gs.reset_buffer, o({ desc = 'Reset buffer' }))
    -- km('n', '<leader>hp', gs.preview_hunk, o { desc = 'Preview hunk' })
    map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, o({ desc = 'Blame line' }))
    -- km('n', '<leader>hd', gs.diffthis, o { desc = 'Diff this' })
    -- km('n', '<leader>hD', function() gs.diffthis('~') end, o { desc = 'Diff this (ignore whitespace)' })
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<cr>')
end

M.toggleterm = '<C-;>'

M.lsp = function(bufnr, client)
    local o = function(desc) opts({ desc, bufnr }) end

    map('n', 'K', vim.lsp.buf.hover, o('Show Hover'))
    map('n', 'gD', vim.lsp.buf.declaration, o('Go to Declaration'))
    map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', o('Go to Definition'))
    map('n', '<leader>D', '<cmd>Telescope lsp_type_definitions<cr>', o('Go to Type Definition'))
    map('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', o('Go to Implementation'))
    map('n', '<C-k>', vim.diagnostic.open_float, o('Show Diagnostic'))
    -- km('n', '<C-K>', vim.lsp.buf.signature_help, o('Show Signature Help'))
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, o('Add Workspace Folder'))
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, o('Remove Workspace Folder'))
    map('n', '<F2>', vim.lsp.buf.rename, o('Rename Symbol'))
    map({ 'n', 'v' }, '<M-Enter>', vim.lsp.buf.code_action, o('Code Action'))
    map('n', 'gr', '<cmd>Telescope lsp_references<cr>', o('Show References'))
    map('n', '<f3>', function() vim.lsp.buf.format({ async = true }) end, o('Format Document'))

    if client.supports_method('textDocument/inlayHint') then
        local fn = function()
            local is_enabled = vim.lsp.inlay_hint.is_enabled(bufnr)
            vim.lsp.inlay_hint.enable(bufnr, not is_enabled)
        end

        map('n', 'gh', fn, o('Toggle Inlay Hints'))
    end
end

M.move = {
    { '<A-j>', '<cmd>MoveLine(1)<cr>', mode = 'n', desc = 'Move Line Down' },
    { '<A-k>', '<cmd>MoveLine(-1)<cr>', mode = 'n', desc = 'Move Line Up' },
    { '<A-j>', ':MoveBlock(1)<cr>', mode = 'v', desc = 'Move Block Down' },
    { '<A-k>', ':MoveBlock(-1)<cr>', mode = 'v', desc = 'Move Block Up' },
    { '<A-h>', ':MoveHBlock(-1)<cr>', mode = 'v', desc = 'Move Block Left' },
    { '<A-l>', ':MoveHBlock(1)<cr>', mode = 'v', desc = 'Move Block Right' },
}

M.navbuddy = { { '<leader>n', '<cmd>Navbuddy<cr>', desc = 'Toggle NavBuddy' } }

M.neogit = { { '<leader>g', '<cmd>Neogit<cr>', desc = 'Toggle Neogit' } }

M.oil = {
    global = {
        { '<leader>e', '<cmd>Oil --float<cr>', desc = 'Toggle Oil Window' },
        {
            '<leader>E',
            function() require('oil').toggle_float(vim.cmd.pwd()) end,
            desc = 'Toggle Oil Window in Working Directory',
        },
    },
    active = {
        ['q'] = 'actions.close',
        ['<leader>e'] = 'actions.close',
        -- FIXME: this is a hack to get previews in floating windows
        ['<C-p>'] = function()
            local oil = require('oil')
            if require('oil.util').is_floating_win() then
                local dir = oil.get_current_dir()
                oil.close()
                oil.open(dir)
            end
            require('oil.actions').preview.callback()
        end,
        ['<C-;>'] = function()
            UV.spawn('kitty', {
                args = {
                    '@launch',
                    '--type=tab',
                    '--cwd=' .. require('oil').get_current_dir(),
                },
            })
        end,
    },
}

M.session_manager = {
    {
        '<leader>fs',
        function() require('session_manager').load_session(true) end,
        desc = 'Session Search',
    },
}

M.telescope = function()
    local so = function(_opts)
        return function() require('search').open({ collection = _opts[1], tab_name = _opts[2] }) end
    end
    return {
        { '<leader>F', '<cmd>Telescope builtin<cr>', desc = 'Telescope Builtin' },
        { '<leader>fb', so({ 'files', 'Buffers' }), desc = 'Telescope Buffers' },
        { '<leader>ff', so({ 'files', 'Files' }), desc = 'Telescope Files' },
        { '<leader>fg', so({ 'files', 'Grep' }), desc = 'Telescope Grep' },
        { '<leader>fr', so({ 'files', 'Recent Files' }), desc = 'Telescope Recent Files' },
        { '<leader>fh', so({ 'files', 'Fzf' }), desc = 'Current Buffer Fuzzy Find' },
    }
end

M.treesitter = {
    init_selection = '<M-w>',
    node_incremental = '<M-w>',
    node_decremental = '<M-W>',
    scope_incremental = '<M-e>',
}

M.trouble = {
    { '<leader>td', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Trouble Diagnostics' },
    { '<leader>tt', '<cmd>TroubleToggle todo<cr>', desc = 'Trouble Todo' },
}

M.vgit = {
    { '<leader>hp', '<cmd>VGit buffer_hunk_preview<cr>', desc = 'Hunk Diff' },
}

M.ufo = function()
    return {
        'za',
        'zr',
        'zm',
        'zc',
        'zo',
        { 'zR', require('ufo').openAllFolds },
        { 'zM', require('ufo').closeAllFolds },
        { 'Z', require('ufo').peekFoldedLinesUnderCursor },
    }
end

M.undo_tree = {
    { '<leader>u', '<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<CR>', desc = 'Toggle Undotree' },
}

return M
