-- treesitter-context - https://github.com/nvim-treesitter/nvim-treesitter-context

return {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("treesitter-context").setup()

        vim.keymap.set("n", "<leader>cu", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true })
    end,
}
