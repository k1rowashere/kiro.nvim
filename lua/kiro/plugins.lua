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
    { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    {
        'Shatur/neovim-session-manager',
        lazy = false,
        keys = km.session_manager,
        opts = function()
            return {
                autosave_ignore_dirs = { '~', '~/Downloads/**' },
                autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
            }
        end,
    },

    -- Navigation
    -- TODO: configure leap
    -- { 'ggandor/leap.nvim',          keys = { 's', '<Plug>(leap-forward)', mode = { 'n', 'o', 'x' } } },

    { -- loading the plugins in this order is optimal for performance
        'refractalize/oil-git-status.nvim',
        dependencies = {
            'stevearc/oil.nvim',
            opts = {
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                win_options = { signcolumn = 'auto:2' },
                float = { padding = 5 },
                columns = { 'icon', 'size' },
                keymaps = km.oil.active,
            },
        },
        lazy = not vim.iter(vim.fn.argv()):any(vim.fn.isdirectory),
        cmd = 'Oil',
        keys = km.oil.global,
        opts = {},
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'FabianWirth/search.nvim', opts = require('kiro.config.telescope').search_opts },
        cmd = 'Telescope',
        keys = km.telescope,
        opts = require('kiro.config.telescope').opts,
    },
    { 'mbbill/undotree', cmd = { 'UndotreeOpen', 'UndotreeToggle' }, keys = km.undo_tree },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        opts = {
            open_fold_hl_timeout = 100,
            fold_virt_text_handler = require('kiro.config.ufo').handler,
        },
        keys = km.ufo,
    },

    -- Git
    {
        'NeogitOrg/neogit',
        branch = 'nightly',
        dependencies = { 'sindrets/diffview.nvim', 'nvim-telescope/telescope.nvim' },
        cmd = 'Neogit',
        keys = km.neogit,
        opts = {},
    },
    {
        'sindrets/diffview.nvim',
        keys = km.diffview.when_closed,
        opts = { keymaps = { view = km.diffview.when_open, file_panel = km.diffview.when_open } },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = AUTOCMDTEST,
        opts = {
            on_attach = km.gitsigns,
            current_line_blame = true,
            current_line_blame_opts = { virt_text_pos = 'right_align' },
            preview_config = { border = 'rounded' },
        },
    },
    { -- only fot the fancy hunk diff view
        'tanvirtin/vgit.nvim',
        keys = km.vgit,
        opts = {
            keymaps = {},
            settings = {
                scene = { diff_preference = 'split', keymaps = { quit = 'q' } },
                live_blame = { enabled = false },
                live_gutter = { enabled = false },
            },
        },
    },

    -- Highlights and Indentation
    {
        'shellRaining/hlchunk.nvim',
        event = AUTOCMDTEST,
        opts = {
            indent = { chars = { '' } },
            blank = { enable = false },
            line_num = { enable = false },
            chunk = { style = { { fg = '#b4beff' }, { fg = '#f38ba9' } } },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        main = 'nvim-treesitter.configs',
        dependencies = {
            'HiPhish/rainbow-delimiters.nvim',
            main = 'rainbow-delimiters.setup',
            opts = {
                highlight = vim.iter({ 'Red', 'Orange', 'Yellow', 'Green', 'Cyan', 'Blue', 'Violet' })
                    :map(function(c) return 'RainbowDelimiter' .. c end)
                    :totable(),
            },
        },
        opts = {
            incremental_selection = { enable = true, keymaps = km.treesitter },
            highlight = { enable = true },
        },
    },
    { 'brenoprata10/nvim-highlight-colors', event = AUTOCMDTEST, opts = {} },
    { 'dstein64/nvim-scrollview', event = AUTOCMDTEST, main = 'scrollview.contrib.gitsigns', opts = {} },
    { 'kevinhwang91/nvim-hlslens', keys = { '/', '?' }, opts = {} },

    -- Lsp stuff
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- { 'williamboman/mason-lspconfig.nvim' },
            { dir = '~/Projects/mason-lspconfig.nvim' },
            { 'williamboman/mason.nvim', opts = { ui = { border = 'rounded' } } },
        },
        config = require('kiro.config.lsp'),
    },
    {
        'SmiteshP/nvim-navbuddy',
        dependencies = { 'SmiteshP/nvim-navic', 'MunifTanjim/nui.nvim' },
        cmd = 'Navbuddy',
        keys = km.navbuddy,
        opts = { lsp = { auto_attach = true }, window = { border = 'rounded' } },
    },
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        opts = {
            formatters_by_ft = { lua = { 'stylua' } },
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
    },
    { 'utilyre/barbecue.nvim', event = AUTOCMDTEST, dependencies = 'SmiteshP/nvim-navic', opts = {} },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'petertriho/cmp-git',
            'onsails/lspkind.nvim',
            'saadparwaiz1/cmp_luasnip',
            { 'zbirenbaum/copilot.lua', opts = { suggestion = { enabled = false }, panel = { enabled = false } } },
            { 'zbirenbaum/copilot-cmp', opts = {} },
            {
                'L3MON4D3/LuaSnip',
                dependencies = 'rafamadriz/friendly-snippets',
                config = function() require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' }) end,
                build = 'make install_jsregexp',
            },
        },
        config = require('kiro.config.auto_complete'),
    },
    {
        'folke/trouble.nvim',
        keys = km.trouble,
        opts = {
            focus = true,
            position = 'left',
            action_keys = { jump_close = { '<cr>' } },
        },
    },
    { -- TODO: replace with ???
        'Zeioth/compiler.nvim',
        dependencies = {
            'stevearc/overseer.nvim',
            commit = '68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0',
            cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
            opts = {
                task_list = {
                    direction = 'bottom',
                    min_height = 25,
                    max_height = 25,
                    default_detail = 1,
                },
            },
        },
        cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
        opts = {},
    },

    -- Editing
    {
        'kylechui/nvim-surround',
        keys = { 'ys', 'cs', 'ds', { 'S', mode = 'v' }, { '<c-g>', mode = 'i' } },
        opts = {},
    },
    { 'fedepujol/move.nvim', keys = km.move, opts = {} },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
    { 'numToStr/Comment.nvim', keys = km.comment, opts = {} },

    -- Fancy UI
    { 'akinsho/toggleterm.nvim', keys = km.toggleterm, opts = { open_mapping = km.toggleterm } },
    { 'goolord/alpha-nvim', opts = require('kiro.config.alpha') },
    { 'stevearc/dressing.nvim', event = 'VeryLazy', opts = {} },
    { 'folke/todo-comments.nvim', event = AUTOCMDTEST, opts = {} },
    {
        'akinsho/bufferline.nvim',
        event = AUTOCMDTEST,
        keys = km.bufferline,
        opts = {
            options = {
                separator_style = { '', '' },
                indicator = { style = 'underline' },
                diagnostics_indicator = function(count, _, _, _) return '(' .. count .. ')' end,
                hover = { enabled = true, delay = 200, reveal = { 'close' } },
                offsets = { { filetype = 'undotree', text = 'Undo Tree', text_align = 'left', separator = true } },
                numbers = 'ordinal',
                diagnostics = 'nvim_lsp',
            },
            highlights = function()
                return vim.tbl_map(
                    function(val) return vim.tbl_extend('keep', val, { sp = '#f2ad84' }) end,
                    require('catppuccin.groups.integrations.bufferline').get()()
                )
            end,
        },
    },
    { 'nvim-lualine/lualine.nvim', dependencies = 'arkav/lualine-lsp-progress', opts = require('kiro.config.lualine') },
    { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },
    { 'Eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },

    -- language specific
    { 'mrcjkb/rustaceanvim', ft = 'rust' },
    { 'folke/neodev.nvim', ft = 'lua', opts = {} },
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
