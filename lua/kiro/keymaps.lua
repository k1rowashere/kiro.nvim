local n_opts = { silent = true, noremap = true }
local t_opts = { silent = true }
local keymap = vim.keymap.set

-- TODO: move to plugin (should work with any language)
local function header_comment(str, line_len)
    -- remove trailing and leading whitespace
    str = str:gsub('^%s*(.-)%s*$', '%1')
    local dash_count = (line_len - string.len(str) - 2) / 2
    if string.len(str) % 2 == 1 then
        str = str .. ' '
    end

    return string.rep('-', dash_count) ..
        ' ' .. str .. ' '
        .. string.rep('-', dash_count)
end

function Replace_with_header()
    local line = vim.api.nvim_get_current_line()
    local indent = line:match('^%s+') or ''
    local match = line:match('^%s*%-%-([^%-].+)%-%-$')
    if match then
        vim.api.nvim_set_current_line(indent ..
            header_comment(match, 80 - string.len(indent)))
    end
end

vim.cmd [[
    augroup CommentHeader
        autocmd!
        autocmd TextChanged,TextChangedI * lua Replace_with_header()
        augroup END
]]

vim.g.mapleader = ' '


-- Word kill
keymap('i', '<C-BS>', '<C-w>')
keymap('i', '<M-BS>', '<C-w>')
keymap('i', '<C-Del>', '<esc>dei', n_opts)

-- Shift Select
keymap('n', '<S-Up>', 'v<Up>', n_opts)
keymap('n', '<S-Down>', 'v<Down>', n_opts)
keymap('n', '<S-Left>', 'v<Left>', n_opts)
keymap('n', '<S-Right>', 'v<Right>', n_opts)
keymap('v', '<S-Up>', '<Up>', n_opts)
keymap('v', '<S-Down>', '<Down>', n_opts)
keymap('v', '<S-Left>', '<Left>', n_opts)
keymap('v', '<S-Right>', '<Right>', n_opts)
keymap('i', '<S-Up>', '<Esc>v<Up>', n_opts)
keymap('i', '<S-Down>', '<Esc>v<Down>', n_opts)
keymap('i', '<S-Left>', '<Esc>v<Left>', n_opts)
keymap('i', '<S-Right>', '<Esc>v<Right>', n_opts)

keymap('n', '<C-S-Up>', 'v<Up>', n_opts)
keymap('n', '<C-S-Down>', 'v<Down>', n_opts)
keymap('n', '<C-S-Left>', 'v<C-Left>', n_opts)
keymap('n', '<C-S-Right>', 'v<C-Right>', n_opts)
keymap('v', '<C-S-Up>', '<Up>', n_opts)
keymap('v', '<C-S-Down>', '<Down>', n_opts)
keymap('v', '<C-S-Left>', '<Left>', n_opts)
keymap('v', '<C-S-Right>', '<Right>', n_opts)
keymap('i', '<C-S-Up>', '<Esc>v<Up>', n_opts)
keymap('i', '<C-S-Down>', '<Esc>v<Down>', n_opts)
keymap('i', '<C-S-Left>', '<Esc>v<C-Left>', n_opts)
keymap('i', '<C-S-Right>', '<Esc>v<C-Right>', n_opts)

-- Normal mode
keymap('n', '<esc>', vim.cmd.noh, n_opts)

--void paste
-- keymap('x', '<leader>p', [["_dP]])
-- keymap({ 'n', 'v' }, '<leader>d', [["_d]])

-- tab navigation
keymap('n', '<leader><Tab>', ':BufferLineCycleNext<CR>', n_opts)
keymap('n', '<leader><S-Tab>', ':BufferLineCyclePrev<CR>', n_opts)
for i = 1, 9, 1 do
    keymap(
        'n', '<leader><leader>' .. i,
        function() require("bufferline").go_to(i, true) end,
        { silent = true, desc = "Goto buffer " .. i }
    )
end

-- close buffer
keymap('n', '<leader>q', ':bd<CR>', n_opts)


-- Move lines
keymap('n', '<A-j>', ':m .+1<CR>==', n_opts)
keymap('n', '<A-k>', ':m .-2<CR>==', n_opts)

-- Better window navigation
keymap('n', '<A-Left>', '<C-w>h', n_opts)
keymap('n', '<A-Down>', '<C-w>j', n_opts)
keymap('n', '<A-Up>', '<C-w>k', n_opts)
keymap('n', '<A-Right>', '<C-w>l', n_opts)

keymap('n', '<leader>e',
    function() require('nvim-tree.api').tree.toggle() end,
    { silent = true, desc = 'Toggle Nvimtree' }
)
keymap('n', '<leader>d',
    function() require('trouble').toggle() end,
    { silent = true, desc = 'Toggle Diagnostics' }
)
keymap('n', '<leader>u', ':UndotreeToggle<CR>',
    { silent = true, desc = 'Toggle Undotree', noremap = true, }
)


-- Visual mode
-- Move lines
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", n_opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", n_opts)

-- Visual selection
local surround_map = function(char)
    keymap('v', '<leader>' .. char, '<Plug>(nvim-surround-visual)' .. char, n_opts)
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
