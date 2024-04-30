M = {}

function M.which_python()
    -- FIXME: Add support for Windows
    local f = io.popen('env which python', 'r') or error("Fail to execute 'env which python'")
    local s = f:read('*a') or error('Fail to read from io.popen result')
    f:close()
    return string.gsub(s, '%s+$', '')
end

function M.git_root()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
end

return M
