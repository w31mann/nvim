-- snacks - https://github.com/folke/snacks.nvim

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        -- Load modular configurations
        local indent = require("plugins.snacks.indent")
        local scope = require("plugins.snacks.scope")
        local terminal = require("plugins.snacks.terminal")
        local picker = require("plugins.snacks.picker")

        -- Setup snacks with modular configs
        require("snacks").setup({
            indent = indent.config,
            scope = scope.config,
            terminal = terminal.config,
            picker = picker.config,
        })

        -- Setup module-specific keybindings and autocmds
        terminal.setup()
        picker.setup()
    end,
}
