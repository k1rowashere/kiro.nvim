vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
augroup END
"
" augroup save_folds
"     autocmd!
"     autocmd BufWritePre ?* mkview
"     autocmd BufWritePost ?* silent! loadview
" augroup END
"
" augroup format_options
"     autocmd!
"     autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" augroup END
]])
