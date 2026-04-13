require("outline").setup({
    keymaps = {
        peek_location = "p",
        toggle_preview = "P",
    },
})

vim.keymap.set("n", "<leader><leader>o", "<cmd>Outline<cr>", {
    desc = "Toggle outline sidebar",
})
