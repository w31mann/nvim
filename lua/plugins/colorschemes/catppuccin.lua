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
            float = {
                transparent = true,
                solid = true,
            },
            integrations = {
                fidget = true,
                mason = true,
                blink_cmp = { enabled = true, style = "solid" },
                snacks = {
                    enabled = true,
                    indent_scope_color = "lavender", -- Matches CursorLineNr color
                },
            },
            custom_highlights = function(colors)
                -- colors - https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/macchiato.lua
                return {
                    WinSeparator = { fg = colors.surface1 },
                    Folded = { bg = colors.surface0 },
                    -- NormalFloat = { bg = colors.base, fg = colors.text },
                    -- FloatBorder = { bg = colors.base, fg = colors.text },
                    Pmenu = { bg = colors.base, fg = colors.surface1 },
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
