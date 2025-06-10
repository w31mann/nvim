-- catppuccin - https://github.com/catppuccin/nvim

return {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            background = {
                -- :h background
                light = "latte",
                dark = "macchiato",
            },
            styles = {
                conditionals = {},
            },
            term_colors = true,
            no_italic = true,
            no_underline = true,
            integrations = {
                fidget = true,
                mason = true,
            },
            custom_highlights = function(color)
                -- colors - https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/macchiato.lua
                return {
                    WinSeparator = { fg = color.blue },
                    Folded = { bg = color.surface0 },
                }
            end,
        })

        local colors = require("catppuccin.palettes").get_palette()

        vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = colors.red })
        vim.api.nvim_command("match ExtraWhitespace /\\s\\+$/")

        vim.cmd.colorscheme("catppuccin")
    end,
}
