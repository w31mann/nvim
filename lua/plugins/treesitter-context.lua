-- treesitter-context - https://github.com/nvim-treesitter/nvim-treesitter-context

return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("treesitter-context").setup({})

        vim.keymap.set("n", "<leader>cu", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { desc = "Jump to outer context" })
        vim.keymap.set(
            "n",
            "<leader>tc",
            require("treesitter-context").toggle,
            { desc = "Toggle treesitter context" }
        )
    end,
}
