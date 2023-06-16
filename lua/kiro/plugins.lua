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
    { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1000 },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = false,
        priority = 1000,
        opts = {
            highlight_groups = {
                ColorColumn = { bg = 'rose' },
                CursorLine = { bg = 'foam', blend = 5 },
            },
        },
        config = function(_, opts)
            require('rose-pine').setup(opts)
            vim.cmd('set termguicolors')
            vim.cmd([[colorscheme rose-pine]])
            vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
        end,
    },
    {
        'xiyaowong/transparent.nvim',
        lazy = false,
        priority = 100,
        opts = require('kiro.plugins_config.transparent'),
    },
    ----------------------------------- Git  -----------------------------------
    { 'tpope/vim-fugitive', cmd = 'Git' },
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        opts = require('kiro.plugins_config.gitsigns'),
        config = function(_, opts)
            require('gitsigns').setup(opts)
            require('scrollbar.handlers.gitsigns').setup()
        end,
    },
    ---------------------------------- Utils  ----------------------------------
    { 'tpope/vim-repeat', lazy = false },
    { 'fedepujol/move.nvim', cmd = { 'MoveLine', 'MoveBlock' } },
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
        config = function()
            vim.cmd('VMTheme nord')
        end,
    },
    {
        'numToStr/Comment.nvim',
        keys = { { 'g', mode = { 'v', 'n' } } },
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
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        dependencies = 'mrjones2014/nvim-ts-rainbow',
        opts = require('kiro.plugins_config.nvim-treesitter'),
        main = 'nvim-treesitter.configs',
    },
    { 'nvim-treesitter/nvim-treesitter-context', lazy = false },
    {
        'ckolkey/ts-node-action',
        dependencies = { 'nvim-treesitter' },
        opts = {},
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = false,
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'jose-elias-alvarez/null-ls.nvim' },

            -- Autocompletion
            { 'onsails/lspkind.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Copilot
            {
                'zbirenbaum/copilot.lua',
                opts = {
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                },
            },
            {
                'zbirenbaum/copilot-cmp',
                dependencies = 'nvim-tree/nvim-web-devicons',
                config = true,
            },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            require('kiro.plugins_config.lsp-zero')
        end,
    },
    -------------------------------- Debugging  --------------------------------
    {
        'mfussenegger/nvim-dap',
        config = function()
            require('kiro.plugins_config.nvim-dap')
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        keys = '<leader>db',
        config = function()
            require('dapui').setup()
        end,
    },
    { 'folke/trouble.nvim' },
    ----------------------------------------------------------------------------
    {
        'lukas-reineke/indent-blankline.nvim',
        lazy = false,
        config = function()
            require('kiro.plugins_config.indent')
        end,
    },
    {
        'petertriho/nvim-scrollbar',
        opts = {
            handlers = {
                gitsigns = true,
                search = true,
            },
        },
    },
    {
        'kevinhwang91/nvim-ufo',
        event = 'BufEnter',
        dependencies = 'kevinhwang91/promise-async',
        opts = function()
            return require('kiro.plugins_config.nvim-ufo')
        end,
    },
    {
        'kevinhwang91/nvim-hlslens',
        config = function()
            require('scrollbar.handlers.search').setup()
        end,
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
    {
        'akinsho/bufferline.nvim',
        event = 'ColorScheme',
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = require('kiro.plugins_config.bufferline'),
        config = function(_, opts)
            require('bufferline').setup(opts)
            vim.g.transparent_groups = vim.list_extend(
                vim.g.transparent_groups or {},
                vim.tbl_map(function(v)
                    return v.hl_group
                end, vim.tbl_values(
                    require('bufferline.config').highlights
                ))
            )
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'arkav/lualine-lsp-progress',
        },
        opts = function()
            return require('kiro.plugins_config.lualine')
        end,
    },
    {
        'luukvbaal/statuscol.nvim',
        lazy = false,
        opts = function()
            return require('kiro.plugins_config.statuscol')
        end,
    },
    {
        'utilyre/barbecue.nvim',
        lazy = false,
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        opts = { theme = { normal = { bg = 'none' } } },
    },
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
