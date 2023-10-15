local opts = function(desc)
    return { noremap = true, silent = true, desc = desc }
end

local km = vim.keymap.set

vim.g.mapleader = ' '

-- Disable <F1> key
km({ 'n', 'i' }, '<F1>', '<nop>')

km('n', '<esc>', vim.cmd.noh, opts())

-- Register stuff
km('x', '<leader>p', [["_dP]], opts('Paste Over'))
km({ 'n', 'v', 'x' }, '<leader>v', '"_', opts('Void Register'))
km({ 'n', 'v', 'x' }, '<leader>c', '"+', opts('System Clipboard'))

-- Bufferline Navigation
km('n', '<leader><Tab>', '<cmd>BufferLineCycleNext<CR>', opts('Next Buffer'))
km('n', '<leader><S-Tab>', '<cmd>BufferLineCyclePrev<CR>', opts('Prev Buffer'))
for i = 1, 9, 1 do
    km(
        'n',
        '<leader><leader>' .. i,
        function() require('bufferline').go_to(i, true) end,
        opts('Goto Buffer ' .. i)
    )
end
km('n', '<leader><leader>', '<cmd>BufferLinePick<CR>', opts('Goto Buffer'))

-- close buffer
km('n', '<leader>q', '<cmd>bd<CR>', opts('Close Buffer'))
km('n', '<leader>!q', '<cmd>bd!<CR>', opts('Force Close Buffer'))
km('n', '<leader>wq', '<cmd>w<CR><cmd>bd<CR>', opts('Write then Close Buffer'))

-- Better window navigation
km('n', '<A-Left>', '<C-w>h', opts())
km('n', '<A-Down>', '<C-w>j', opts())
km('n', '<A-Up>', '<C-w>k', opts())
km('n', '<A-Right>', '<C-w>l', opts())

-- Telescope
km(
    'n',
    '<leader>F',
    function() require('telescope.builtin').builtin() end,
    opts('Telescope Builtin')
)
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

-- Menus and Stuff
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
    '<leader>na',
    function() require('ts-node-action').node_action() end,
    opts('Run Node Action')
)
km('n', '<leader>a', '<cmd>AerialNavToggle<CR>')
km(
    'n',
    '<F29>',
    function() require('dapui').toggle() end,
    opts('Start Debugging')
)
km(
    'v',
    '<leader>rr',
    function() require('refactoring').select_refactor() end,
    opts('Refactoring Menu')
)
