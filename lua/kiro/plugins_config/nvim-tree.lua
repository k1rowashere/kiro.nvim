require("nvim-tree").setup {
    disable_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    sync_root_with_cwd = true,
    view = {
        float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = 30,
                height = 30,
                row = 1,
                col = 1,
            },
        },
        signcolumn = "no",
        width = 30,
        side = 'left',
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
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
    },
    modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    git = {
        show_on_dirs = true,
    },
    filters = {
        custom = { '^\\.git$' },
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
        remove_file = {
            close_window = false,
        },
    }
}
