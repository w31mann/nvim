-- opencode - https://github.com/NickvanDyke/opencode.nvim

return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
        vim.keymap.set({ "n", "x" }, "øå", function()
            require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode" })
        vim.keymap.set({ "n", "x" }, "<m-oa>", function()
            require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode" })

        vim.keymap.set({ "n", "x" }, "ø≈", function()
            require("opencode").select()
        end, { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "x" }, "<m-ox>", function()
            require("opencode").select()
        end, { desc = "Execute opencode action…" })

        vim.keymap.set({ "n", "x" }, "ø±", function()
            require("opencode").prompt("@this")
        end, { desc = "Add to opencode" })
        vim.keymap.set({ "n", "x" }, "<m-o+>", function()
            require("opencode").prompt("@this")
        end, { desc = "Add to opencode" })

        vim.keymap.set({ "n", "t" }, "øø", function()
            require("opencode").toggle()
        end, { desc = "Toggle opencode" })
        vim.keymap.set({ "n", "t" }, "<m-oo>", function()
            require("opencode").toggle()
        end, { desc = "Toggle opencode" })
    end,
}
