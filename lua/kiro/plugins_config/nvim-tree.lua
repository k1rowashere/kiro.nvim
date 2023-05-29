require("nvim-tree").setup {
    hijack_unnamed_buffer_when_opening = true,
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
        width = 25,
        side = 'left',
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        highlight_git = true,
        icons = {
            git_placement = "after",
            glyphs = {
                git = {
                    unstaged = "M",
                    staged = "S",
                    unmerged = "",
                    renamed = "R",
                    untracked = "A",
                    deleted = "D",
                    ignored = "",
                },
            }
        }
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
    }
}
