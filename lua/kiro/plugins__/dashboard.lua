return {
    -- 'k1rowashere/dashboard-nvim',
    'nvimdev/dashboard-nvim',
    lazy = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        theme = 'hyper',
        config = {
            shortcut = {
                {
                    icon = '󰦛',
                    desc = 'Last Session',
                    key = 'r',
                    action = function()
                        require('session_manager').load_last_session(true)
                    end,
                },
                {
                    icon = '',
                    desc = 'Files',
                    key = 'e',
                    action = function()
                        vim.cmd('enew')
                        require('nvim-tree.api').tree.open()
                    end,
                },
                {
                    icon = '󱝩',
                    desc = 'Load Session',
                    key = 's',
                    action = function()
                        require('session_manager').load_session()
                    end,
                },
                {
                    icon = '󰱼',
                    desc = 'Find Files',
                    key = 'f',
                    action = function()
                        require('telescope.builtin').find_files()
                    end,
                },
            },
            project = {
                action = function(path)
                    local su = require('session_manager.utils')
                    local sc = require('session_manager.config')
                    local curr = sc.dir_to_session_filename(path).filename
                    for _, session in ipairs(su.get_sessions()) do
                        if session.filename == curr then
                            su.load_session(session.filename, false)
                            return
                        end
                    end
                    vim.cmd('Telescope find_files cwd=' .. path)
                end,
            },
            footer = {},
        },
        preview = {
            command = 'cat ~/.config/nvim/neovim.txt',
            file_path = '~/.config/nvim/neovim.txt',
            file_width = 69,
            file_height = 10,
        },
    },
}
