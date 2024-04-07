local opts = function(desc) return { noremap = true, silent = true, desc = desc } end

local km = vim.keymap.set

-- Disable <F1> key
km({ 'n', 'i' }, '<F1>', '<nop>')

km('n', '<esc>', vim.cmd.noh, opts())

-- Register stuff
km('x', '<leader>p', [["_dP]], opts('Paste Over'))
km({ 'n', 'v', 'x' }, '<leader>v', '"_', opts('Void Register'))
km({ 'n', 'v', 'x' }, '<leader>c', '"+', opts('System Clipboard'))

-- Buffer Navigation
km('n', '<leader><Tab>', '<cmd>bnext<CR>', opts('Next Buffer'))
km('n', '<leader><S-Tab>', '<cmd>bprevious<CR>', opts('Prev Buffer'))

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
local function tb() return require('telescope.builtin') end
km(
    'n',
    '<leader>F',
    function() tb().builtin() end,
    opts('Telescope Builtin')
)
km('n', '<leader>ff', function() tb().find_files() end, opts('Find Files'))
km('n', '<leader>fb', function() tb().buffers() end, opts('Find Buffer'))
km('n', '<leader>fg', function() tb().live_grep({ search_dirs = { '.' } }) end, opts('Live Grep'))
km(
    'n',
    '<leader>fc',
    function() tb().current_buffer_fuzzy_find() end,
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
km('n', '<leader>e', function() require('oil').toggle_float() end, opts('Toggle Oil Window'))
km('n', '<leader>E', function() require('oil').toggle_float(vim.loop.cwd()) end,
    opts('Toggle Oil Window in Working Directory'))
km('n', '<leader>d', function() require('trouble').toggle() end, opts('Toggle Diagnostics'))
km('n', '<leader>u', '<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>', opts('Toggle Undotree'))
km('n', '<leader>m', function() require('codewindow').toggle_minimap() end, opts('Toggle Minimap'))
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
km('n', '<A-j>', ':MoveLine(1)<CR>', opts())
km('n', '<A-k>', ':MoveLine(-1)<CR>', opts())
km('n', '<A-h>', ':MoveHChar(-1)<CR>', opts())
km('n', '<A-l>', ':MoveHChar(1)<CR>', opts())
km('n', '<leader>wf', ':MoveWord(1)<CR>', opts())
km('n', '<leader>wb', ':MoveWord(-1)<CR>', opts())
km('v', '<A-j>', ':MoveBlock(1)<CR>', opts())
km('v', '<A-k>', ':MoveBlock(-1)<CR>', opts())
km('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts())
km('v', '<A-l>', ':MoveHBlock(1)<CR>', opts())
