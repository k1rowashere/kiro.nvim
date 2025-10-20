local M = {}

vim.api.nvim_create_user_command('Redir', function(ctx)
    local lines = vim.split(vim.api.nvim_exec2(ctx.args, { output = true }).output, '\n', { plain = true })
    vim.cmd('new')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })

function M.git_root()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
end

function M.is_big_file(_, buf)
    local max_filesize = 1000 * 1024 -- 1 MB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf or 0))
    if ok and stats and stats.size > max_filesize then return true end
end

M.formatters = {
    lua = { 'stylua' },
    sql = { 'prettierd' },
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
    htmldjango = { 'prettierd', 'prettier' },
    jinja = { 'prettierd', 'prettier' },
    yaml = { 'prettierd' },
}

return M
