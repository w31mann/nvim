-- blink.cmp - https://github.com/Saghen/blink.cmp

return {
    "saghen/blink.cmp",
    -- version = "v0.*",
    build = "cargo build --release --locked",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
        {
            -- luasnip - https://github.com/L3MON4D3/LuaSnip
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            dependencies = {
                -- friendly snippets - https://github.com/rafamadriz/friendly-snippets
                "rafamadriz/friendly-snippets",
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    opts = {
        keymap = {
            preset = "default",
            ["<c-z>"] = { "accept" },
        },
        completion = {
            keyword = { range = "full" },
            menu = {
                border = vim.g.BORDER,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    border = vim.g.BORDER,
                },
            },
            ghost_text = {
                enabled = true,
            },
        },
        signature = {
            enabled = true,
            window = {
                border = vim.g.BORDER,
                scrollbar = true,
            },
        },
        fuzzy = {
            prebuilt_binaries = {
                download = false,
            },
        },
    },
}
