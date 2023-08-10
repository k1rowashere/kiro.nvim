local l = 'n <leader>h'
local vgit_keymaps = {
    ['n <C-k>'] = function() require('vgit').hunk_up() end,
    ['n <C-j>'] = function() require('vgit').hunk_down() end,
    [l .. 's'] = function() require('vgit').buffer_hunk_stage() end,
    [l .. 'r'] = function() require('vgit').buffer_hunk_reset() end,
    [l .. 'p'] = function() require('vgit').buffer_hunk_preview() end,
    [l .. 'b'] = function() require('vgit').buffer_blame_preview() end,
    [l .. 'f'] = function() require('vgit').buffer_diff_preview() end,
    [l .. 'h'] = function() require('vgit').buffer_history_preview() end,
    [l .. 'u'] = function() require('vgit').buffer_reset() end,
    [l .. 'g'] = function() require('vgit').buffer_gutter_blame_preview() end,
    [l .. 'lu'] = function() require('vgit').buffer_hunks_preview() end,
    [l .. 'ls'] = function() require('vgit').project_hunks_staged_preview() end,
    [l .. 'd'] = function() require('vgit').project_diff_preview() end,
    [l .. 'q'] = function() require('vgit').project_hunks_qf() end,
    [l .. 'x'] = function() require('vgit').toggle_diff_preference() end,
}

return {
    { 'tpope/vim-fugitive', enabled = false, cmd = 'Git' },
    {
        'tanvirtin/vgit.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        opts = { keymaps = vgit_keymaps },
    },
    {
        'lewis6991/gitsigns.nvim',
        enabled = false,
        event = 'VeryLazy',
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {
                    expr = true,
                    desc = 'Next Hunk',
                })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Previous Hunk' })

                -- Actions
                map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
                map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
                map(
                    'v',
                    '<leader>hs',
                    function()
                        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end,
                    { desc = 'Stage hunk' }
                )
                map(
                    'v',
                    '<leader>hr',
                    function()
                        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end,
                    { desc = 'Reset hunk' }
                )
                map(
                    'n',
                    '<leader>hS',
                    gs.stage_buffer,
                    { desc = 'Stage buffer' }
                )
                map(
                    'n',
                    '<leader>hu',
                    gs.undo_stage_hunk,
                    { desc = 'Undo stage hunk' }
                )
                map(
                    'n',
                    '<leader>hR',
                    gs.reset_buffer,
                    { desc = 'Reset buffer' }
                )
                map(
                    'n',
                    '<leader>hp',
                    gs.preview_hunk,
                    { desc = 'Preview hunk' }
                )
                map(
                    'n',
                    '<leader>hb',
                    function() gs.blame_line({ full = true }) end,
                    { desc = 'Blame line' }
                )
                -- map('n', '<leader>tb', gs.toggle_current_line_blame,
                --     { desc = 'Toggle current line blame' }
                -- )
                map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
                map(
                    'n',
                    '<leader>hD',
                    function() gs.diffthis('~') end,
                    { desc = 'Diff this (ignore whitespace)' }
                )
                -- map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle deleted' })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end,
        },
    },
}
