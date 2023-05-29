-- Vim options
vim.opt.nu                          = true
vim.opt.relativenumber              = true
vim.opt.wrap                        = false
vim.opt.undofile                    = true
vim.opt.formatoptions               = 'jql'

-- tab options
vim.opt.tabstop                     = 4
vim.opt.shiftwidth                  = 4
vim.opt.expandtab                   = true

-- color column
vim.opt.colorcolumn                 = '80'
vim.opt.cursorline                  = true

-- open window options
vim.opt.splitright                  = true
vim.opt.splitbelow                  = true

-- scroll options
vim.opt.scrolloff                   = 10

-- vim.api.nvim_set_hl(0, 'Normal', {bg='None'})
-- vim.api.nvim_set_hl(0, 'NormalFloat', {bg='None'})

vim.g.gruvbox_baby_background_color = 'dark'
vim.g.gruvbox_baby_telescope_theme  = 1


vim.g.airline_powerline_fonts = 1

vim.g.loaded_netrw            = 1
vim.g.loaded_netrwPlugin      = 1

vim.opt.termguicolors         = true
vim.opt.mousemev              = true

vim.opt.sessionoptions        = "blank,buffers,curdir,folds,help," ..
    "tabpages,winsize,winpos,terminal," ..
    "localoptions"

-- Copilot
-- vim.g.copilot_no_tab_map      = true
-- vim.g.copilot_assume_mapped   = true
-- vim.g.copilot_tab_fallback    = ""

-- Fold options
-- Save fold settings when saving a file

vim.cmd [[
    augroup remember_folds
        au!
        au BufWritePre *.* mkview
        au BufWritePost *.* silent loadview
    augroup END
]]

vim.o.foldcolumn     = '1' -- '0' is not bad
vim.o.foldlevel      = 99  -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable     = true

vim.o.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
local fcs            = vim.opt.fillchars:get()

local function get_fold(lnum)
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end
    return vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
end

-- implement relative line number in statuscolumn
local function get_line_number(lnum, rnum)
    if rnum == 0 then
        return lnum
    else
        return rnum
    end
end

_G.get_statuscol = function()
    if vim.opt_local.signcolumn:get() == 'yes' then
        return "%s%= " ..
            get_line_number(vim.v.lnum, vim.v.relnum) ..
            get_fold(vim.v.lnum) .. " "
    else
        return ''
    end
end

-- vim.opt_local.statuscolumn = "%!v:lua.get_statuscol()"
