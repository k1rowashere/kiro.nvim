local opts = function(desc)
    return { noremap = true, silent = true, desc = desc or '' }
end
local t_opts = { silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = ' '

-- Word kill
keymap('i', '<C-BS>', '<C-w>')
keymap('i', '<M-BS>', '<C-w>')
keymap('i', '<C-Del>', '<esc>dei', opts())

-- Shift Select
keymap('n', '<S-Up>', 'v<Up>', opts())
keymap('n', '<S-Down>', 'v<Down>', opts())
keymap('n', '<S-Left>', 'v<Left>', opts())
keymap('n', '<S-Right>', 'v<Right>', opts())
keymap('v', '<S-Up>', '<Up>', opts())
keymap('v', '<S-Down>', '<Down>', opts())
keymap('v', '<S-Left>', '<Left>', opts())
keymap('v', '<S-Right>', '<Right>', opts())
keymap('i', '<S-Up>', '<Esc>v<Up>', opts())
keymap('i', '<S-Down>', '<Esc>v<Down>', opts())
keymap('i', '<S-Left>', '<Esc>v<Left>', opts())
keymap('i', '<S-Right>', '<Esc>v<Right>', opts())

keymap('n', '<C-S-Up>', 'v<Up>', opts())
keymap('n', '<C-S-Down>', 'v<Down>', opts())
keymap('n', '<C-S-Left>', 'v<C-Left>', opts())
keymap('n', '<C-S-Right>', 'v<C-Right>', opts())
keymap('v', '<C-S-Up>', '<Up>', opts())
keymap('v', '<C-S-Down>', '<Down>', opts())
keymap('v', '<C-S-Left>', '<Left>', opts())
keymap('v', '<C-S-Right>', '<Right>', opts())
keymap('i', '<C-S-Up>', '<Esc>v<Up>', opts())
keymap('i', '<C-S-Down>', '<Esc>v<Down>', opts())
keymap('i', '<C-S-Left>', '<Esc>v<C-Left>', opts())
keymap('i', '<C-S-Right>', '<Esc>v<C-Right>', opts())

-- Normal mode
keymap('n', '<esc>', vim.cmd.noh, opts())

--void paste
-- keymap('x', '<leader>p', [["_dP]])
-- keymap({ 'n', 'v' }, '<leader>d', [["_d]])

-- tab navigation
keymap(
    'n',
    '<leader><Tab>',
    '<cmd>BufferLineCycleNext<CR>',
    opts('Next Buffer')
)
keymap(
    'n',
    '<leader><S-Tab>',
    '<cmd>BufferLineCyclePrev<CR>',
    opts('Prev Buffer')
)
-- Todo: replace this keymap
for i = 1, 9, 1 do
    keymap('n', '<leader><leader>' .. i, function()
        require('bufferline').go_to(i, true)
    end, opts('Goto Buffer ' .. i))
end

-- close buffer
keymap('n', '<leader>q', '<cmd>bd<CR>', opts('Close Buffer'))

-- Move line / block
keymap('n', '<A-j>', '<cmd>MoveLine(1)<CR>', opts('Move down'))
keymap('n', '<A-k>', '<cmd>MoveLine(-1)<CR>', opts('Move up'))
keymap('v', '<A-j>', ':MoveBlock(1)<CR>', opts('Move down'))
keymap('v', '<A-k>', ':MoveBlock(-1)<CR>', opts('Move up'))

-- Better window navigation
keymap('n', '<A-Left>', '<C-w>h', opts())
keymap('n', '<A-Down>', '<C-w>j', opts())
keymap('n', '<A-Up>', '<C-w>k', opts())
keymap('n', '<A-Right>', '<C-w>l', opts())

keymap('n', '<leader>ff', function()
    require('telescope.builtin').find_files()
end, opts('Find Files'))
keymap('n', '<leader>fb', function()
    require('telescope.builtin').buffers()
end, opts('Find Buffer'))
keymap('n', '<leader>fg', function()
    require('telescope.builtin').live_grep()
end, opts('Live Grep'))
keymap('n', '<leader>fc', function()
    require('telescope.builtin').current_buffer_fuzzy_find()
end, opts('Current Buffer Fuzzy Find'))
keymap('n', '<leader>fs', function()
    require('auto-session.session-lens').search_session()
end, opts('Session Search'))
keymap('n', '<leader>e', function()
    require('nvim-tree.api').tree.toggle()
end, opts('Toggle Nvimtree'))
keymap('n', '<leader>d', function()
    require('trouble').toggle()
end, opts('Toggle Diagnostics'))
keymap(
    'n',
    '<leader>u',
    '<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>',
    opts('Toggle Undotree')
)
keymap('n', '<leader>m', function()
    require('codewindow').toggle_minimap()
end, opts('Toggle Minimap'))

-- Visual selection
local surround_map = function(char)
    keymap(
        'v',
        '<leader>' .. char,
        '<Plug>(nvim-surround-visual)' .. char,
        opts()
    )
end

for _, char in ipairs({ '(', ')', '[', ']', '{', '}', '<', '>', '"', "'" }) do
    surround_map(char)
end

-- Terminal mode
keymap('t', '<esc>', '<C-\\><C-N>', t_opts)
keymap('t', '<A-Left>', '<C-\\><C-N><C-w>h', t_opts)
keymap('t', '<A-Down>', '<C-\\><C-N><C-w>j', t_opts)
keymap('t', '<A-Up>', '<C-\\><C-N><C-w>k', t_opts)
keymap('t', '<A-Right>', '<C-\\><C-N><C-w>l', t_opts)
