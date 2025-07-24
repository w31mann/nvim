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
            term_colors = true,
            no_italic = true,
            no_underline = true,
            integrations = {
                fidget = true,
                mason = true,
                blink_cmp = true,
                telescope = {
                    style = "nvchad_outlined",
                },
            },
            custom_highlights = function(colors)
                -- colors - https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/macchiato.lua
                return {
                    WinSeparator = { fg = colors.surface1 },
                    Folded = { bg = colors.surface0 },
                    Pmenu = { bg = colors.base, fg = colors.surface1 },
                    NormalFloat = { bg = colors.base, fg = colors.text },
                    BlinkCmpDocBorder = { bg = colors.base, fg = colors.surface1 },
                    BlinkCmpDocSeparator = { bg = colors.base, fg = colors.surface1 },
                }
            end,
        })

        local colors = require("catppuccin.palettes").get_palette()

        vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = colors.red })
        vim.api.nvim_command("match ExtraWhitespace /\\s\\+$/")

        vim.cmd.colorscheme("catppuccin")
    end,
}
