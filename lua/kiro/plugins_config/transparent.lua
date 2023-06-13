return function()
    require('transparent').setup({
        extra_groups = {
            'NormalFloat',
            'NvimTreeNormal',
            'barbecue_normal',
            'folded',
            'GitSignsAdd',
            'GitSignsChange',
            'GitSignsDelete',
            'FloatBorder',
            'TelescopeNormal',
            'TelescopeBorder',
            'TelescopePromptNormal',
        },
        exclude_groups = {},
    })
end
