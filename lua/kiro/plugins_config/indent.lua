require('indent_blankline').setup({
    show_current_context           = true,
    show_current_context_start     = true,
    show_trailing_blankline_indent = false,
    use_treesitter                 = true,
    char                           = '',
    context_char                   = '│',
    filetype_exclude               = vim.g.non_file_buffers,
})
