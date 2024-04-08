return function()
    local C = require('catppuccin.palettes').get_palette()
    local hl = require('catppuccin.groups.integrations.bufferline').get()()
    for _, color in pairs(hl) do
        color.sp = C.peach
    end

    return {
        options = {
            separator_style = { '', '' },
            indicator = { style = 'underline' },
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
        highlights = function() return hl end
    }
end
