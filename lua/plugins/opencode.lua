-- opencode - https://github.com/NickvanDyke/opencode.nvim

return {
    "NickvanDyke/opencode.nvim",
    config = function()
        vim.g.opencode_opts = {
            -- Port will be auto-discovered using lsof
            -- If no instance found, provider will auto-start one
            auto_reload = true,
        }

        -- Required for auto_reload
        vim.o.autoread = true

        vim.keymap.set({ "n", "x" }, "øå", function()
            require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode" })
        vim.keymap.set({ "n", "x" }, "<m-o><m-a>", function()
            require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode" })

        vim.keymap.set({ "n", "x" }, "ø≈", function()
            require("opencode").select()
        end, { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "x" }, "<m-o><m-x>", function()
            require("opencode").select()
        end, { desc = "Execute opencode action…" })

        vim.keymap.set({ "n", "x" }, "ø±", function()
            require("opencode").prompt("@this")
        end, { desc = "Add to opencode" })
        vim.keymap.set({ "n", "x" }, "<m-o><m-+>", function()
            require("opencode").prompt("@this")
        end, { desc = "Add to opencode" })

        vim.keymap.set({ "n", "t" }, "øø", function()
            require("opencode").toggle()
        end, { desc = "Toggle opencode" })
        vim.keymap.set({ "n", "t" }, "<m-o><m-o>", function()
            require("opencode").toggle()
        end, { desc = "Toggle opencode" })
    end,
}
