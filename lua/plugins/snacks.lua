-- snacks - https://github.com/folke/snacks.nvim

return {
    "folke/snacks.nvim",
    priority = 1000,
    keys = {
        -- Terminal keybindings (Mac)
        { "†", mode = "n", desc = "Toggle all terminals (or specific with count)" },
        { "µ", "<c-\\><c-n>", mode = "t", desc = "Terminal normal mode" },
        { "†", mode = "t", desc = "Toggle all terminals" },
        -- Terminal keybindings (Linux)
        { "<m-t>", mode = "n", desc = "Toggle all terminals (or specific with count)" },
        { "<m-m>", "<c-\\><c-n>", mode = "t", desc = "Terminal normal mode" },
        { "<m-t>", mode = "t", desc = "Toggle all terminals" },
        -- Picker keybindings
        { "<leader>sf", mode = "n", desc = "Search files" },
        { "<leader>sF", mode = "n", desc = "Search files (no ignore)" },
        { "<leader>sg", mode = "n", desc = "Fuzzy search string" },
        { "<leader>sG", mode = "n", desc = "Search string under cursor" },
        { "<leader>sb", mode = "n", desc = "Search open buffers" },
        { "<leader>sd", mode = "n", desc = "Search diagnostics" },
        { "<leader>sc", mode = "n", desc = "Search command history" },
        { "<leader>sR", mode = "n", desc = "Resume last search" },
        { "<leader>sm", mode = "n", desc = "Search marks" },
        { "<leader>sr", mode = "n", desc = "Search registers" },
        { "<leader>sh", mode = "n", desc = "Search help tags" },
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
