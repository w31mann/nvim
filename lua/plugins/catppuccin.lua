require("catppuccin").setup({
    flavour = "mocha",
    term_colors = true,
    no_italic = true,
    no_underline = true,
    float = {
        transparent = true,
        solid = true,
    },
    default_integrations = false,
    integrations = {
        blink_cmp = { enabled = true, style = "solid" },
        fzf = true,
        gitsigns = true,
        mason = true,
        native_lsp = {
            enabled = true,
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
        },
        semantic_tokens = true,
        treesitter = true,
        treesitter_context = true,
    },
    custom_highlights = function(colors)
        return {
            WinSeparator = { fg = colors.surface1 },
            Folded = { bg = colors.surface0 },
            Pmenu = { bg = colors.base, fg = colors.surface1 },
            BlinkCmpDocBorder = { bg = colors.base, fg = colors.surface1 },
            BlinkCmpDocSeparator = { bg = colors.base, fg = colors.surface1 },
        }
    end,
})
