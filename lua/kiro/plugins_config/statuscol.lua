local builtin = require("statuscol.builtin")
local cfg = {
    segments = {
        { text = { "%s" },                  click = "v:lua.ScSa" },
        {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
        },
        { text = { builtin.foldfunc, ' ' }, click = "v:lua.ScFa" },
    },
}
require("statuscol").setup(cfg)
