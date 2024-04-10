local M = {}

local km = vim.keymap.set

--- @param opts table | string | nil
--- @return table
local opts = function(opts)
    local desc = type(opts) == 'string' and opts or opts and opts.desc
    local o = { noremap = true, silent = true, expr = false, desc = desc }

    return o
end


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

-- TODO: Tab Navigation
-- km('n', '<leader><leader><tab>', '<cmd>tabNext<CR>', opts('Next Tab'))

km('n', '<leader><leader>', '<cmd>BufferLinePick<CR>', opts('Pick Buffer'))
for i = 1, 9 do
    km('n',
        '<leader><leader>' .. i,
        '<cmd>BufferLineGoToBuffer' .. i .. '<CR>',
        opts('Goto Buffer ' .. i)
    )
end

-- close buffer
km('n', '<leader>q', '<cmd>bd<CR>', opts('Close Buffer'))
km('n', '<leader>!q', '<cmd>bd!<CR>', opts('Force Close Buffer'))
km('n', '<leader>wq', '<cmd>w<CR><cmd>bd<CR>', opts('Write then Close Buffer'))

-- Better window navigation
km('n', '<A-Left>', '<C-w>h', opts())
km('n', '<A-Down>', '<C-w>j', opts())
km('n', '<A-Up>', '<C-w>k', opts())
km('n', '<A-Right>', '<C-w>l', opts())


-- Menus and Stuff
km('n', '<leader>g', '<CMD>Neogit<CR>', opts('Toggle Neogit'))
km('n', '<leader>e', function() require('oil').toggle_float() end, opts('Toggle Oil Window'))
km('n', '<leader>E', function() require('oil').toggle_float(vim.uv.cwd()) end,
    opts('Toggle Oil Window in Working Directory'))
km('n', '<leader>u', '<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>', opts('Toggle Undotree'))
km(
    'n',
    '<leader>na',
    function() require('ts-node-action').node_action() end,
    opts('Run Node Action')
)
km('n', '<leader>a', '<cmd>AerialToggle<CR>')
km('n', '<F29>', function() require('dapui').toggle() end, opts('Start Debugging'))
km(
    'v',
    '<leader>rr',
    function() require('refactoring').select_refactor() end,
    opts('Refactoring Menu')
)

-- Move lines and blocks
km('n', '<A-j>', ':MoveLine(1)<CR>', opts('Move Line Down'))
km('n', '<A-k>', ':MoveLine(-1)<CR>', opts('Move Line Up'))
-- km('n', '<A-h>', ':MoveHChar(-1)<CR>', opts('Move Char Left'))
-- km('n', '<A-l>', ':MoveHChar(1)<CR>', opts('Move Char Right'))

km('v', '<A-j>', ':MoveBlock(1)<CR>', opts('Move Block Down'))
km('v', '<A-k>', ':MoveBlock(-1)<CR>', opts('Move Block Up'))
km('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts('Move Block Left'))
km('v', '<A-l>', ':MoveHBlock(1)<CR>', opts('Move Block Right'))

km('n', '[d', vim.diagnostic.goto_prev)
km('n', ']d', vim.diagnostic.goto_next)

function M.telescope()
    km('n', '<leader>F', '<cmd>Telescope builtin<cr>', opts('Telescope Builtin'))
    km('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts('Find Files'))
    km('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts('Find Buffer'))
    km(
        'n',
        '<leader>fg',
        function()
            local t = require('telescope.builtin')

            local function get_git_root()
                local dot_git_path = vim.fn.finddir(".git", ".;")
                return vim.fn.fnamemodify(dot_git_path, ":h")
            end

            -- if we are in a git repo, grep the root of the repo
            -- otherwise grep the cwd
            local git_root = get_git_root()
            if git_root ~= "" then
                t.live_grep({ cwd = git_root })
            else
                t.live_grep()
            end
        end,
        opts('Grep Current Working Directory')
    )
    km('n', '<leader>fc', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts('Current Buffer Fuzzy Find'))
    km(
        'n',
        '<leader>fs',
        function() require('session_manager').load_session(true) end,
        opts('Session Search')
    )

    -- Open Snippets folder in telescope
    km(
        'n',
        '<leader>/s',
        function()
            require('telescope.builtin').find_files({
                cwd = vim.fn.stdpath('config') .. '/snippets',
            })
        end,
        opts('Find Snippets')
    )
end

function M.ufo()
    local ufo = require('ufo')
    km('n', 'zR', ufo.openAllFolds)
    km('n', 'zM', ufo.closeAllFolds)
    km('n', 'Z', ufo.peekFoldedLinesUnderCursor)
end

function M.lsp(bufnr, client)
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

function M.gitsigns(bufnr)
    local gs = package.loaded.gitsigns
    local o = function(op)
        opts(vim.tbl_extend('keep', op, { buffer = bufnr }))
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
    km({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

return M
