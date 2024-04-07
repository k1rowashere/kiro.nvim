local function init()
    vim.api.nvim_create_autocmd('BufRead', {
        group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
        pattern = 'Cargo.toml',
        callback = function()
            local cmp = require('cmp')
            cmp.setup.buffer({ sources = { { name = 'crates' } } })
            local crates = require('crates')
            local opts = function(desc)
                return { silent = true, buffer = true, desc = desc }
            end
            local map = vim.keymap.set

            map('n', '<leader>ct', crates.toggle, opts('Crates Toggle'))
            map('n', '<leader>cr', crates.reload, opts('Crates Reload'))

            map(
                'n',
                '<leader>cv',
                crates.show_versions_popup,
                opts('Show Version')
            )
            map(
                'n',
                '<leader>cf',
                crates.show_features_popup,
                opts('Show Features')
            )
            map(
                'n',
                '<leader>cd',
                crates.show_dependencies_popup,
                opts('Show Dependencies')
            )

            map('n', '<leader>cu', crates.update_crate, opts('Update Crate'))
            map('v', '<leader>cu', crates.update_crates, opts('Update Crates'))
            map(
                'n',
                '<leader>ca',
                crates.update_all_crates,
                opts('Update All Crates')
            )
            map('n', '<leader>cU', crates.upgrade_crate, opts('Upgrade Crate'))
            map(
                'v',
                '<leader>cU',
                crates.upgrade_crates,
                opts('Upgrade Crates')
            )
            map(
                'n',
                '<leader>cA',
                crates.upgrade_all_crates,
                opts('Upgrade All Crates')
            )

            map(
                'n',
                '<leader>ce',
                crates.expand_plain_crate_to_inline_table,
                opts('Expand Crate to Table')
            )
            map(
                'n',
                '<leader>cE',
                crates.extract_crate_into_table,
                opts('Extract Crate to Table')
            )

            map('n', '<leader>cH', crates.open_homepage, opts('Open Homepage'))
            map(
                'n',
                '<leader>cR',
                crates.open_repository,
                opts('Open Repository')
            )
            map(
                'n',
                '<leader>cD',
                crates.open_documentation,
                opts('Open Documentation')
            )
            map(
                'n',
                '<leader>cC',
                crates.open_crates_io,
                opts('Open crates.io')
            )
        end,
    })
end
return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'Telescope' },
    },
    {
        'folke/trouble.nvim',
        lazy = true,
        opts = {
            action_keys = {
                jump = { '<tab.', '<2-leftmouse>' },
                jump_close = { '<cr>' },
            },
        },
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
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        ft = { 'markdown' },
        opts = {},
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        -- WARN: 'null-ls' is archived and may break at any moment
        dependencies = {
            'nvim-lua/plenary.nvim',
            'jose-elias-alvarez/null-ls.nvim',
        },
        opts = {
            null_ls = { enabled = true },
            src = { cmp = { enabled = true } },
        },
        init = init,
    },
}
