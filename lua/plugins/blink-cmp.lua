-- blink.cmp - https://github.com/Saghen/blink.cmp

return {
    "saghen/blink.cmp",
    -- version = "v0.*",
    build = "cargo build --release --locked",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
        {
            -- friendly snippets - https://github.com/rafamadriz/friendly-snippets
            "rafamadriz/friendly-snippets",
        },
        -- {
        --     -- colorful-menu - https://github.com/xzbdmw/colorful-menu.nvim
        --     "xzbdmw/colorful-menu.nvim",
        -- },
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
                draw = {
                    treesitter = { "lsp" },
                    -- colorful-menu
                    -- columns = { { "kind_icon" }, { "label", gap = 1 } },
                    -- components = {
                    --     label = {
                    --         text = function(ctx)
                    --             return require("colorful-menu").blink_components_text(ctx)
                    --         end,
                    --         highlight = function(ctx)
                    --             return require("colorful-menu").blink_components_highlight(ctx)
                    --         end,
                    --     },
                    -- },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    border = vim.g.BORDER,
                },
            },
            ghost_text = {
                -- enabled = true,
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
