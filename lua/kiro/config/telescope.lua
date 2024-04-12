local M = {}
local utils = require('kiro.utils')

M.search_opts = function()
    local builtin = require('telescope.builtin')
    return {
        tabs = {},
        collections = {
            git = {
                tabs = {
                    {
                        'Commits',
                        builtin.git_commits,
                        available = function() return vim.fn.isdirectory('.git') end
                    },
                    { name = "Branches", tele_func = builtin.git_branches },
                }
            },
            files = {
                tabs = {
                    { 'Buffers',      tele_func = builtin.buffers },
                    { 'Files',        tele_func = builtin.find_files },
                    { 'Recent Files', tele_func = builtin.oldfiles },
                    {
                        'Grep',
                        tele_func = function()
                            if utils.is_git_repo() then
                                builtin.live_grep({ cwd = utils.git_root() })
                            else
                                builtin.live_grep()
                            end
                        end
                    },
                    { 'Fzf', tele_func = builtin.current_buffer_fuzzy_find },
                },
            }
        }
    }
end

M.opts = function()
    local trouble = require('trouble.providers.telescope')
    return {
        defaults = {
            mappings = {
                i = { ["<c-t>"] = trouble.open_with_trouble },
                n = { ["<c-t>"] = trouble.open_with_trouble },
            }
        },
    }
end

return M