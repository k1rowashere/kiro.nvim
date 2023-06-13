require('dashboard').setup({
    theme = 'hyper',
    config = {
        shortcut = {
            -- {
            --     icon = '󰦛',
            --     desc = 'Restore Session',
            --     key = 'r',
            --     action = function()
            --         vim.cmd('SessionRestore')
            --     end
            -- },-
            {
                icon = '',
                desc = 'File Browser',
                key = 'e',
                action = function()
                    vim.cmd('enew')
                    require('nvim-tree.api').tree.open()
                end
            },
            {
                icon = '󱝩',
                desc = 'Search Sessions',
                key = 'p',
                action = function()
                    require('auto-session.session-lens').search_session()
                end
            },
            {
                icon = '󰱼',
                desc = 'Find Files',
                key = 'f',
                action = function()
                    require('telescope.builtin').find_files()
                end
            },
        },
        project = {
            action = function(path)
                local as = require('auto-session')
                local sessions = as.get_session_files()
                local session_paths = {}
                for _, session in pairs(sessions) do
                    table.insert(session_paths, session.display_name)
                end
                if vim.tbl_contains(session_paths, path) then
                    as.RestoreSession(path)
                else
                    vim.cmd('Telescope find_files cwd=' .. path)
                end
            end,
        },
        footer = {},
    },
    -- preview = {
    --     command = 'lolcat -t -a -d 2',
    --     file_path = '/home/kirowashere/.config/nvim/kirowashere.txt',
    --     file_width = 86,
    --     file_height = 12,
    -- },
    preview = {
        command = 'lolcat -t -d 2',
        file_path = '/home/kirowashere/.config/nvim/neovim.txt',
        file_width = 69,
        file_height = 10,
    }
})

vim.cmd('hi DashboardShortCutIcon guifg=#f6c177')
