return {
    'nvimdev/guard.nvim',
    dependencies = 'nvimdev/guard-collection',
    lazy = false,
    opts = { lsp_as_default_formater = true },
    config = function(_, opts)
        local ft = require('guard.filetype')
        ft('c,cpp'):fmt('clang-format'):lint('clang-tidy')
        ft(
            'angular,css,flow,graphql,html,json,jsx,javascript'
                .. ',less,markdown,scss,typescript,vue,yaml'
        ):fmt('prettier'):extra('--tab-width 4')
        ft('lua'):fmt('stylua'):extra('-s')
        ft('rust'):fmt('lsp')

        require('guard').setup(opts)
    end,
}
