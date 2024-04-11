local M = {}

function M.git_root()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
end

function M.is_git_repo()
    return M.git_root() ~= ''
end

return M
