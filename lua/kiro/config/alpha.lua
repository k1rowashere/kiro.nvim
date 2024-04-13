return function()
    local theta = require('alpha.themes.theta')
    vim.api.nvim_set_hl(0, 'TitleLetters', { fg = '#eba0ac' })
    vim.api.nvim_set_hl(0, 'TitleOutline', { fg = '#e64553' })
    local hl = 'TitleLetters'
    local hb = { 'TitleOutline', 0, 150 }

    theta.header.val = {
        [[𝔎𝔦𝔯𝔬𝔴𝔞𝔰𝔥𝔢𝔯𝔢 𝔭𝔯𝔢𝔰𝔢𝔫𝔱𝔰:]],
        [[]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
    }

    theta.header.opts.hl = {
        { { 'rainbow5', 0, 78 } },
        {},
        { hb,                   { hl, 1, 10 }, { hl, 16, 22 }, { hl, 25, 46 }, { hl, 50, 68 }, { hl, 72, 78 }, { hl, 84, 90 },   { hl, 93, 99 },   { hl, 102, 111 }, { hl, 117, 126 } },
        { hb,                   { hl, 1, 13 }, { hl, 18, 24 }, { hl, 27, 33 }, { hl, 51, 57 }, { hl, 69, 75 }, { hl, 78, 84 },   { hl, 90, 96 },   { hl, 99, 105 },  { hl, 108, 120 }, { hl, 124, 136 } },
        { hb,                   { hl, 1, 7 },  { hl, 10, 16 }, { hl, 20, 26 }, { hl, 29, 44 }, { hl, 49, 55 }, { hl, 61, 67 },   { hl, 70, 76 },   { hl, 82, 88 },   { hl, 91, 97 },   { hl, 100, 106 }, { hl, 109, 121 }, { hl, 124, 130 } },
        { hb,                   { hl, 1, 7 },  { hl, 13, 19 }, { hl, 22, 28 }, { hl, 31, 37 }, { hl, 51, 57 }, { hl, 63, 69 },   { hl, 75, 81 },   { hl, 85, 91 },   { hl, 97, 103 },  { hl, 106, 112 }, { hl, 118, 124 }, { hl, 130, 136 } },
        { hb,                   { hl, 1, 7 },  { hl, 14, 26 }, { hl, 29, 50 }, { hl, 56, 74 }, { hl, 84, 96 }, { hl, 103, 109 }, { hl, 112, 118 }, { hl, 132, 138 } },
        { hb }
    }

    return theta.config
end
