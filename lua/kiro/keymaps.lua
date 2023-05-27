local n_opts = { silent = true, noremap = true }
local t_opts = { silent = true }

local keymap = vim.keymap.set

vim.g.mapleader = ' '
keymap("n", "<C-_>", function() require('Comment.api').toggle.linewise.current() end, n_opts)

-- Normal mode
-- Move lines
keymap('n', '<A-j>', ':m .+1<CR>==', n_opts)
keymap('n', '<A-k>', ':m .-2<CR>==', n_opts)

-- Better window navigation
keymap('n', '<A-Left>', '<C-w>h', n_opts)
keymap('n', '<A-Down>', '<C-w>j', n_opts)
keymap('n', '<A-Up>', '<C-w>k', n_opts)
keymap('n', '<A-Right>', '<C-w>l', n_opts)
-- toggle terminal
keymap('n', '<leader>t', '<C-w>s <C-w>10- :term<CR>', n_opts)


-- Visual mode
-- Move lines
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", n_opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", n_opts)

-- Terminal mode
keymap('t', '<esc>', '<C-\\><C-N>', t_opts)
keymap('t', '<A-Left>', '<C-\\><C-N><C-w>h', t_opts)
keymap('t', '<A-Down>', '<C-\\><C-N><C-w>j', t_opts)
keymap('t', '<A-Up>', '<C-\\><C-N><C-w>k', t_opts)
keymap('t', '<A-Right>', '<C-\\><C-N><C-w>l', t_opts)
