local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
        '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local function load_config(str)
    return require('kiro.plugins_config.' .. str)
end

local packer_bootstrap = ensure_packer()

local packer_plug = function(use)
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        module = 'telescope',
        config = function() require('kiro.plugins_config.telescope') end,
    }

    use { 'beauwilliams/focus.nvim',
        event = 'WinEnter',
        config = function()
            require('focus').setup({
                height = 30,
                quickfixheight = 10,
                excluded_filetypes = { 'fterm', 'term', 'toggleterm' },
                compatible_filetrees = { 'nvimtree' },
            })
        end
    }

    ----------------------------------- Git  -----------------------------------

    use 'tpope/vim-fugitive'

    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('kiro.plugins_config.gitsigns')
            require('scrollbar.handlers.gitsigns').setup()
        end
    }

    ---------------------------------- Utils  ----------------------------------

    use { 'Bekaboo/deadcolumn.nvim',
        event = 'InsertEnter',
        config = function()
            vim.opt.colorcolumn = '81'
        end
    }

    use { 'saifulapm/chartoggle.nvim',
        keys = { 'g,', 'g;' },
        config = function()
            require('chartoggle').setup({
                leader = 'g',
                keys = { ',', ';' },
            })
        end
    }

    use 'mg979/vim-visual-multi'

    use { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'kylechui/nvim-surround',
        keys = { 'c', 'd', 'y' },
        tag = '*',
        config = function() require('nvim-surround').setup() end
    }

    use { 'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }

    ------------------------------ Syntax and LSP ------------------------------

    use { 'nvim-treesitter/nvim-treesitter',
        config = load_config('nvim-treesitter'),
    }

    use 'nvim-treesitter/nvim-treesitter-context'

    use 'mrjones2014/nvim-ts-rainbow'

    use { 'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('kiro.plugins_config.indent')
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

    use 'onsails/lspkind.nvim'

    use { 'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        after = { 'copilot-cmp', 'lspkind.nvim' },
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

    ------------------------ debugging and diagnositcs  ------------------------
    use { 'mfussenegger/nvim-dap', config = load_config('nvim-dap') }

    use { 'rcarriga/nvim-dap-ui',
        requires = { 'mfussenegger/nvim-dap' },
        keys = '<leader>db',
        module = 'dapui',
        config = function()
            require('dapui').setup()
        end,
    }

    use { 'folke/trouble.nvim',
        module = 'trouble',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use { 'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {}
        end
    }

    use { 'folke/which-key.nvim', config = load_config('which-key') }

    ------------------------------------ -- ------------------------------------

    ------------------------------------ UI ------------------------------------

    use { 'akinsho/toggleterm.nvim',
        keys = '<leader>t',
        config = function() require('kiro.plugins_config.toggleterm') end
    }

    use { 'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        -- config = load_config('nvim-ufo'),
        config = function()
            require('kiro.plugins_config.nvim-ufo')
        end
    }

    use { 'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('kiro.plugins_config.lualine') end
    }

    use { "luukvbaal/statuscol.nvim",
        config = load_config('statuscol'),
    }

    use { 'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'nvim-tree/nvim-web-devicons',
        config = load_config('bufferline'),
    }

    use { 'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar/init').setup({
                handlers = {
                    gitsigns = true,
                    search = true,
                },
            })
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
            require('kiro.plugins_config.auto-session')
        end
    }

    use { 'nvim-tree/nvim-tree.lua',
        module = { 'nvim-tree.api' },
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = load_config('nvim-tree'),
    }

    use { 'mbbill/undotree', cmd = { 'UndotreeOpen', 'UndotreeToggle' } }

    use { 'utilyre/barbecue.nvim',
        event = 'ColorScheme',
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

    use { 'glepnir/dashboard-nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
            'rmagatti/auto-session'
        },
        -- config = load_config('dashboard'),
        config = function()
            require('kiro.plugins_config.dashboard')
        end,
    }

    ---------------------------------- Theme  ----------------------------------

    use { 'rose-pine/neovim', as = 'rose-pine',
        config = function()
            vim.cmd [[set termguicolors]]
            require('rose-pine').setup({
                highlight_groups = {
                    ColorColumn = { bg = 'rose' },
                    CursorLine = { bg = 'foam', blend = 10 },
                }
            })
            vim.cmd [[colorscheme rose-pine]]
        end
    }

    use { 'xiyaowong/transparent.nvim',
        config = require('kiro.plugins_config.transparent')
    }

    --------------------------- Domain Specific  ---------------------------

    use { 'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'javascript', 'html' },
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
        config = function()
            require('colorizer').setup({
                'scss',
                'html',
                css = { rgb_fn = true, },
                javascript = { no_names = true }
            })
        end
    }

    use { 'toppair/peek.nvim',
        run = 'deno task --quiet build:fast',
        ft = { 'markdown' },
        config = function()
            require('peek').setup()
        end
    }

    use { 'folke/neodev.nvim',
        ft = { 'lua' },
        config = function() require('neodev').setup() end
    }


    --------------------------- Usless crap (TM) ---------------------------

    use { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' }


    if packer_bootstrap then
        require('packer').sync()
    end
end

return require('packer').startup({
    packer_plug,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})
