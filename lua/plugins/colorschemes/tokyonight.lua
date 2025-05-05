-- tokyonight -- https://github.com/folke/tokyonight.nvim

return {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "storm", -- night, strom, day, moon
            on_highlights = function(hightlights, colors)
                hightlights["IndentBlanklineChar"] = colors.purple
            end,
        })

        local colors = require("tokyonight.colors").setup()

        vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = colors.red })
        vim.api.nvim_command("match ExtraWhitespace /\\s\\+$/")

        vim.cmd.colorscheme("tokyonight")
    end,
}
