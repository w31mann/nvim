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
        local presets = require("markview.presets");

        require("markview").setup({
            highlight_groups = "dark",
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
            -- headings = {
            --     enable = true,
            --     shift_width = 0,
            --
            --     heading_1 = {
            --         -- sign = "",
            --         sign = "󰌕 ",
            --     },
            --     heading_2 = {
            --         sign = "󰌕 ",
            --     },
            --     heading_3 = {
            --         sign = "󰌕 ",
            --     },
            --     heading_4 = {
            --         sign = "󰌕 ",
            --     },
            --     heading_5 = {
            --         sign = "󰌕 ",
            --     },
            --     heading_6 = {
            --         sign = "󰌕 ",
            --     },
            -- },
        })

        vim.keymap.set("n", "<leader>tm", ":Markview toggle<cr>", {
            desc = "Toggle markdown concealing",
        })
    end,
}
