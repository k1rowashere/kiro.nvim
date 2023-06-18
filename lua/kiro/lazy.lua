local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { import = 'kiro.plugins' },
    ---------------------------------- Utils  ----------------------------------
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'Telescope' },
    },
    { 'folke/trouble.nvim', lazy = true },
    { 'kevinhwang91/nvim-hlslens', opts = {} },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = {
            show_current_context = true,
            show_current_context_start = true,
            show_trailing_blankline_indent = false,
            use_treesitter = true,
            char = '',
            context_char = '│',
            filetype_exclude = vim.g.non_file_buffers,
        },
    },
    { 'lewis6991/satellite.nvim', opts = {} },
    {
        'gorbit99/codewindow.nvim',
        lazy = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = { z_index = 50 },
    },
    {
        'mbbill/undotree',
        cmd = { 'UndotreeOpen', 'UndotreeToggle' },
    },
    {
        'akinsho/toggleterm.nvim',
        keys = '<leader>t',
        opts = {
            size = 20,
            open_mapping = '<leader>t',
            insert_mappings = false,
        },
    },
    ----------------------------- Domain Specific  -----------------------------
    {
        'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'javascript', 'html' },
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
        opts = {
            'scss',
            'html',
            css = { rgb_fn = true },
            javascript = { no_names = true },
        },
    },
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        ft = { 'markdown' },
        opts = {},
    },
    { 'folke/neodev.nvim', ft = 'lua', opts = {} },
    ----------------------------- Usless crap (TM) -----------------------------
    { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
    { 'folke/twilight.nvim', cmd = 'Twilight', opts = {} },
}

require('lazy').setup(plugins)
