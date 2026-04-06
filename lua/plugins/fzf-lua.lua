local fzf = require("fzf-lua")

fzf.setup({
    winopts = {
        preview = {
            layout = "vertical",
        },
    },
    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept",
        },
    },
})

vim.keymap.set("n", "<leader>sf", function()
    fzf.files({ hidden = true, follow = true })
end, { desc = "Search files" })

vim.keymap.set("n", "<leader>sF", function()
    fzf.files({ hidden = true, no_ignore = true, follow = true })
end, { desc = "Search files (no ignore)" })

vim.keymap.set("n", "<leader>sg", function()
    fzf.live_grep()
end, { desc = "Fuzzy search string" })

vim.keymap.set("n", "<leader>sG", function()
    fzf.grep_cword()
end, { desc = "Search string under cursor" })

vim.keymap.set("n", "<leader>sb", function()
    fzf.buffers({ sort_lastused = true })
end, { desc = "Search open buffers" })

vim.keymap.set("n", "<leader>sd", function()
    fzf.diagnostics_document()
end, { desc = "Search diagnostics" })

vim.keymap.set("n", "<leader>sc", function()
    fzf.command_history()
end, { desc = "Search command history" })

vim.keymap.set("n", "<leader>sR", function()
    fzf.resume()
end, { desc = "Resume last search" })

vim.keymap.set("n", "<leader>sm", function()
    fzf.marks()
end, { desc = "Search marks" })

vim.keymap.set("n", "<leader>sr", function()
    fzf.registers()
end, { desc = "Search registers" })

vim.keymap.set("n", "<leader>sh", function()
    fzf.helptags()
end, { desc = "Search help tags" })
