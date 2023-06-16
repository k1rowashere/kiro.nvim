return {
    options = {
        mode = 'buffers',
        separator_style = 'slope',
        hover = {
            enabled = true,
            delay = 100,
            reveal = { 'close' }
        },
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                text_align = 'left',
                separator = true,
            },
            {
                filetype = 'undotree',
                text = 'Undo Tree',
                text_align = 'left',
                separator = true,
            }
        },
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
    },
}
