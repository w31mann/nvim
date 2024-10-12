-- markview - https://github.com/OXY2DEV/markview.nvim

return {
    "OXY2DEV/markview.nvim",
    ft = "markdown",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("markview").setup({
            code_blocks = {
                sign = "",
            },
            horizontal_rules = {
                enable = true,

                position = "overlay",
                parts = {
                    {
                        repeat_amount = function() --[[@as function]]
                            local textoff =
                                vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff

                            return math.floor((vim.o.colorcolumn - textoff) / 2)
                        end,
                    },
                    {
                        repeat_amount = function() --[[@as function]]
                            local textoff =
                                vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff

                            -- return math.ceil((vim.o.columns - textoff - 3) / 2);
                            return math.ceil((vim.o.colorcolumn - textoff) / 2)
                        end,
                    },
                },
            },

            headings = {
                enable = true,
                shift_width = 0,

                heading_1 = {
                    sign = "",
                },
                heading_2 = {
                    sign = "",
                },
                heading_3 = {
                    sign = "",
                },
                heading_4 = {
                    sign = "",
                },
                heading_5 = {
                    sign = "",
                },
                heading_6 = {
                    sign = "",
                },
            },
        })

        vim.keymap.set("n", "<leader>tm", ":Markview toggle<cr>", {
            desc = "Toggle markdown concealing",
        })
    end,
}
