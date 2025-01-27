-- outline - https://github.com/hedyhli/outline.nvim

return {
    "hedyhli/outline.nvim",
    keys = {
        {
            "<leader>o",
            "<cmd>Outline<cr>",
            desc = "Toggle outline",
        },
    },
    opts = {
        keymaps = {
            peek_location = "p",
            toggle_preview = "P",
        },
    },
}
