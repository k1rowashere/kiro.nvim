return {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        -- auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
        bypass_session_save_file_types = vim.g.non_file_buffers,
        cwd_change_handling = {
            restore_upcoming_session = true,
            post_cwd_changed_hook = function() require('lualine').refresh() end,
        },
        pre_save_cmds = {
            function()
                require('nvim-tree.api').tree.close()
                require('dapui').close()
            end,
        },
        session_lens = {
            load_on_setup = true,
        },
    },
}
