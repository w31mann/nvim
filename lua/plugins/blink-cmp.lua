-- blink.cmp - https://github.com/Saghen/blink.cmp

return {
    "saghen/blink.cmp",
    -- version = "1.*",
    build = "cargo build --release --locked",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
        {
            -- friendly snippets - https://github.com/rafamadriz/friendly-snippets
            "rafamadriz/friendly-snippets",
        },
    },
    opts = {
        keymap = {
            preset = "default",
            ["<c-z>"] = { "accept" },
        },
        sources = {
            default = { "lsp", "buffer", "snippets", "path", "cmdline" },
            lsp = {
                score_offset = 10,
            },
            buffer = {
                score_offset = 5,
            },
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
            prebuilt_binaries = {
                download = false,
            },
            sort = { "score", "exact", "sort_text" },
        },
    },
}
