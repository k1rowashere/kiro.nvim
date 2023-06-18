local opts = function(desc)
    return { noremap = true, silent = true, desc = desc or '' }
end
local km = vim.keymap.set

vim.g.mapleader = ' '

-- Word kill
km('i', '<C-BS>', '<C-w>')
km('i', '<M-BS>', '<C-w>')
km('i', '<C-Del>', '<esc>dei', opts())

-- Shift Select
km('i', '<S-Up>', '<Esc>v<Up>', opts())
km('n', '<S-Up>', 'v<Up>', opts())
km('n', '<S-Down>', 'v<Down>', opts())
km('n', '<S-Left>', 'v<Left>', opts())
km('n', '<S-Right>', 'v<Right>', opts())
km('v', '<S-Up>', '<Up>', opts())
km('v', '<S-Down>', '<Down>', opts())
km('v', '<S-Left>', '<Left>', opts())
km('v', '<S-Right>', '<Right>', opts())
km('i', '<S-Down>', '<Esc>v<Down>', opts())
km('i', '<S-Left>', '<Esc>v<Left>', opts())
km('i', '<S-Right>', '<Esc>v<Right>', opts())

km('n', '<C-S-Up>', 'v<Up>', opts())
km('n', '<C-S-Down>', 'v<Down>', opts())
km('n', '<C-S-Left>', 'v<C-Left>', opts())
km('n', '<C-S-Right>', 'v<C-Right>', opts())
km('v', '<C-S-Up>', '<Up>', opts())
km('v', '<C-S-Down>', '<Down>', opts())
km('v', '<C-S-Left>', '<Left>', opts())
km('v', '<C-S-Right>', '<Right>', opts())
km('i', '<C-S-Up>', '<Esc>v<Up>', opts())
km('i', '<C-S-Down>', '<Esc>v<Down>', opts())
km('i', '<C-S-Left>', '<Esc>v<C-Left>', opts())
km('i', '<C-S-Right>', '<Esc>v<C-Right>', opts())

-- Normal mode
km('n', '<esc>', vim.cmd.noh, opts())

--void paste
-- keymap('x', '<leader>p', [["_dP]])
-- keymap({ 'n', 'v' }, '<leader>d', [["_d]])

-- tab navigation
km('n', '<leader><Tab>', '<cmd>BufferLineCycleNext<CR>', opts('Next Buffer'))
km('n', '<leader><S-Tab>', '<cmd>BufferLineCyclePrev<CR>', opts('Prev Buffer'))
-- Todo: replace this keymap
for i = 1, 9, 1 do
    km(
        'n',
        '<leader><leader>' .. i,
        function() require('bufferline').go_to(i, true) end,
        opts('Goto Buffer ' .. i)
    )
end

-- close buffer
km('n', '<leader>q', '<cmd>bd<CR>', opts('Close Buffer'))

-- Move line / block
-- keymap('n', '<A-j>', '<cmd>MoveLine(1)<CR>', opts('Move down'))
-- keymap('n', '<A-k>', '<cmd>MoveLine(-1)<CR>', opts('Move up'))
-- keymap('v', '<A-j>', ':MoveBlock(1)<CR>', opts('Move down'))
-- keymap('v', '<A-k>', ':MoveBlock(-1)<CR>', opts('Move up'))

-- Better window navigation
km('n', '<A-Left>', '<C-w>h', opts())
km('n', '<A-Down>', '<C-w>j', opts())
km('n', '<A-Up>', '<C-w>k', opts())
km('n', '<A-Right>', '<C-w>l', opts())

km(
    'n',
    '<leader>ff',
    function() require('telescope.builtin').find_files() end,
    opts('Find Files')
)
km(
    'n',
    '<leader>fb',
    function() require('telescope.builtin').buffers() end,
    opts('Find Buffer')
)
km(
    'n',
    '<leader>fg',
    function() require('telescope.builtin').live_grep() end,
    opts('Live Grep')
)
km(
    'n',
    '<leader>fc',
    function() require('telescope.builtin').current_buffer_fuzzy_find() end,
    opts('Current Buffer Fuzzy Find')
)
km(
    'n',
    '<leader>fs',
    function() require('auto-session.session-lens').search_session() end,
    opts('Session Search')
)
km(
    'n',
    '<leader>e',
    function() require('nvim-tree.api').tree.toggle() end,
    opts('Toggle Nvimtree')
)
km(
    'n',
    '<leader>d',
    function() require('trouble').toggle() end,
    opts('Toggle Diagnostics')
)
km(
    'n',
    '<leader>u',
    '<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>',
    opts('Toggle Undotree')
)
km(
    'n',
    '<leader>m',
    function() require('codewindow').toggle_minimap() end,
    opts('Toggle Minimap')
)
km(
    'n',
    '<leader>a',
    function() require('ts-node-action').node_action() end,
    opts('Run Node Action')
)
