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

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- use { 'm00qek/baleia.nvim', tag = 'v1.3.0', config = function()
    --     local function baleia()
    --         require('baleia').setup().once(vim.api.nvim_buf_get_number(0))
    --     end
    --     vim.api.nvim_create_user_command('BaleiaColorize', baleia, {})
    -- end }

    use { 'luisiacc/gruvbox-baby',
        branch = 'main',
        config = function()
            vim.g.gruvbox_baby_background_color = 'dark'
            vim.g.gruvbox_baby_telescope_theme  = 1
            -- vim.g.gruvbox_baby_transparent_mode = 0
            vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
            vim.cmd('colorscheme gruvbox-baby')
        end
    }

    use { 'xiyaowong/transparent.nvim',
        -- disable = true,
        cmd = { 'TransparentEnable', 'TransparentDisable', 'TransparentToggle' },
        config = function()
            require("transparent").setup({
                groups = {
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = {
                    'NormalFloat',
                    'NvimTreeNormal',
                    'barbecue_normal'
                },
                exclude_groups = {},
            })
        end
    }

    use { 'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('kiro.plugins_config.telescope')
        end
    }

    use 'tpope/vim-fugitive'

    use {
        {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require('kiro.plugins_config.nvim-treesitter')
            end
        },
        'nvim-treesitter/nvim-treesitter-context',
        'mrjones2014/nvim-ts-rainbow',
    }


    use { 'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = function()
            require('kiro.plugins_config.nvim-ufo')
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

    use { 'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'cuducos/yaml.nvim',
        ft = { 'yaml' },
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim'
        },
    }

    use { 'toppair/peek.nvim', run = 'deno task --quiet build:fast',
        ft = { 'md' },
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

    -- use { 'gennaro-tedesco/nvim-peekup', keys = '""' }

    use { 'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('kiro.plugins_config.nvim-tree')
        end
    }

    use { 'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }

    use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('kiro.plugins_config.lualine')
        end
    }

    use { "luukvbaal/statuscol.nvim",
        config = function()
            require('kiro.plugins_config.statuscol')
        end,
    }

    use { 'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('kiro.plugins_config.bufferline')
        end
    }

    use { 'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup()
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
                pre_save_cmds = { require('nvim-tree.api').tree.close },
            }
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
            require('which-key').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use 'mbbill/undotree'

    use { 'utilyre/barbecue.nvim',
        tag = '*',
        requires = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        after = 'nvim-web-devicons',
        config = function()
            require('barbecue').setup()
        end,
    }

    use 'Bekaboo/deadcolumn.nvim'

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

    use { 'glepnir/dashboard-nvim',
        requires = { 'nvim-tree/nvim-web-devicons', 'm00qek/baleia.nvim' },
        event = 'VimEnter',
        config = function()
            require('kiro.plugins_config.dashboard')
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
