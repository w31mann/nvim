-- mini-ai - https://github.com/nvim-mini/mini.ai
-- still needed with nvim 0.12?

return {
    "nvim-mini/mini.ai",
    version = false,
    dependencies = {
        -- treesitter-context - https://github.com/nvim-treesitter/nvim-treesitter-context
        "nvim-treesitter/nvim-treesitter-context",
        -- treesitter-textobjects - https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        -- "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local mini_ai = require("mini.ai")
        -- local spec_treesitter = mini_ai.gen_spec.treesitter

        mini_ai.setup({
            n_lines = 200,
            -- custom_textobjects = {
            --     S = spec_treesitter({ a = "@scope.outer", i = "@scope.inner"}),
            --     F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
            -- },
        })
    end,
}
