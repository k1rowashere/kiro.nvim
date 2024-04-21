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
            pin = true, -- FIXME: temp fix for a bug in latest commit
            opts = {
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                win_options = { signcolumn = 'auto:2' },
                float = { padding = 5 },
                columns = { 'icon', 'size' },
                keymaps = km.oil.active,
            }
        },
        lazy = not vim.iter(vim.fn.argv()):any(vim.fn.isdirectory),
        cmd = 'Oil',
        keys = km.oil.global,
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
        event = { 'BufEnter', 'BufRead' },
        main = 'nvim-treesitter.configs',
        opts = {
            incremental_selection = {
                enable = true,
                keymaps = km.treesitter
            },
            highlight = { enable = true },
        },
    },
    { 'brenoprata10/nvim-highlight-colors', event = 'BufEnter *?', opts = {} },
    { 'dstein64/nvim-scrollview',           event = 'BufEnter *?', main = 'scrollview.contrib.gitsigns', opts = {} },
    { 'kevinhwang91/nvim-hlslens',          keys = { '/', '?' },   opts = {} },

    -- Lsp stuff
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "SmiteshP/nvim-navbuddy",
            dependencies = { "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
            lazy = false,
            keys = km.navbuddy,
            opts = { lsp = { auto_attach = true }, window = { border = 'rounded' } }
        },
        event = 'BufEnter *?'
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'williamboman/mason.nvim',          cmd = 'Mason', opts = { ui = { border = 'rounded' } } },
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

    -- Compiling, Running and debugging
    { -- This plugin
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim" },
        opts = {},
    },
    { -- The task runner we use
        "stevearc/overseer.nvim",
        commit = "68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1
            },
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
    { 'akinsho/toggleterm.nvim',  keys = km.toggleterm,               opts = { open_mapping = km.toggleterm } },
    { 'goolord/alpha-nvim',       opts = require('kiro.config.alpha') },
    { 'stevearc/dressing.nvim',   event = 'VeryLazy',                 opts = {} },
    { 'folke/todo-comments.nvim', event = 'BufEnter *?',              dependencies = 'nvim-lua/plenary.nvim', opts = {} },
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufEnter',
        dependencies = 'arkav/lualine-lsp-progress',
        opts = require('kiro.config.lualine'),
    },
    { 'akinsho/bufferline.nvim',         event = 'VimEnter',       keys = km.bufferline, opts = require('kiro.config.bufferline') },
    {
        'utilyre/barbecue.nvim',
        event = 'BufEnter *?',
        dependencies = 'SmiteshP/nvim-navic',
        opts = {}
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
        },
        opts = {},
    },
    { 'folke/which-key.nvim',            event = 'VeryLazy',       opts = {} },
    { 'Eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },

    -- language specific
    { 'mrcjkb/rustaceanvim',             ft = 'rust' },
    { 'folke/neodev.nvim',               ft = 'lua',               opts = {} },
    {
        'luckasRanarison/tailwind-tools.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        ft = { 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'rust' },
        opts = { document_color = { enabled = false } },
    },
    {
        'razak17/tailwind-fold.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        ft = { 'html', 'rust', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
        opts = { min_chars = 30 },
    },
}
