local utils = require('kiro.utils')
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
        keys = km.session_manager,
        opts = function()
            return {
                autosave_ignore_dirs = { '~' },
                autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
            }
        end,
    },

    -- Navigation
    {
        -- loading the plugins in this order is optimal for performance
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
        cmd = 'Oil',
        keys = km.oil,
        opts = {}
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'FabianWirth/search.nvim',
                opts = function()
                    local builtin = require('telescope.builtin')


                    return {
                        tabs = {},
                        collections = {
                            git = {
                                tabs = {
                                    {
                                        'Commits',
                                        builtin.git_commits,
                                        available = function() return vim.fn.isdirectory('.git') end
                                    },
                                    { name = "Branches", tele_func = builtin.git_branches },
                                }
                            },
                            files = {
                                tabs = {
                                    { 'Buffers',      tele_func = builtin.buffers },
                                    { 'Files',        tele_func = builtin.find_files },
                                    { 'Recent Files', tele_func = builtin.oldfiles },
                                    {
                                        'Grep',
                                        tele_func = function()
                                            if utils.is_git_repo() then
                                                builtin.live_grep({ cwd = utils.git_root() })
                                            else
                                                builtin.live_grep()
                                            end
                                        end
                                    },
                                    { 'Fzf', tele_func = builtin.current_buffer_fuzzy_find },
                                },
                            }
                        }
                    }
                end
            }
        },
        cmd = 'Telescope',
        keys = km.telescope,
        opts = function()
            local trouble = require('trouble.providers.telescope')
            return {
                defaults = {
                    mappings = {
                        i = { ["<c-t>"] = trouble.open_with_trouble },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
                    }
                },
            }
        end
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
        'lewis6991/gitsigns.nvim',
        event = 'BufEnter *?',
        opts = {
            on_attach = km.gitsigns,
            current_line_blame = true,
        },
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
    { 'kevinhwang91/nvim-hlslens',        keys = { '/', '?' }, opts = {} },

    -- lsp stuff
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'williamboman/mason.nvim',          cmd = 'Mason',       opts = { ui = { border = 'rounded' } } },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'petertriho/cmp-git',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            { 'zbirenbaum/copilot.lua', opts = { suggestion = { enabled = false } } },
            { 'zbirenbaum/copilot-cmp', opts = {} },
            {
                'L3MON4D3/LuaSnip',
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
                end,
            },
        },
        config = require('kiro.config.auto_complete'),
    },
    -- TODO: Upgrade to beta
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
        keys = { 'ys', 'cs', 'ds', { 'S', mode = 'v' }, { '<C-g>', mode = 'i' } },
        opts = {}
    },
    { 'fedepujol/move.nvim',      keys = km.move,        opts = {} },
    { 'windwp/nvim-autopairs',    event = 'InsertEnter', opts = {} },

    -- Fancy UI
    { 'stevearc/dressing.nvim',   event = 'VeryLazy',    opts = {} },
    { 'folke/todo-comments.nvim', event = 'BufEnter *?', dependencies = 'nvim-lua/plenary.nvim', opts = {} },
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufEnter',
        dependencies = 'arkav/lualine-lsp-progress',
        opts = require('kiro.config.lualine'),
    },

    { 'akinsho/bufferline.nvim', lazy = false, keys = km.bufferline, opts = require('kiro.config.bufferline'), },
    {
        'utilyre/barbecue.nvim',
        event = 'BufEnter *?',
        dependencies = 'SmiteshP/nvim-navic',
        opts = { theme = 'catppuccin-mocha' }
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'x', 'n' }, desc = 'Toggle Line Comment' },
            { 'gb', mode = { 'x', 'n' }, desc = 'Toggle Block Comment' },
        },
        opts = {},
    },

    -- language specific
    { 'mrcjkb/rustaceanvim',     ft = 'rust' },
    { 'folke/neodev.nvim',       ft = 'lua',   opts = {} },
    {
        "luckasRanarison/tailwind-tools.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        event = 'VeryLazy',
        opts = {}
    },
}
