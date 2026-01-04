-- catppuccin - https://github.com/catppuccin/nvim

return {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
        local function macchiato_lualine_overwrites(colors)
            return {
                normal = {
                    b = { bg = colors.surface0, fg = colors.text },
                    c = { bg = colors.mantle, fg = colors.mauve },
                    x = { bg = colors.mantle, fg = colors.text },
                    y = { bg = colors.mantle, fg = colors.text },
                    z = { bg = colors.mantle, fg = colors.text },
                },
                insert = {
                    b = { bg = colors.surface0, fg = colors.text },
                    c = { bg = colors.mantle, fg = colors.mauve },
                    x = { bg = colors.mantle, fg = colors.text },
                    y = { bg = colors.mantle, fg = colors.text },
                    z = { bg = colors.mantle, fg = colors.text },
                },
                visual = {
                    b = { bg = colors.surface0, fg = colors.text },
                    c = { bg = colors.mantle, fg = colors.mauve },
                    x = { bg = colors.mantle, fg = colors.text },
                    y = { bg = colors.mantle, fg = colors.text },
                    z = { bg = colors.mantle, fg = colors.text },
                },
                replace = {
                    b = { bg = colors.surface0, fg = colors.text },
                    c = { bg = colors.mantle, fg = colors.mauve },
                    x = { bg = colors.mantle, fg = colors.text },
                    y = { bg = colors.mantle, fg = colors.text },
                    z = { bg = colors.mantle, fg = colors.text },
                },
                command = {
                    b = { bg = colors.surface0, fg = colors.text },
                    c = { bg = colors.mantle, fg = colors.mauve },
                    x = { bg = colors.mantle, fg = colors.text },
                    y = { bg = colors.mantle, fg = colors.text },
                    z = { bg = colors.mantle, fg = colors.text },
                },
                terminal = {
                    b = { bg = colors.surface0, fg = colors.text },
                    c = { bg = colors.mantle, fg = colors.mauve },
                    x = { bg = colors.mantle, fg = colors.text },
                    y = { bg = colors.mantle, fg = colors.text },
                    z = { bg = colors.mantle, fg = colors.text },
                },
                inactive = {
                    b = { bg = colors.surface0, fg = colors.surface1 },
                    c = { bg = colors.mantle, fg = colors.overlay0 },
                    x = { bg = colors.mantle, fg = colors.overlay0 },
                    y = { bg = colors.mantle, fg = colors.overlay0 },
                    z = { bg = colors.mantle, fg = colors.overlay0 },
                },
            }
        end

        require("catppuccin").setup({
            flavour = "macchiato",
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
                    indent_scope_color = "lavender",
                },
                lualine = {
                    macchiato = macchiato_lualine_overwrites,
                },
            },
            custom_highlights = function(colors)
                -- colors - https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/macchiato.lua
                return {
                    WinSeparator = { fg = colors.surface1 },
                    Folded = { bg = colors.surface0 },
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
