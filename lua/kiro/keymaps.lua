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
-- if <leader> is held, then a tab will cycle through buffers
local switch_held = false
local timer = vim.uv.new_timer();
local function restart_timer()
    switch_held = true
    if not timer:is_closing() then
        timer:stop()
        timer:close()
    end
    timer = vim.uv.new_timer()
    timer:start(750, 0, function()
        timer:stop()
        timer:close()
        switch_held = false
    end)
end
km(
    'n',
    '<leader><tab>',
    function()
        vim.cmd('bnext')
        restart_timer()
    end,
    opts('Cycle Buffers')
)
km(
    'n',
    '<leader><S-tab>',
    function()
        vim.cmd('bprevious')
        restart_timer()
    end,
    opts('Cycle Buffers Reversed')
)
km(
    'n',
    '<tab>',
    function()
        if switch_held then
            vim.cmd('bnext')
            restart_timer()
        end
    end,
    opts()
)
km(
    'n',
    '<S-tab>',
    function()
        if switch_held then
            vim.cmd('bprevious')
            restart_timer()
        end
    end,
    opts()
)

for i = 1, 9 do
    km('n', '<leader><leader>' .. i, '<cmd>BufferLineGoToBuffer' .. i .. '<CR>', opts('Goto Buffer ' .. i))
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
km(
    'n',
    '<leader>fg',
    function()
        local function get_git_root()
            local dot_git_path = vim.fn.finddir(".git", ".;")
            return vim.fn.fnamemodify(dot_git_path, ":h")
        end
        -- if we are in a git repo, grep the root of the repo
        -- otherwise grep the cwd
        local git_root = get_git_root()
        if git_root ~= "" then
            tb().live_grep({ cwd = git_root })
        else
            tb().live_grep()
        end
    end,
    opts('Grep Current Working Directory')
)
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
km('n', '<leader>E', function() require('oil').toggle_float(vim.uv.cwd()) end,
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
