-- TODO: move to plugin (should work with any language)
local function header_comment(str, line_len)
    -- remove trailing and leading whitespace
    str = str:gsub('^%s*(.-)%s*$', '%1')
    local dash_count = (line_len - string.len(str) - 2) / 2
    if string.len(str) % 2 == 1 then str = str .. ' ' end

    return string.rep('-', dash_count)
        .. ' '
        .. str
        .. ' '
        .. string.rep('-', dash_count)
end

function Replace_with_header()
    local line = vim.api.nvim_get_current_line()
    local indent = line:match('^%s+') or ''
    local match = line:match('^%s*%-%-([^%-].+)%-%-$')
    if match then
        vim.api.nvim_set_current_line(
            indent .. header_comment(match, 80 - string.len(indent))
        )
    end
end

vim.cmd([[
    augroup CommentHeader
        autocmd!
        autocmd TextChanged,TextChangedI * lua Replace_with_header()
        augroup END
]])
