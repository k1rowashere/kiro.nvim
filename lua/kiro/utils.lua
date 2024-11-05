local M = {}

vim.api.nvim_create_user_command('Redir', function(ctx)
    local lines = vim.split(vim.api.nvim_exec2(ctx.args, { output = true }).output, '\n', { plain = true })
    vim.cmd('new')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })

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

---@diagnostic disable-next-line: unused-local
function M.is_big_file(lang, buf)
    local max_filesize = 1000 * 1024 -- 1 MB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf or 0))
    if ok and stats and stats.size > max_filesize then return true end
end

M.formatters = {
    lua = { 'stylua' },
    html = { 'prettierd' },
    json = { 'prettierd' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    css = { 'prettierd' },
    scss = { 'prettierd' },
    less = { 'prettierd' },
    markdown = { 'prettierd' },
    python = { 'autopep8' },
}

return M
