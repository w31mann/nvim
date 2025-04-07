-- toggleterm - https://github.com/akinsho/toggleterm.nvim

return {
    "akinsho/toggleterm.nvim",
    config = function()
        local toggleterm = require("toggleterm")

        -- mac
        vim.keymap.set("n", "†", function()
            toggleterm.toggle(vim.v.count)
        end, {
            desc = "Open terminal",
        })
        vim.keymap.set("t", "µ", "<c-\\><c-n>", {
            desc = "Terminal control mode",
        })
        vim.keymap.set("t", "†", function()
            toggleterm.toggle_all()
        end, {
            desc = "Toggle all terminals",
        })

        -- linux
        vim.keymap.set("n", "<m-t>", function()
            toggleterm.toggle(vim.v.count)
        end, {
            desc = "Open terminal",
        })
        vim.keymap.set("t", "<m-m>", "<c-\\><c-n>", {
            desc = "Terminal control mode",
        })
        vim.keymap.set("t", "<m-t>", function()
            toggleterm.toggle_all()
        end, {
            desc = "Toggle all terminals",
        })

        toggleterm.setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return vim.o.lines * 0.4
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            insert_mappings = false,
            terminal_mappings = false,
            start_in_insert = true,
        })
    end,
}
