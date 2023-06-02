vim.cmd [[set termguicolors]]

require('bufferline').setup {
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
    }
}

vim.g.transparent_groups = vim.list_extend(
    vim.g.transparent_groups or {},
    vim.tbl_map(function(v)
        return v.hl_group
    end, vim.tbl_values(require('bufferline.config').highlights))
)
