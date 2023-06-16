local handler        = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' ↙ %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

--- @module 'lua/ufo'
local ufo            = require('ufo')

vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99
vim.o.foldlevelstart = -1
vim.o.foldenable     = true

vim.o.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldmethod     = 'expr'
vim.o.foldexpr       = 'nvim_treesitter#foldexpr()'

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'Z', ufo.peekFoldedLinesUnderCursor)

return {
    open_fold_hl_timeout = 100,
    fold_virt_text_handler = handler,
}
