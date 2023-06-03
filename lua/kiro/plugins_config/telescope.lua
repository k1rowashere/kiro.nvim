return function()
    local keymap = vim.keymap.set
    local n_opts = { silent = true, noremap = true }

    keymap('n', '<leader>ff', ':Telescope find_files<CR>', n_opts)
    keymap('n', '<leader>fb', ':Telescope buffers<CR>', n_opts)
    keymap('n', '<leader>fg', ':Telescope live_grep<CR>', n_opts)
    keymap('n', '<leader>fc', ':Telescope current_buffer_fuzzy_find<CR>', n_opts)
end