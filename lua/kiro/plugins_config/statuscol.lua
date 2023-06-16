local builtin = require('statuscol.builtin')

return {
    ft_ignore = vim.g.non_file_buffers,
    segments = {
        {
            sign = { name = { '.*' }, maxwidth = 1, fillchar = ' ' },
            click = 'v:lua.ScSa',
        },
        {
            text = { builtin.lnumfunc, ' ' },
            condition = { true, builtin.not_empty },
            click = 'v:lua.ScLa',
        },
        { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
    },
}
