-- opencode - https://github.com/NickvanDyke/opencode.nvim

return {
    "NickvanDyke/opencode.nvim",
    keys = {
        -- Ask opencode (Mac)
        {
            "øå",
            function()
                require("opencode").ask("@this: ", { submit = true })
            end,
            mode = { "n", "x" },
            desc = "Ask opencode",
        },
        -- Ask opencode (Linux)
        {
            "<m-o><m-a>",
            function()
                require("opencode").ask("@this: ", { submit = true })
            end,
            mode = { "n", "x" },
            desc = "Ask opencode",
        },
        -- Execute opencode action (Mac)
        {
            "ø≈",
            function()
                require("opencode").select()
            end,
            mode = { "n", "x" },
            desc = "Execute opencode action…",
        },
        -- Execute opencode action (Linux)
        {
            "<m-o><m-x>",
            function()
                require("opencode").select()
            end,
            mode = { "n", "x" },
            desc = "Execute opencode action…",
        },
        -- Add to opencode (Mac)
        {
            "ø±",
            function()
                require("opencode").prompt("@this")
            end,
            mode = { "n", "x" },
            desc = "Add to opencode",
        },
        -- Add to opencode (Linux)
        {
            "<m-o><m-+>",
            function()
                require("opencode").prompt("@this")
            end,
            mode = { "n", "x" },
            desc = "Add to opencode",
        },
        -- Toggle opencode (Mac)
        {
            "øø",
            function()
                require("opencode").toggle()
            end,
            mode = { "n", "t" },
            desc = "Toggle opencode",
        },
        -- Toggle opencode (Linux)
        {
            "<m-o><m-o>",
            function()
                require("opencode").toggle()
            end,
            mode = { "n", "t" },
            desc = "Toggle opencode",
        },
    },
    config = function()
        vim.g.opencode_opts = {
            -- Port will be auto-discovered using lsof
            -- If no instance found, provider will auto-start one
            auto_reload = true,
            provider = {
                snacks = {
                    -- Use a unique ID to prevent multiple instances
                    id = "opencode_main",
                    -- Ensure OpenCode terminal uses full window size
                    win = {
                        style = "terminal",
                        position = "right",
                        width = 0.4,
                        height = 1.0,
                        wo = {
                            winbar = "",
                        },
                    },
                },
            },
        }

        -- Required for auto_reload
        vim.o.autoread = true
    end,
}
