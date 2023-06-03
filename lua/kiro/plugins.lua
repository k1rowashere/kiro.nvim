local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local function load_config(str)
    return require('kiro.plugins_config.' .. str)
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        keys = '<leader>f',
        cmd = { 'Telescope' },
        config = load_config('telescope'),
    }

    use { "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup({
                height = 50,
                minheight = 1,
                compatible_filetrees = { 'nvimtree' },
            })
        end
    }

    use 'tpope/vim-fugitive'

    ------------------------------ Syntax and LSP ------------------------------

    use { 'nvim-treesitter/nvim-treesitter',
        config = load_config('nvim-treesitter'),
    }

    use 'nvim-treesitter/nvim-treesitter-context'
    use 'mrjones2014/nvim-ts-rainbow'

    use { 'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                show_current_context           = true,
                show_current_context_start     = true,
                show_trailing_blankline_indent = false

            })
            vim.g.indent_blankline_char = '▏'
            -- vim.g.indent_blankline_char_list = { '|', '¦', '┆', '┊' }
            vim.g.indent_blankline_filetype_exclude = vim.g.non_file_buffers
            vim.g.indent_blankline_use_treesitter = true
        end
    }

    use { 'zbirenbaum/copilot.lua',
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
            { 'onsails/lspkind.nvim' },
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

    use { 'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'kylechui/nvim-surround',
        event = 'InsertEnter',
        tag = '*',
        config = function() require('nvim-surround').setup() end
    }

    use { 'gennaro-tedesco/nvim-peekup', keys = '""' }

    use { 'nvim-tree/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeClose' },
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        config = load_config('nvim-tree'),
    }

    use { 'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }

    ------------------------------------ UI ------------------------------------

    use { 'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = load_config('nvim-ufo'),
    }

    use { 'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = load_config('lualine'),
    }

    use { "luukvbaal/statuscol.nvim",
        config = load_config('statuscol'),
    }

    use { 'akinsho/bufferline.nvim',
        after = 'rose-pine',
        tag = '*',
        requires = 'nvim-tree/nvim-web-devicons',
        config = load_config('bufferline'),
    }

    use { 'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup({
                handlers = {
                    gitsigns = true,
                    search = true,
                },
            })
        end
    }

    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('kiro.plugins_config.gitsigns')
            require('scrollbar.handlers.gitsigns').setup()
        end
    }

    use { 'kevinhwang91/nvim-hlslens',
        config = function()
            -- require('hlslens').setup() is not required
            require('scrollbar.handlers.search').setup()
        end,
    }

    use { 'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'error',
                auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
                bypass_session_save_file_types = vim.g.non_file_buffers,
                cwd_change_handling = {
                    restore_upcoming_session = true,
                },
                -- post_restore_cmds = { require('nvim-tree.api').tree.open },
                -- pre_save_cmds = { require('nvim-tree.api').tree.close },
            }
            -- using config causes a crash if nvim-tree is lazy loaded
            vim.g.auto_session_pre_save_cmds = { 'NvimTreeClose' }
        end
    }

    use { 'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {}
        end
    }

    use { 'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup {}
        end
    }

    use { 'mbbill/undotree',
        cmd = { 'UndotreeOpen', 'UndotreeToggle' }
    }

    use { 'utilyre/barbecue.nvim',
        tag = '*',
        requires = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        after = 'nvim-web-devicons',
        config = function()
            require('barbecue').setup({})
        end,
    }

    use 'Bekaboo/deadcolumn.nvim'

    use { 'glepnir/dashboard-nvim',
        requires = { 'nvim-tree/nvim-web-devicons', 'm00qek/baleia.nvim' },
        config = load_config('dashboard'),
    }

    -- use { 'folke/tokyonight.nvim' }
    -- use { 'luisiacc/gruvbox-baby' }
    use { 'rose-pine/neovim', as = 'rose-pine',
        branch = 'main',
        config = function()
            -- vim.g.gruvbox_baby_background_color = 'dark'
            -- vim.g.gruvbox_baby_telescope_theme  = 1
            -- vim.g.gruvbox_baby_transparent_mode = 0
            vim.cmd [[set termguicolors]]
            vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
            require('rose-pine').setup({
                highlight_groups = {
                    ColorColumn = { bg = 'rose' },
                    CursorLine = { bg = 'foam', blend = 10 },
                }
            })
            vim.cmd [[colorscheme rose-pine]]
        end
    }

    use { 'xiyaowong/transparent.nvim', config = load_config('transparent') }

    ----------------------------- Domain Specific  -----------------------------

    use { 'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'javascript', 'html' },
        config = function()
            require('colorizer').setup({
                'css',
                'javascript',
                'html',
            }, { mode = 'forground' })
        end
    }

    use { 'toppair/peek.nvim', run = 'deno task --quiet build:fast',
        ft = { 'md' },
        config = function()
            require('peek').setup()
        end
    }


    ----------------------------- Usless crap (TM) -----------------------------

    use { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' }


    if packer_bootstrap then
        require('packer').sync()
    end
end)
