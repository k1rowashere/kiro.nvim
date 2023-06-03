return function()
    require("transparent").setup({
        extra_groups = {
            'NormalFloat',
            'NvimTreeNormal',
            'barbecue_normal',
        },
        exclude_groups = {},
    })
end
