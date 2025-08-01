-- telescope - https://github.com/nvim-telescope/telescope.nvim

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        {
            -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    keys = {
        {
            "<leader>sf",
            function()
                require("telescope.builtin").find_files({
                    prompt_title = "Find Files",
                    follow = true,
                    hidden = true,
                    find_command = {
                        "fd",
                        "--type",
                        "f",
                        "--color",
                        "never",
                        "--exclude",
                        ".git",
                        "--exclude",
                        "target",
                        "--exclude",
                        "build",
                    },
                })
            end,
            desc = "Search files",
        },
        {
            "<leader>sF",
            function()
                require("telescope.builtin").find_files({
                    prompt_title = "Find Files",
                    follow = true,
                    no_ignore = true,
                    no_ignore_parent = true,
                    hidden = true,
                    find_command = { "fd", "--type", "f", "--color", "never" },
                })
            end,
            desc = "Search files",
        },
        {
            "<leader>sg",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Fuzzy search string",
        },
        {
            "<leader>sG",
            function()
                require("telescope.builtin").grep_string()
            end,
            desc = "Search string under cursor",
        },
        {
            "<leader>sb",
            function()
                require("telescope.builtin").buffers({
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    sort_mru = true,
                })
            end,
            desc = "Search open buffers",
        },
        {
            "<leader>sd",
            function()
                require("telescope.builtin").diagnostics({ bufnr = 0 })
            end,
            desc = "Search diagnostics",
        },
        {
            "<leader>sc",
            function()
                require("telescope.builtin").command_history()
            end,
            desc = "Search command history",
        },
        {
            "<leader>sR",
            function()
                require("telescope.builtin").resume()
            end,
            desc = "Resume last search",
        },
        {
            "<leader>sm",
            function()
                require("telescope.builtin").marks()
            end,
            desc = "Search marks",
        },
        {
            "<leader>sr",
            function()
                require("telescope.builtin").registers()
            end,
            desc = "Search registers",
        },
        {
            "<leader>sh",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Search help tags",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                layout_config = {
                    horizontal = {
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    width = 0.87,
                    height = 0.80,
                },
                mappings = {
                    i = {
                        ["<c-c>"] = actions.close,
                        ["<esc>"] = actions.close,
                        ["<c-j>"] = actions.move_selection_next,
                        ["<c-k>"] = actions.move_selection_previous,
                        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<cr>"] = actions.select_default + actions.center,
                    },
                    n = {
                        ["<c-j>"] = actions.move_selection_next,
                        ["<c-k>"] = actions.move_selection_previous,
                        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        telescope.load_extension("fzf")
    end,
}
