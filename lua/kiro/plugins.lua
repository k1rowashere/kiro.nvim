return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            integrations = {
                indent_blankline = { scope_color = 'lavender' },
                mason = true,
                -- aerial = true,
                -- treesitter_context = true,
                -- lsp_trouble = true,
            },
        },
        init = function() vim.cmd('colorscheme catppuccin-mocha') end,
    },
    {
        'stevearc/oil.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        cmd = 'Oil',
        opts = {
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'Telescope' },
    },
    { 'mbbill/undotree',           cmd = { 'UndotreeOpen', 'UndotreeToggle' } },
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        opts = {
            auto_install = true,
            rainbow = {
                enable = true,
                disable = { 'NvimTree', 'packer' },
                extended_mode = true,
            },
            highlight = {
                enable = true,
                disable = { 'NvimTree', 'packer' },
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<M-w>',
                    node_incremental = '<M-w>',
                    node_decremental = '<M-C-w>',
                    scope_incremental = '<M-e>',
                },
            },
        },
        main = 'nvim-treesitter.configs',
    },
    { 'kevinhwang91/nvim-hlslens', opts = {} },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        main = 'ibl',
        opts = {}
    },
    {
        'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'scss', 'javascript', 'html' },
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
        opts = {
            'scss',
            'html',
            css = { rgb_fn = true },
            javascript = { no_names = true },
        },
    },
    { 'lewis6991/satellite.nvim',         opts = {} },
    {
        'gorbit99/codewindow.nvim',
        lazy = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = { z_index = 50 },
    },
    -- lsp stuff
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'williamboman/mason.nvim',          opts = { ui = { border = 'rounded' } } },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            { 'zbirenbaum/copilot.lua', opts = { suggestion = { enabled = false } } },
            { 'zbirenbaum/copilot-cmp', opts = {} },
            {
                'L3MON4D3/LuaSnip',
                init = function()
                    require('luasnip.loaders.from_vscode').lazy_load({
                        paths = './snippets' })
                end,
            },
        },
        init = require('kiro.config.auto_complete'),
    },
    -- {
    --     'folke/trouble.nvim',
    --     lazy = true,
    --     opts = {
    --         action_keys = {
    --             jump = { '<tab.', '<2-leftmouse>' },
    --             jump_close = { '<cr>' },
    --         },
    --     },
    -- },
    -- {
    --     'akinsho/toggleterm.nvim',
    --     keys = '<leader>t',
    --     opts = {
    --         size = 20,
    --         open_mapping = '<leader>t',
    --         insert_mappings = false,
    --     },
    -- },
    -- {
    --     'toppair/peek.nvim',
    --     build = 'deno task --quiet build:fast',
    --     ft = { 'markdown' },
    --     opts = {},
    -- },
    {
        'Shatur/neovim-session-manager',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = function()
            return {
                autosave_ignore_dirs = { '~' },
                autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
            }
        end,
    },
    -- Editing
    { 'kylechui/nvim-surround', opts = {} },
    { 'fedepujol/move.nvim',    cmd = 'MoveLine',      opts = {} },
    { 'windwp/nvim-autopairs',  event = 'InsertEnter', opts = {} },
    -- Fancy UI
    { 'stevearc/dressing.nvim', event = 'VeryLazy',    opts = {} },
    {
        'folke/todo-comments.nvim',
        event = 'BufEnter',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'arkav/lualine-lsp-progress' },
        opts = require('kiro.config.lualine'),
    },

    { 'akinsho/bufferline.nvim', dependencies = 'catppuccin',          opts = require('kiro.config.bufferline'), },
    { 'utilyre/barbecue.nvim',   dependencies = 'SmiteshP/nvim-navic', opts = { theme = 'catppuccin-mocha' } },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
        },
        opts = {},
    },
    -- language specific
    { 'mrcjkb/rustaceanvim', ft = 'rust' },
    { 'folke/neodev.nvim',   priority = 1000, opts = {} },
}
