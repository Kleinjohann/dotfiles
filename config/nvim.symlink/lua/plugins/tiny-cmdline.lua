return {
    "rachartier/tiny-cmdline.nvim",
    init = function()
        local cmdline = require("tiny-cmdline")
        vim.g.tiny_cmdline = {
            on_reposition = cmdline.adapters.blink,
            width = { value = "70%" },
        }
    end,
}
