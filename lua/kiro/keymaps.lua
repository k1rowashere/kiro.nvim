local M = {}

local map = vim.keymap.set

--- @param opts vim.keymap.set.Opts | string?
--- @return vim.keymap.set.Opts
local opts = function(opts)
    local default = { noremap = true, silent = true, expr = false }
    if type(opts) == 'string' then opts = { desc = opts } end
    opts = opts or {}
    return vim.tbl_extend('keep', opts, default)
end

map('n', 'q:', '<nop>', opts('bad'))

map('n', '<esc>', vim.cmd.noh)
map({ 'i', 'n', 'v', 'x' }, '<C-c>', '<Esc>')
map({ 'n', 'i' }, '<F1>', '<nop>')
map('n', '<C-u>', '<C-I>')
map({ 'i', 'c' }, '<C-H>', '<C-W>')

map('t', '<esc><esc>', '<C-\\><C-n>', opts('Exit Terminal Mode'))
map({ 'i', 't', 'c' }, '<C-BS>', '<C-w>', opts({ desc = 'Delete Previous Word', silent = false }))
map({ 'i' }, '<C-del>', '<C-o>dw', opts({ desc = 'Delete Next Word', silent = false }))

map('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts('Previous Diagnostic'))
map('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts('Next Diagnostic'))

-- Register stuff
map('x', '<leader>p', [["_dP]], opts('Paste Over'))
map({ 'n', 'v', 'x' }, '<leader>v', '"_', opts('Void Register'))
map({ 'n', 'v', 'x' }, '<leader>c', '"+', opts('System Clipboard'))

-- Buffer & Tab Navigation
-- if <leader> is held, then a tab will cycle through buffers
local recently_used = false
local timer = vim.uv.new_timer()

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
map('n', '<leader>Q', '<cmd>bd!<cr>', opts('Force Close Buffer'))
map('n', '<leader>wq', '<cmd>w<cr><cmd>bd<CR>', opts('Write then Close Buffer'))
map('n', '<leader>wn', '<cmd>noautocmd w<CR>', opts('Write Buffer Noautocmd'))

-- TODO: Tab Navigation
map('n', '<leader><leader><tab>', '<cmd>tabNext<cr>', opts('Next Tab'))

M.bufferline = { { '<leader><leader>', '<cmd>BufferLinePick<cr>', desc = 'Pick Buffer' } }
for i = 1, 9 do
    M.bufferline[i + 1] = {
        '<leader><leader>' .. i,
        '<cmd>lua require("bufferline").go_to(' .. i .. ', true)<cr>',
        desc = 'Goto Buffer (' .. i .. ')',
    }
end

M.cmp = function()
    local cmp = require('cmp')
    local mp = cmp.mapping
    local luasnip = require('luasnip')

    return {
        ['<CR>'] = mp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
        ['<C-u>'] = mp.scroll_docs(-1),
        ['<C-d>'] = mp.scroll_docs(1),
        ['<C-Space>'] = mp.complete(),
        ['<C-n>'] = mp.complete(),
        ['<C-e>'] = mp.close(),
        ['<C-f>'] = mp.confirm({ select = true }),
        ['<C-j>'] = mp(mp.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
        ['<C-k>'] = mp(mp.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
        ['<Tab>'] = mp(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = mp(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }
end

M.comment = {
    { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
    { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
}

M.compiler = {
    { '<F5>', 'CompilerRedo' },
    { '<S-F5>', 'CompilerRedo' },
    { '<F6>', 'CompilerToggleResults' },
}

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

M.toggleterm = ''

---@param client vim.lsp.Client
M.lsp = function(bufnr, client)
    local o = function(desc) return opts({ desc = desc, buffer = bufnr }) end

    map('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, o('Show Hover'))
    map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', o('Go to Definition'))
    map('n', '<leader>D', '<cmd>Telescope lsp_type_definitions<cr>', o('Go to Type Definition'))
    map('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', o('Go to Implementation'))
    map('n', '<C-k>', vim.diagnostic.open_float, o('Show Diagnostic'))
    -- map('n', '<C-K>', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, o('Show Signature Help'))
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, o('Add Workspace Folder'))
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, o('Remove Workspace Folder'))
    map('n', '<F2>', vim.lsp.buf.rename, o('Rename Symbol'))
    map({ 'n', 'v' }, '<M-Enter>', vim.lsp.buf.code_action, o('Code Action'))
    map('n', 'gr', '<cmd>Telescope lsp_references<cr>', o('Show References'))
    map('n', '<f3>', function() require('conform').format({ bufnr = bufnr }) end, o('Format Document'))

    if client:supports_method('textDocument/inlayHint') then
        local inlayToggle = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })) end
        map('n', 'gh', inlayToggle, o('Toggle Inlay Hints'))
    end
    if client.name == 'rust-analyzer' then map({ 'n', 'v' }, 'J', ':RustLsp joinLines<cr>', o('Join')) end
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
        {
            '<leader>e',
            function() require('oil').open_float(nil, { preview = {} }) end,
            desc = 'Open Oil Window',
        },
        {
            '<leader>E',
            function() require('oil').open_float(vim.cmd.pwd(), { preview = {} }) end,
            desc = 'Open Oil Window in Working Directory',
        },
    },
    active = {
        ['q'] = 'actions.close',
        ['<leader>e'] = 'actions.close',
        [';'] = function()
            -- vim.uv.spawn('kitty', {
            --     args = {
            --         '@launch',
            --         '--type=tab',
            --         '--cwd=' .. require('oil').get_current_dir(),
            --     },
            -- })
            vim.uv.spawn('konsole', {
                args = {
                    '--new-tab',
                    '--workdir',
                    require('oil').get_current_dir(),
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
    { '<leader>td', '<cmd>Trouble diagnostics toggle win.position=right<cr>', desc = 'Trouble Diagnostics' },
    { '<leader>tt', '<cmd>Trouble todo toggle win.position=right<cr>', desc = 'Trouble Todo' },
}

M.vgit = {
    { '<leader>hp', '<cmd>VGit buffer_hunk_preview<cr>', desc = 'Hunk Diff' },
}

M.ufo = function()
    return {
        'za',
        'zc',
        'zo',
        { 'zr', require('ufo').openFoldsExceptKinds },
        { 'zm', require('ufo').closeFoldsWith },
        { 'zR', require('ufo').openAllFolds },
        { 'zM', require('ufo').closeAllFolds },
        { '<C-z>', require('ufo').peekFoldedLinesUnderCursor },
    }
end

M.undo_tree = {
    { '<leader>u', '<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<CR>', desc = 'Toggle Undotree' },
}

return M
