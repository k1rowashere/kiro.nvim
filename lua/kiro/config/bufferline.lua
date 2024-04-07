return function()
    return {
        options = {
            separator_style = 'thin',
            indicator = { icon = '▋' },
            diagnostics_indicator = function(count, _, _, _) return "(" .. count .. ")" end,
            hover = { enabled = true, delay = 200, reveal = { 'close' } },
            offsets = {
                {
                    filetype = 'undotree',
                    text = 'Undo Tree',
                    text_align = 'left',
                    separator = true,
                },
                {
                    filetype = 'aerial',
                    text = 'Aerial',
                    text_align = 'left',
                    separator = true,
                },
            },
            numbers = 'ordinal',
            diagnostics = 'nvim_lsp',
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
end
