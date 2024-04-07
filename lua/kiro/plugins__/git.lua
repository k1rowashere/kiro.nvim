local function gitsigns_on_attach(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, {
        expr = true,
        desc = 'Next Hunk',
    })

    map('n', '[h', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true, desc = 'Previous Hunk' })

    -- Actions
    local l = '<leader>h'
    map('n', l .. 's', gs.stage_hunk, { desc = 'Stage hunk' })
    map('n', l .. 'r', gs.reset_hunk, { desc = 'Reset hunk' })
    map(
        'v',
        l .. 's',
        function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = 'Stage hunk' }
    )
    map(
        'v',
        l .. 'r',
        function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = 'Reset hunk' }
    )
    map('n', l .. 'S', gs.stage_buffer, { desc = 'Stage buffer' })
    map('n', l .. 'u', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
    map('n', l .. 'R', gs.reset_buffer, { desc = 'Reset buffer' })
    map('n', l .. 'p', gs.preview_hunk, { desc = 'Preview hunk' })
    map('n', l .. 'b', function() gs.blame_line({ full = true }) end, { desc = 'Blame line' })
    map('n', l .. 'd', gs.diffthis, { desc = 'Diff this' })
    map('n', l .. 'D', function() gs.diffthis('~') end, { desc = 'Diff this (ignore whitespace)' })
    map('n', l .. 'td', gs.toggle_deleted, { desc = 'Toggle deleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

return {
    { 'tpope/vim-fugitive', cmd = 'Git' },
    {
        'lewis6991/gitsigns.nvim',
        enabled = true,
        event = 'VeryLazy',
        opts = {
            on_attach = gitsigns_on_attach,
            -- current_line_blame = true,
        },
    },
}
