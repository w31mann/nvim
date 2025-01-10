-- catppuccin - https://github.com/catppuccin/nvim

return {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = {
                -- :h background
                light = "latte",
                dark = "macchiato",
            },
            styles = {
                conditionals = {},
            },
            no_italic = true,
            no_underline = true,
            integrations = {
                blink_cmp = true,
                dap = true,
                dap_ui = true,
                gitsigns = true,
                fidget = true,
                illuminate = {
                    enabled = true,
                    lsp = true,
                },
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                markdown = true,
                mason = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                native_lsp = {
                    enabled = true,
                    inlay_hints = {
                        background = true,
                    },
                },
                ufo = true,
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
