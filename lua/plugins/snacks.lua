-- snacks - https://github.com/folke/snacks.nvim

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        local indent = require("plugins.snacks.indent")
        local scope = require("plugins.snacks.scope")
        local terminal = require("plugins.snacks.terminal")
        local picker = require("plugins.snacks.picker")

        require("snacks").setup({
            indent = indent.config,
            input = { enabled = true },
            scope = scope.config,
            terminal = terminal.config,
            picker = picker.config,
        })

        terminal.setup()
        picker.setup()
    end,
}
