require("blink.cmp").setup({
    keymap = {
        ["<c-z>"] = { "accept" },
    },
    cmdline = {
        keymap = {
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
        },
        ghost_text = {
            enabled = true,
        },
    },
    signature = {
        enabled = true,
        window = {
            scrollbar = true,
        },
    },
})
