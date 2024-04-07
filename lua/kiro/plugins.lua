return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            integrations = {
                -- indent_blankline = { scope_color = 'lavender' },
                -- aerial = true,
                -- mason = true,
                -- treesitter_context = true,
                -- lsp_trouble = true,
            },
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme('catppuccin-mocha')
        end,
    },
    { 'stevearc/oil.nvim', dependencies = 'nvim-tree/nvim-web-devicons', cmd = 'Oil', opts = {} },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'Telescope' },
    },
    { 'mbbill/undotree',   cmd = { 'UndotreeOpen', 'UndotreeToggle' } },
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
    -- lsp stuff
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Autocomplete
    -- 'ms-jpq/coq_nvim',
    -- 'ms-jpq/coq.artifacts',
    -- {
    --     'ms-jpq/coq.thirdparty',
    --     setup = function(_, _)
    --         require("coq_3p") {
    --             { src = "nvimlua", short_name = "nLUA", conf_only = true },
    --             { src = "vimtex",  short_name = "vTEX" },
    --             { src = "copilot", short_name = "COP",  accept_key = "<c-f>" },
    --             { src = "codeium", short_name = "COD" }, }
    --     end
    -- },
    {
        'hrsh7th/nvim-cmp',
        -- enabled = false,
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
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load({
                        paths = './snippets',
                        fix_pairs = true,
                    })
                end,
            },
        },
        config = require('kiro.config.auto_complete'),
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
    -- {
    --     'saecki/crates.nvim',
    --     event = { 'BufRead Cargo.toml' },
    --     -- WARN: 'null-ls' is archived and may break at any moment
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         'jose-elias-alvarez/null-ls.nvim',
    --     },
    --     opts = {
    --         null_ls = { enabled = true },
    --         src = { cmp = { enabled = true } },
    --     },
    --     init = init,
    -- },
    {
        'Shatur/neovim-session-manager',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = { autosave_ignore_dirs = { '~' } },
        config = function(_, opts)
            opts.autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
            require('session_manager').setup(opts)
        end,
        init = function()
            -- Auto save session
            vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                callback = function()
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        -- Don't save while there's any 'nofile' buffer open.
                        if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'nofile' then
                            return
                        end
                    end
                    require('session_manager').save_current_session()
                end,
            })
        end,
    },
    'tpope/vim-repeat',
    {
        'kylechui/nvim-surround',
        config = true,
        keys = { 'c', 'd', 'y',
            { 'S', mode = 'x' } }
    },
    { 'fedepujol/move.nvim',    config = true },
    { 'windwp/nvim-autopairs',  event = 'InsertEnter', config = true },
    { 'stevearc/dressing.nvim', event = 'VeryLazy',    config = true },
    {
        'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'arkav/lualine-lsp-progress',
        },
        opts = require('kiro.config.lualine'),
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
        },
        config = true,
    },
    {
        'folke/todo-comments.nvim',
        event = 'BufEnter',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },
    -- language specific
    { 'mrcjkb/rustaceanvim', ft = 'rust' },
    { 'folke/neodev.nvim',   priority = 1000, config = true },
}
