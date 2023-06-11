return function()
    require("transparent").setup({
        extra_groups = {
            'NormalFloat',
            'NvimTreeNormal',
            'barbecue_normal',
            'folded',
            'GitSignsAdd',
            'GitSignsChange',
            'GitSignsDelete',
        },
        exclude_groups = {},
    })
end
