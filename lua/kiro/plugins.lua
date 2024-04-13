local km = require('kiro.keymaps')

return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            integrations = { mason = true },
        },
        init = function() vim.cmd.colorscheme('catppuccin-mocha') end,
    },
    { 'nvim-tree/nvim-web-devicons' },
    {
        'Shatur/neovim-session-manager',
        dependencies = 'nvim-lua/plenary.nvim',
        lazy = false,
        priority = 1001,
        keys = km.session_manager,
        opts = function()
            return {
                autosave_ignore_dirs = { '~', '~/Downloads/**' },
                autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
            }
        end,
    },

    -- Navigation
    { -- loading the plugins in this order is optimal for performance
        'refractalize/oil-git-status.nvim',
        dependencies = {
            'stevearc/oil.nvim',
            opts = {
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                win_options = { signcolumn = 'auto:2' },
                keymaps = { ['q'] = 'actions.close' }
            }
        },
        lazy = not vim.list_contains(vim.v.argv, '.'),
        cmd = 'Oil',
        keys = km.oil,
        opts = {}
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'FabianWirth/search.nvim', opts = require('kiro.config.telescope').search_opts }
        },
        cmd = 'Telescope',
        keys = km.telescope,
        opts = require('kiro.config.telescope').opts,
    },
    { 'mbbill/undotree',            cmd = { 'UndotreeOpen', 'UndotreeToggle' }, keys = km.undo_tree },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        opts = {
            open_fold_hl_timeout = 100,
            fold_virt_text_handler = require('kiro.config.ufo').handler,
        },
        keys = km.ufo,
        init = require('kiro.config.ufo').init,
    },

    -- Git
    {
        'NeogitOrg/neogit',
        branch = 'nightly',
        dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'nvim-telescope/telescope.nvim' },
        cmd = 'Neogit',
        keys = km.neogit,
        opts = {}
    },
    {
        'sindrets/diffview.nvim',
        keys = km.diffview.when_closed,
        opts = { keymaps = { view = km.diffview.when_open, file_panel = km.diffview.when_open } }
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufEnter *?',
        opts = {
            on_attach = km.gitsigns,
            current_line_blame = true,
            current_line_blame_opts = { virt_text_pos = 'right_align' },
            preview_config = { border = 'rounded' },
        }
    },
    { -- only fot the fancy hunk diff view
        'tanvirtin/vgit.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        keys = km.vgit,
        opts = {
            keymaps = {},
            settings = {
                scene = { diff_preference = 'split', keymaps = { quit = 'q' } },
                live_blame = { enabled = false },
                live_gutter = { enabled = false },
            }
        }
    },

    -- Highlights and Indentation
    {
        'shellRaining/hlchunk.nvim',
        event = 'BufEnter *?',
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
        event = 'BufEnter *?',
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
                keymaps = km.treesitter
            }
        },
    },
    { 'brenoprata10/nvim-highlight-colors', event = 'BufEnter *?', opts = {} },
    { 'lewis6991/satellite.nvim',           event = 'BufEnter *?', opts = {} },
    { 'kevinhwang91/nvim-hlslens',          keys = { '/', '?' },   opts = {} },

    -- Lsp stuff
    { 'neovim/nvim-lspconfig',              event = 'BufEnter *?' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'williamboman/mason.nvim',            cmd = 'Mason',         opts = { ui = { border = 'rounded' } } },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-nvim-lsp',
            'petertriho/cmp-git', 'onsails/lspkind.nvim', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets',
            { 'zbirenbaum/copilot.lua', opts = { suggestion = { enabled = false } } },
            { 'zbirenbaum/copilot-cmp', opts = {} },
            {
                'L3MON4D3/LuaSnip',
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
                end,
                build = 'make install_jsregexp'
            },
        },
        config = require('kiro.config.auto_complete'),
    },
    {
        'folke/trouble.nvim',
        keys = km.trouble,
        opts = {
            focus = true,
            position = 'right',
            action_keys = { jump_close = { '<cr>' } },
        },
    },

    -- Editing
    {
        'kylechui/nvim-surround',
        keys = { 'ys', 'cs', 'ds', { 'S', mode = 'v' }, { '<c-g>', mode = 'i' } },
        opts = {}
    },
    { 'fedepujol/move.nvim',      keys = km.move,                     opts = {} },
    { 'windwp/nvim-autopairs',    event = 'InsertEnter',              opts = {} },

    -- Fancy UI
    { 'goolord/alpha-nvim',       opts = require('kiro.config.alpha') },
    { 'stevearc/dressing.nvim',   event = 'VeryLazy',                 opts = {} },
    { 'folke/todo-comments.nvim', event = 'BufEnter *?',              dependencies = 'nvim-lua/plenary.nvim', opts = {} },
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufEnter',
        dependencies = 'arkav/lualine-lsp-progress',
        opts = require('kiro.config.lualine'),
    },
    { 'akinsho/bufferline.nvim', event = 'VimEnter',    keys = km.bufferline,                 opts = require('kiro.config.bufferline') },
    { 'utilyre/barbecue.nvim',   event = 'BufEnter *?', dependencies = 'SmiteshP/nvim-navic', opts = { theme = 'catppuccin-mocha' } },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
        },
        opts = {},
    },
    { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },

    -- language specific
    { 'mrcjkb/rustaceanvim',  ft = 'rust' },
    { 'folke/neodev.nvim',    ft = 'lua',         opts = {} },
    {
        "luckasRanarison/tailwind-tools.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        event = 'VeryLazy',
        opts = {}
    },
}
