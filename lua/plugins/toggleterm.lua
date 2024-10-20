-- toggleterm - https://github.com/akinsho/toggleterm.nvim

return {
    "akinsho/toggleterm.nvim",
    config = function()
        local toggleterm = require("toggleterm")

        if vim.uv.os_uname().sysname == "Darwin" then
            vim.keymap.set("n", "†", function()
                toggleterm.toggle()
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
        else
            vim.keymap.set("n", "<m-t>", function()
                toggleterm.toggle()
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
        end

        toggleterm.setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return vim.o.lines * 0.4
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            -- open_mapping = "[[†]]",
            insert_mappings = false,
            terminal_mappings = false,
            start_in_insert = true,
        })
    end,
}
