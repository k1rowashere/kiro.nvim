local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { import = 'kiro.plugins.theme' },
    { import = 'kiro.plugins.lsp' },
    { import = 'kiro.plugins.treesitter' },
    { import = 'kiro.plugins.autocomplete' },
    { import = 'kiro.plugins.lines' },
    {
        'glepnir/dashboard-nvim',
        dev = true,
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'rmagatti/auto-session',
        },
        opts = require('kiro.plugins_config.dashboard'),
    },
    ----------------------------------- Git  -----------------------------------
    { 'tpope/vim-fugitive', cmd = 'Git' },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufEnter',
        opts = require('kiro.plugins_config.gitsigns'),
        config = function(_, opts)
            require('gitsigns').setup(opts)
            -- require('scrollbar.handlers.gitsigns').setup()
        end,
    },
    ---------------------------------- Utils  ----------------------------------
    { 'tpope/vim-repeat', lazy = false },
    {
        'matze/vim-move',
        keys = {
            { mode = { 'v', 'n' }, '<A-j>' },
            { mode = { 'v', 'n' }, '<A-k>' },
            { mode = { 'v', 'n' }, '<A-h>' },
            { mode = { 'v', 'n' }, '<A-l>' },
        },
    },
    { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    {
        'beauwilliams/focus.nvim',
        event = 'WinEnter',
        opts = {
            height = 30,
            quickfixheight = 10,
            excluded_filetypes = { 'fterm', 'term', 'toggleterm' },
            compatible_filetrees = { 'nvimtree', 'undotree' },
        },
    },
    { 'Bekaboo/deadcolumn.nvim', lazy = false },
    {
        'mg979/vim-visual-multi',
        keys = { '<C-n>', '<C-p>', '<C-Down>', '<C-Up>' },
        config = function() vim.cmd('VMTheme nord') end,
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
        },
        opts = {},
    },
    {
        'folke/todo-comments.nvim',
        event = 'BufEnter',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },
    {
        'saifulapm/chartoggle.nvim',
        keys = { 'g,', 'g;' },
        opts = { leader = 'g', keys = { ',', ';' } },
    },
    {
        'kylechui/nvim-surround',
        keys = { 'c', 'd', 'y', { 'S', mode = 'n' } },
        config = true,
    },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
    {
        'folke/which-key.nvim',
        lazy = false,
        config = require('kiro.plugins_config.which-key'),
    },
    ------------------------------ Syntax and LSP ------------------------------
    { 'gorbit99/codewindow.nvim', opts = { z_index = 50 } },
    -------------------------------- Debugging  --------------------------------
    {
        'mfussenegger/nvim-dap',
        config = function() require('kiro.plugins_config.nvim-dap') end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        -- keys = '<leader>db',
        main = 'dapui',
        opts = {},
    },
    { 'folke/trouble.nvim' },
    ----------------------------------------------------------------------------
    {
        'lukas-reineke/indent-blankline.nvim',
        lazy = false,
        config = function() require('kiro.plugins_config.indent') end,
    },
    {
        'lewis6991/satellite.nvim',
        lazy = false,
        opts = {},
    },
    {
        'kevinhwang91/nvim-ufo',
        event = 'BufEnter',
        dependencies = 'kevinhwang91/promise-async',
        opts = function() return require('kiro.plugins_config.nvim-ufo') end,
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        opts = require('kiro.plugins_config.auto-session'),
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = require('kiro.plugins_config.nvim-tree'),
    },
    {
        'mbbill/undotree',
        cmd = { 'UndotreeOpen', 'UndotreeToggle' },
    },
    ----------------------------- Domain Specific  -----------------------------
    {
        'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'javascript', 'html' },
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
        opts = {
            'scss',
            'html',
            css = { rgb_fn = true },
            javascript = { no_names = true },
        },
    },
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        ft = { 'markdown' },
        opts = {},
    },
    { 'folke/neodev.nvim', ft = 'lua', opts = {} },
    ----------------------------- Usless crap (TM) -----------------------------
    { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
    { 'folke/twilight.nvim', cmd = 'Twilight', opts = {} },
}

require('lazy').setup(plugins, { defaults = { lazy = true } })
