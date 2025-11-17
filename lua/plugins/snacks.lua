-- snacks - https://github.com/folke/snacks.nvim

return {
    "folke/snacks.nvim",
    priority = 1000,
    keys = {
        -- Terminal keybindings (Mac)
        {
            "†",
            function()
                local terminal = require("plugins.snacks.terminal")
                terminal.smart_terminal_toggle()
            end,
            mode = "n",
            desc = "Toggle all terminals (or specific with count)",
        },
        {
            "µ",
            "<c-\\><c-n>",
            mode = "t",
            desc = "Terminal normal mode",
        },
        {
            "†",
            function()
                require("plugins.snacks.terminal").toggle_all_terminals()
            end,
            mode = "t",
            desc = "Toggle all terminals",
        },
        -- Terminal keybindings (Linux)
        {
            "<m-t>",
            function()
                local terminal = require("plugins.snacks.terminal")
                terminal.smart_terminal_toggle()
            end,
            mode = "n",
            desc = "Toggle all terminals (or specific with count)",
        },
        {
            "<m-m>",
            "<c-\\><c-n>",
            mode = "t",
            desc = "Terminal normal mode",
        },
        {
            "<m-t>",
            function()
                require("plugins.snacks.terminal").toggle_all_terminals()
            end,
            mode = "t",
            desc = "Toggle all terminals",
        },
    },
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
