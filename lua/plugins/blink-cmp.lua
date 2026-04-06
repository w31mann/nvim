require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<c-z>"] = { "accept" },
    },
    sources = {
        default = { "lsp", "buffer", "snippets", "path", "cmdline" },
    },
    cmdline = {
        keymap = {
            preset = "cmdline",
            ["<c-z>"] = { "accept" },
        },
        completion = {
            menu = { auto_show = true },
            ghost_text = { enabled = false },
        },
    },
    completion = {
        keyword = { range = "full" },
        menu = {
            draw = {
                treesitter = { "lsp" },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
        ghost_text = {
            enabled = false,
        },
    },
    signature = {
        enabled = true,
        window = {
            scrollbar = true,
        },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
})
