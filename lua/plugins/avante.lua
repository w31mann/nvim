-- avante - https://github.com/yetone/avante.nvim

return {
    "yetone/avante.nvim",
    -- tag = "v0.0.27", -- pin version to fix https://github.com/yetone/avante.nvim/issues/2689
    build = "make",
    version = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        -- The below dependencies are optional,
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
        "zbirenbaum/copilot.lua",
    },
    keys = {
        {
            "<leader>aa",
            function()
                require("avante.api").ask()
            end,
            desc = "Avante: Ask (open chat window)",
        },
        {
            "<leader>at",
            function()
                require("avante.api").toggle()
            end,
            desc = "Avante: Toggle (toggle chat window)",
        },
    },
    opts = {
        instructions_file = ".avante/instructions.md",
        provider = "copilot",
        providers = {
            copilot = {
                model = "gpt-4.1",
                -- model = "claude-sonnet-4",
                -- model = "claude-sonnet-4.5",
            },
        },
        web_search_engine = {
            -- tavily, serpapi, google, kagi, brave, or searxng
            provider = "tavily",
            -- provider = "google",
        },
        behaviour = {
            auto_approve_tool_permissions = false,
            confirmation_ui_style = "popup",
        },
        windows = {
            width = 45,
            input = {
                height = 10,
            },
        },
        selector = {
            provider = "telescope",
        },
    },
}
