local M = {}
local git_root = require('kiro.utils').git_root
local grep = function()
    if git_root() ~= '' then
        require('telescope.builtin').live_grep({ cwd = git_root() })
    else
        require('telescope.builtin').live_grep()
    end
end

M.search_opts = function()
    local builtin = require('telescope.builtin')
    return {
        tabs = {},
        collections = {
            git = {
                tabs = {
                    { 'Commits', builtin.git_commits, available = function() return vim.fn.isdirectory('.git') end },
                    { 'Branches', builtin.git_branches },
                },
            },
            files = {
                tabs = {
                    { 'Buffers', builtin.buffers },
                    { 'Files', builtin.find_files },
                    { 'Recent Files', builtin.oldfiles },
                    { 'Grep', grep },
                    { 'Fzf', builtin.current_buffer_fuzzy_find },
                },
            },
        },
    }
end

M.opts = function()
    local trouble = require('trouble.providers.telescope')
    return {
        defaults = {
            mappings = {
                i = { ['<c-t>'] = trouble.open_with_trouble },
                n = { ['<c-t>'] = trouble.open_with_trouble },
            },
        },
    }
end

return M
