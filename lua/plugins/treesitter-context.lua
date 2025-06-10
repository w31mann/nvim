-- treesitter-context - https://github.com/nvim-treesitter/nvim-treesitter-context

return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("treesitter-context").setup({})

        vim.keymap.set("n", "<leader>u", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { desc = "Jump to outer context" })
    end,
}
