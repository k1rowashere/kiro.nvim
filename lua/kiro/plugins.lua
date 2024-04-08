return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            integrations = {
                mason = true,
                -- aerial = true,
                -- treesitter_context = true,
                -- lsp_trouble = true,
            },
        },
        init = function() vim.cmd('colorscheme catppuccin-mocha') end,
    },

    -- Navigation
    {
        'stevearc/oil.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        cmd = 'Oil',
        opts = {
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            win_options = { signcolumn = 'auto:2' }
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'Telescope' },
    },
    { 'mbbill/undotree',                  cmd = { 'UndotreeOpen', 'UndotreeToggle' } },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        opts = {
            open_fold_hl_timeout = 100,
            fold_virt_text_handler = require('kiro.config.ufo').handler,
        },
        init = require('kiro.config.ufo').init,
    },

    -- Git
    { "refractalize/oil-git-status.nvim", dependencies = "stevearc/oil.nvim",        opts = {} },
    {
        "NeogitOrg/neogit",
        branch = 'nightly',
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
        cmd = 'Neogit',
        opts = {}
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufEnter',
        opts = {
            on_attach = require('kiro.config.gitsigns').on_attach,
            current_line_blame = true,
        },
    },

    -- Highlights and Indentation
    {
        'shellRaining/hlchunk.nvim',
        event = 'UiEnter',
        opts = {
            indent = { chars = { '' } },
            blank = { enable = false },
            line_num = { enable = false },
            chunk = { style = { { fg = '#b4beff' }, { fg = '#f38ba9' } } }
        }
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        main = 'rainbow-delimiters.setup',
        opts = {
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterOrange',
                'RainbowDelimiterYellow',
                'RainbowDelimiterGreen',
                'RainbowDelimiterCyan',
                'RainbowDelimiterBlue',
                'RainbowDelimiterViolet',
            },

        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        main = 'nvim-treesitter.configs',
        opts = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<M-w>',
                    node_incremental = '<M-w>',
                    node_decremental = '<M-W>',
                    scope_incremental = '<M-e>',
                },
            },
        },
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
    { 'kevinhwang91/nvim-hlslens',        event = 'BufEnter',                    opts = {} },

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
    { 'kylechui/nvim-surround',   opts = {} },
    { 'fedepujol/move.nvim',      cmd = 'MoveLine',      opts = {} },
    { 'windwp/nvim-autopairs',    event = 'InsertEnter', opts = {} },

    -- Fancy UI
    { 'stevearc/dressing.nvim',   event = 'VeryLazy',    opts = {} },
    { 'folke/todo-comments.nvim', event = 'BufEnter',    dependencies = 'nvim-lua/plenary.nvim', opts = {} },
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
