return function()
    require('nvim-tree').setup {
        disable_netrw = true,
        hijack_unnamed_buffer_when_opening = true,
        sync_root_with_cwd = true,
        view = {
            width = 35,
        },
        renderer = {
            indent_markers = { enable = true, },
            highlight_git = true,
            icons = {
                -- git_placement = "after",
                glyphs = {
                    git = {
                        staged = "",
                        unstaged = "",
                        unmerged = "",
                        ignored = "",
                        untracked = "",
                        deleted = "",
                        renamed = "",
                    }
                }
            },
        },
        diagnostics = {
            enable = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
        update_focused_file = {
            enable = true,
            update_root = false
        },
        modified = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },
        git = {
            enable = true,
            show_on_dirs = true,
        },
        filters = { custom = { '^\\.git$' }, },
        actions = {
            open_file = { quit_on_open = true, },
            remove_file = { close_window = false, },
        }
    }
end
