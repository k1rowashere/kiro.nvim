local telescope = require('telescope')
local tel_bltin = require('telescope.builtin')
local keymap = vim.keymap.set
local opts = function(desc)
    return { noremap = true, silent = true, desc = desc or '' }
end

telescope.load_extension('session-lens')

keymap('n', '<leader>fs',
    function() require('auto-session.session-lens').search_session() end,
    opts('Session Search'))
keymap('n', '<leader>ff', function() tel_bltin.find_files() end,
    opts('Find Files'))
keymap('n', '<leader>fb', function() tel_bltin.buffers() end,
    opts('Find Buffer'))
keymap('n', '<leader>fg', function() tel_bltin.live_grep() end,
    opts('Live Grep'))
keymap('n', '<leader>fc',
    function() tel_bltin.current_buffer_fuzzy_find() end,
    opts('Current Buffer Fuzzy Find'))
