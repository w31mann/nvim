-- markview - https://github.com/OXY2DEV/markview.nvim

return {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local presets = require("markview.presets")

        require("markview").setup({
            highlight_groups = "dark",
            markdown = {
                code_blocks = {
                    sign = "",
                    pad_amount = 2,
                },
                horizontal_rules = presets.horizontal_rules.thin,
                list_items = {
                    indent_size = 1,
                    shift_width = 2,
                },
                headings = presets.headings.marker,
            },
        })

        vim.keymap.set("n", "<leader>tm", ":Markview toggle<cr>", {
            desc = "Toggle markdown concealing",
        })
    end,
}
