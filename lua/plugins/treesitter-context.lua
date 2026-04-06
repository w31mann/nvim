require("treesitter-context").setup()

vim.keymap.set("n", "<leader>cu", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
