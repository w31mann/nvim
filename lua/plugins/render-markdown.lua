-- render-markdown - https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("render-markdown").setup({
            anti_conceal = {
                enabled = false,
                ignore = {
                    sign = true,
                    code_language = true,
                    code_background = true,
                    code_border = true,
                },
            },
            code = {
                sign = false,
            },
        })

        vim.keymap.set("n", "<leader>tm", ":RenderMarkdown toggle<cr>", {
            desc = "Toggle markdown concealing",
        })
    end,
}
