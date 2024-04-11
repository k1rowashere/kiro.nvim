local M = {}

local km = vim.keymap.set

--- @param opts table | string | nil
--- @return table
local opts = function(opts)
    local desc = type(opts) == 'string' and opts or opts and opts.desc
    local o = { noremap = true, silent = true, expr = false, desc = desc }

    return o
end


km('n', '[d', vim.diagnostic.goto_prev, opts('Previous Diagnostic'))
km('n', ']d', vim.diagnostic.goto_next, opts('Next Diagnostic'))

km({ 'n', 'i' }, '<F1>', '<nop>')
km('n', '<esc>', vim.cmd.noh, opts())
km('n', '<C-i>', '<C-I>')

-- Register stuff
km('x', '<leader>p', [["_dP]], opts('Paste Over'))
km({ 'n', 'v', 'x' }, '<leader>v', '"_', opts('Void Register'))
km({ 'n', 'v', 'x' }, '<leader>c', '"+', opts('System Clipboard'))

-- Buffer & Tab Navigation
-- if <leader> is held, then a tab will cycle through buffers
local recently_used = false
local timer = UV.new_timer()

local function do_cmd(cmd)
    if not timer then error('Failed to create timer') end

    vim.cmd(cmd)
    recently_used = true

    if not timer:is_closing() then
        timer:stop()
    end

    timer:start(750, 0, function()
        timer:stop()
        recently_used = false
    end)
end

local next = function() do_cmd('bnext') end
local prev = function() do_cmd('bprevious') end

km('n', '<leader><tab>', next, opts('Cycle Buffers'))
km('n', '<leader><S-tab>', prev, opts('Cycle Buffers Reversed'))
km('n', '<tab>', function() if recently_used then next() end end, opts())
km('n', '<S-tab>', function() if recently_used then prev() end end, opts())

-- TODO: replace with bd plugin
km('n', '<leader>q', '<cmd>bd<cr>', opts('Close Buffer'))
km('n', '<leader>!q', '<cmd>bd!<cr>', opts('Force Close Buffer'))
km('n', '<leader>wq', '<cmd>w<cr><cmd>bd<CR>', opts('Write then Close Buffer'))

-- TODO: Tab Navigation
-- km('n', '<leader><leader><tab>', '<cmd>tabNext<cr>', opts('Next Tab'))



M.bufferline = { { '<leader><leader>', '<cmd>BufferLinePick<cr>', desc = 'Pick Buffer' } }
for i = 1, 9 do
    M.bufferline[i + 1] = {
        '<leader><leader>' .. i,
        '<cmd>BufferLineGoToBuffer' .. i .. '<cr>',
        desc = 'Goto Buffer (' .. i .. ')'
    }
end

M.cmp = function(cmp)
    return {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-1),
        ['<C-d>'] = cmp.mapping.scroll_docs(1),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-f>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    }
end

M.gitsigns = function(bufnr)
    local gs = package.loaded.gitsigns
    local o = function(opt)
        return vim.tbl_extend('keep', opt, { noremap = true, silent = true, expr = false, buffer = bufnr })
    end

    -- Navigation
    km('n', ']h',
        function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end,
        o { expr = true, desc = 'Next Hunk' }
    )

    km('n', '[h',
        function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end,
        o { expr = true, desc = 'Previous Hunk' }
    )

    -- Actions
    local l = '<leader>h'
    km('n', l .. 's', gs.stage_hunk, { desc = 'Stage hunk' })
    km('n', l .. 'r', gs.reset_hunk, { desc = 'Reset hunk' })
    km(
        'v',
        l .. 's',
        function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        o { desc = 'Stage hunk' }
    )
    km(
        'v',
        l .. 'r',
        function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        o { desc = 'Reset hunk' }
    )
    km('n', l .. 'S', gs.stage_buffer, o { desc = 'Stage buffer' })
    km('n', l .. 'u', gs.undo_stage_hunk, o { desc = 'Undo stage hunk' })
    km('n', l .. 'R', gs.reset_buffer, o { desc = 'Reset buffer' })
    km('n', l .. 'p', gs.preview_hunk, o { desc = 'Preview hunk' })
    km('n', l .. 'b', function() gs.blame_line({ full = true }) end, o { desc = 'Blame line' })
    km('n', l .. 'd', gs.diffthis, o { desc = 'Diff this' })
    km('n', l .. 'D', function() gs.diffthis('~') end, o { desc = 'Diff this (ignore whitespace)' })
    km('n', l .. 'td', gs.toggle_deleted, o { desc = 'Toggle deleted' })

    -- Text object
    km({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<cr>')
end

M.lsp = function(bufnr, client)
    local o = function(desc) opts({ desc, bufnr }) end

    km('n', 'K', vim.lsp.buf.hover, o('Show Hover'))
    km('n', 'gD', vim.lsp.buf.declaration, o('Go to Declaration'))
    km('n', 'gd', vim.lsp.buf.definition, o('Go to Definition'))
    km('n', 'gi', vim.lsp.buf.implementation, o('Go to Implementation'))
    km('n', '<C-k>', vim.diagnostic.open_float, o('Show Diagnostic'))
    -- km('n', '<C-K>', vim.lsp.buf.signature_help, o('Show Signature Help'))
    km('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, o('Add Workspace Folder'))
    km('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, o('Remove Workspace Folder'))
    km('n', '<leader>D', vim.lsp.buf.type_definition, o('Go to Type Definition'))
    km('n', '<F2>', vim.lsp.buf.rename, o('Rename Symbol'))
    km({ 'n', 'v' }, '<M-Enter>', vim.lsp.buf.code_action, o('Code Action'))
    km('n', 'gr', '<cmd>Telescope lsp_references<cr>', o('Show References'))
    km('n', '<f3>', function() vim.lsp.buf.format({ async = true }) end, o('Format Document'))

    if client.supports_method('textDocument/inlayHint') then
        local fn = function()
            local is_enabled = vim.lsp.inlay_hint.is_enabled(bufnr)
            vim.lsp.inlay_hint.enable(bufnr, not is_enabled)
        end

        km('n', 'gh', fn, o('Toggle Inlay Hints'))
    end
end

M.move = {
    { '<A-j>', '<cmd>MoveLine(1)<cr>',  mode = 'n', desc = 'Move Line Down' },
    { '<A-k>', '<cmd>MoveLine(-1)<cr>', mode = 'n', desc = 'Move Line Up' },
    { '<A-j>', ':MoveBlock(1)<cr>',     mode = 'v', desc = 'Move Block Down' },
    { '<A-k>', ':MoveBlock(-1)<cr>',    mode = 'v', desc = 'Move Block Up' },
    { '<A-h>', ':MoveHBlock(-1)<cr>',   mode = 'v', desc = 'Move Block Left' },
    { '<A-l>', ':MoveHBlock(1)<cr>',    mode = 'v', desc = 'Move Block Right' },
}

M.neogit = { { '<leader>g', '<cmd>Neogit<cr>', desc = 'Toggle Neogit' } }

M.oil = function()
    return {
        { '<leader>e', require('oil').toggle_float,                              desc = 'Toggle Oil Window' },
        { '<leader>E', function() require('oil').toggle_float(vim.uv.cwd()) end, desc = 'Toggle Oil Window in Working Directory' }
    }
end

M.session_manager = { {
    '<leader>fs',
    function() require('session_manager').load_session(true) end,
    desc = 'Session Search'
} }

M.telescope = function()
    local so = function(_opts)
        return function()
            require('search').open({ collection = _opts[1], tab_name = _opts[2] })
        end
    end
    return {
        { '<leader>F',  '<cmd>Telescope builtin<cr>',   desc = 'Telescope Builtin' },
        { '<leader>fb', so { 'files', 'Buffers' },      desc = 'Telescope Buffers' },
        { '<leader>ff', so { 'files', 'Files' },        desc = 'Telescope Files' },
        { '<leader>fg', so { 'files', 'Grep' },         desc = 'Telescope Grep' },
        { '<leader>fr', so { 'files', 'Recent Files' }, desc = 'Telescope Recent Files' },
        { '<leader>fh', so { 'files', 'Fzf' },          desc = 'Current Buffer Fuzzy Find' },
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
    { '<leader>tt', '<cmd>TroubleToggle todo<cr>',                  desc = 'Trouble Todo' },
}

M.ufo = function()
    return {
        'z',
        { 'zR', require('ufo').openAllFolds },
        { 'zM', require('ufo').closeAllFolds },
        { 'Z',  require('ufo').peekFoldedLinesUnderCursor },
    }
end

M.undo_tree = {
    { '<leader>u', '<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<CR>', desc = 'Toggle Undotree' }
}

return M
