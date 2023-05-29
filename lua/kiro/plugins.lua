return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('kiro.plugins_config.telescope')
        end
    }

    use 'tpope/vim-fugitive'

    use { 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('kiro.plugins_config.nvim-treesitter')
        end
    }

    use 'nvim-treesitter/nvim-treesitter-context'
    use 'mrjones2014/nvim-ts-rainbow'

    use { 'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = function()
            require('kiro.plugins_config.nvim-ufo')
        end
    }

    -- use('github/copilot.vim')
    use { 'zbirenbaum/copilot.lua',
        -- cmd = 'Copilot',
        -- event = 'InsertEnter',
        config = function()
            require('copilot').setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    }

    use { 'zbirenbaum/copilot-cmp',
        after = { 'copilot.lua' },
        config = function()
            require('copilot_cmp').setup()
        end
    }

    use { 'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        after = 'copilot-cmp',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            require('kiro.plugins_config.lsp-zero')
        end,
    }


    use 'onsails/lspkind.nvim'

    use { 'L3MON4D3/LuaSnip',
        run = 'make install_jsregexp'
    }

    use { 'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    -- use 'folke/lsp-colors.nvim'

    use { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'cuducos/yaml.nvim',
        ft = { 'yaml' }, -- optional
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim' -- optional
        },
    }

    use { 'toppair/peek.nvim', run = 'deno task --quiet build:fast',
        config = function()
            require('peek').setup()
        end
    }

    use { 'kylechui/nvim-surround',
        tag = '*',
        config = function()
            require('nvim-surround').setup({
            })
        end
    }

    use 'gennaro-tedesco/nvim-peekup'

    use 'nvim-tree/nvim-web-devicons'

    use { 'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require('kiro.plugins_config.nvim-tree')
        end
    }

    use { 'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }
    -- use 'vim-airline/vim-airline' use 'vim-airline/vim-airline-themes'

    use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'gruvbox',
                    disabled_filetypes = {
                        statusline = { 'NvimTree', 'packer' } },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                -- tabline = {},
                extensions = { 'fugitive', 'nvim-tree', 'trouble' }
            }
        end
    }

    use { "luukvbaal/statuscol.nvim",
        config = function()
            -- local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- configuration goes here, for example:
                -- relculright = true,
                -- segments = {
                --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                --   {
                --     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
                --     click = "v:lua.ScSa"
                --   },
                --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                --   {
                --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                --     click = "v:lua.ScSa"
                --   },
                -- }
            })
        end,
    }

    -- use { 'alvarosevilla95/luatab.nvim',
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function()
    --         require('luatab')
    --             .setup()
    --     end }


    use { 'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup { options = {
                mode = 'buffers',
                separator_style = 'thick',
                hover = {
                    enabled = true,
                    delay = 100,
                    reveal = { 'close' }
                },
                offsets = {
                    {
                        filetype = 'NvimTree',
                        text = 'File Explorer',
                        text_align = 'left',
                        separator = true,
                    }
                },
                numbers = 'ordinal',
                diagnostics = 'nvim_lsp',
            } }
        end }

    use {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup({})
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
            require('scrollbar.handlers.gitsigns').setup()
        end
    }

    use {
        'kevinhwang91/nvim-hlslens',
        config = function()
            -- require('hlslens').setup() is not required
            require('scrollbar.handlers.search').setup()
        end,
    }

    use {
        'https://git.sr.ht/~nedia/auto-format.nvim',
        config = function()
            require('auto-format').setup()
        end
    }

    use {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'error',
                auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
                bypass_session_save_file_types = { 'NvimTree', 'packer' },
                post_restore_cmds = { require('nvim-tree.api').tree.open },
                pre_save_cmds = { require('nvim-tree.api').tree.close },
            }
        end
    }

    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {}
        end
    }

    use {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use('mbbill/undotree')

    use({
        'utilyre/barbecue.nvim',
        tag = '*',
        requires = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons', -- optional dependency
        },
        after = 'nvim-web-devicons',       -- keep this if you're using NvChad
        config = function()
            require('barbecue').setup()
        end,
    })

    use 'Bekaboo/deadcolumn.nvim'

    use {
        'gorbit99/codewindow.nvim',
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup({
                minimap_width = 10,
                width_multiplier = 4,
                auto_enable = false,
                exclude_filetypes = {
                    'NvimTree',
                    'packer',
                    'Trouble',
                    'dashboard',
                    'help'
                },

            })
            codewindow.apply_default_keybinds()
        end,
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                -- for example, context is off by default, use this to turn it on
                show_current_context           = true,
                show_current_context_start     = true,
                -- use_treesitter             = true,
                -- show_first_indent_level    = false,
                show_trailing_blankline_indent = false
            })
        end
    }

    use {
        'luisiacc/gruvbox-baby',
        branch = 'main',
        config = function()
            vim.cmd('colorscheme gruvbox-baby')
            vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
        end
    }

    -- use({
    --     'karb94/neoscroll.nvim',
    --     config = function()
    --         require('neoscroll').setup()
    --     end
    -- })

    -- use { 'gen740/SmoothCursor.nvim',
    --     config = function()
    --         require('smoothcursor').setup()
    --     end
    -- }

    -- use {
    --     'glepnir/dashboard-nvim',
    --     event = 'VimEnter',
    --     config = function()
    --         require('dashboard').setup {
    --             -- config
    --         }
    --     end,
    --     requires = { 'nvim-tree/nvim-web-devicons' }
    -- }
end)
