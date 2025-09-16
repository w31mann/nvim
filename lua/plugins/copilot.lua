-- copilot.lua -- https://github.com/zbirenbaum/copilot.lua
--
-- NOTE setup authentication on first use:
-- - execute ':Copilot auth'
-- - follow instructions

return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            -- server_opts_overrides = {
            --     -- For GitHub Enterprise Server or SSO environments
            --     -- You may need to configure these based on your organization's setup
            --     settings = {
            --         advanced = {
            --             listCount = 10,
            --             inlineSuggestCount = 3,
            --         },
            --     },
            -- },
        })
    end,
}
