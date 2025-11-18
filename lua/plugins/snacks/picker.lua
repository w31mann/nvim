-- snack.picker - https://github.com/folke/snacks.nvim/blob/main/docs/picker.md

local M = {}

M.config = {
    enabled = true,
    -- Use default layout or vertical if window is too narrow
    layout = {
        cycle = true,
        preset = function()
            return vim.o.columns >= 120 and "default" or "vertical"
        end,
    },
    -- Matcher configuration matching Telescope's behavior
    matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        sort_empty = false,
    },
    -- Window configuration
    win = {
        input = {
            keys = {
                -- Close on Ctrl-c and Esc (like Telescope)
                ["<c-c>"] = { "close", mode = { "n", "i" } },
                ["<Esc>"] = { "close", mode = { "n", "i" } },
                -- Navigation matching Telescope
                ["<c-j>"] = { "list_down", mode = { "i", "n" } },
                ["<c-k>"] = { "list_up", mode = { "i", "n" } },
                ["<c-q>"] = { "qflist", mode = { "i", "n" } },
                ["<cr>"] = { "confirm", mode = { "n", "i" } },
            },
        },
        list = {
            keys = {
                -- Navigation matching Telescope
                ["<c-j>"] = "list_down",
                ["<c-k>"] = "list_up",
                ["<c-q>"] = "qflist",
            },
        },
    },
}

-- Setup keybindings
function M.setup()
    -- <leader>sf - Find files (exclude .git, target, build like Telescope)
    vim.keymap.set("n", "<leader>sf", function()
        require("snacks").picker.files({
            hidden = true,
            follow = true,
            exclude = { ".git", "target", "build" },
        })
    end, { desc = "Search files" })

    -- <leader>sF - Find ALL files (no ignore, no exclude)
    vim.keymap.set("n", "<leader>sF", function()
        require("snacks").picker.files({
            hidden = true,
            ignored = true,
            follow = true,
        })
    end, { desc = "Search files (no ignore)" })

    -- <leader>sg - Live grep
    vim.keymap.set("n", "<leader>sg", function()
        require("snacks").picker.grep()
    end, { desc = "Fuzzy search string" })

    -- <leader>sG - Grep string under cursor
    vim.keymap.set("n", "<leader>sG", function()
        require("snacks").picker.grep_word()
    end, { desc = "Search string under cursor" })

    -- <leader>sb - Search open buffers
    vim.keymap.set("n", "<leader>sb", function()
        require("snacks").picker.buffers({
            sort_lastused = true,
            current = false, -- ignore current buffer
        })
    end, { desc = "Search open buffers" })

    -- <leader>sd - Search diagnostics (buffer only)
    vim.keymap.set("n", "<leader>sd", function()
        require("snacks").picker.diagnostics_buffer()
    end, { desc = "Search diagnostics" })

    -- <leader>sc - Command history
    vim.keymap.set("n", "<leader>sc", function()
        require("snacks").picker.command_history()
    end, { desc = "Search command history" })

    -- <leader>sR - Resume last search
    vim.keymap.set("n", "<leader>sR", function()
        require("snacks").picker.resume()
    end, { desc = "Resume last search" })

    -- <leader>sm - Marks
    vim.keymap.set("n", "<leader>sm", function()
        require("snacks").picker.marks()
    end, { desc = "Search marks" })

    -- <leader>sr - Registers
    vim.keymap.set("n", "<leader>sr", function()
        require("snacks").picker.registers()
    end, { desc = "Search registers" })

    -- <leader>sh - Help tags
    vim.keymap.set("n", "<leader>sh", function()
        require("snacks").picker.help()
    end, { desc = "Search help tags" })
end

return M
