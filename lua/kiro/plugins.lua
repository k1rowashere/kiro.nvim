return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'tpope/vim-fugitive'

    use { 'luisiacc/gruvbox-baby', branch = 'main',
        config = function()
            vim.cmd('colorscheme gruvbox-baby')
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, }

    use 'nvim-treesitter/nvim-treesitter-context'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
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
        }
    }

    use {
        'folke/trouble.nvim',
        requires = {
            { 'nvim-tree/nvim-web-devicons' }
        }
    }

    use 'folke/lsp-colors.nvim'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        "cuducos/yaml.nvim",
        ft = { "yaml" }, -- optional
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim" -- optional
        },
    }

    use { 'toppair/peek.nvim', run = 'deno task --quiet build:fast',
        config = function()
            require('peek').setup()
        end
    }

    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup({
            })
        end
    })

    use 'gennaro-tedesco/nvim-peekup'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require("nvim-tree").setup {
                --max window width
                view = {
                    signcolumn = "no",
                    width = 25,
                    side = 'left',
                },
                renderer = {
                    indent_markers = {
                        enable = true,
                    },
                    highlight_git = true,
                    icons = {
                        glyphs = {
                            git = {
                                unstaged = "M",
                                staged = "✓",
                                unmerged = "",
                                renamed = "➜",
                                untracked = "A",
                                deleted = "",
                                ignored = "",
                            },
                        }
                    }
                },
                update_focused_file = {
                    enable = true,
                },
                modified = {
                    enable = true,
                    show_on_dirs = true,
                    show_on_open_dirs = true,
                },
            }
            require("nvim-tree.api").tree.open()
        end
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup() end } -- use 'vim-airline/vim-airline' use 'vim-airline/vim-airline-themes'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                options = { theme = 'gruvbox', },
                disabled_filetypes = { statusline = { 'NvimTree_1', 'packer' } },
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

    -- use { 'alvarosevilla95/luatab.nvim',
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function()
    --         require('luatab')
    --             .setup()
    --     end }

    use { 'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup { options = {
                hover = {
                    enabled = true,
                    delay = 100,
                    reveal = { 'close' }
                },

                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "left",
                        separator = true,
                    }
                },
                numbers = 'ordinal',
                diagnostics = "nvim_lsp",
            } }
        end }

    use { 'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup({})
        end
    }

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
            -- require("scrollbar.handlers.gitsigns").setup()
        end
    }

    use {
        "kevinhwang91/nvim-hlslens",
        config = function()
            -- require('hlslens').setup() is not required
            require("scrollbar.handlers.search").setup({})
        end,
    }

    use {
        "https://git.sr.ht/~nedia/auto-format.nvim",
        config = function()
            require("auto-format").setup()
        end
    }

    use {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
                post_restore_cmds = { function()
                    require("nvim-tree.api").tree.open()
                end },
                pre_save_cmds = { function()
                    require("nvim-tree.api").tree.close()
                end }
            }
        end
    }

    use("github/copilot.vim")

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use("mbbill/undotree")

    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons",       -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    use 'Bekaboo/deadcolumn.nvim'

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
