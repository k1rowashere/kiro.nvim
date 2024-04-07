return {
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    opts = {
        autosave_last_session = true,
        autosave_ignore_not_normal = true,
        autosave_ignore_dirs = { '~' },
        autosave_ignore_filetypes = {
            'gitcommit',
            'gitrebase',
            'nofile',
        },
        autosave_ignore_buftypes = {},
        autosave_only_in_session = false,
        max_path_length = 80,
    },
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
}
