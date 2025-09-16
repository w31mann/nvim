-- conform.nvim - https://github.com/stevearc/conform.nvim

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        -- e.g., used with `gq`
        -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        conform.setup({
            formatters_by_ft = {
                cpp = { "clang_format" },
                lua = { "stylua" },
                markdown = { "prettier" },
                -- python = { "isort", "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                sh = { "beautysh", "shellharden" },
                ["*"] = { "trim_newlines", "trim_whitespace" },
            },
            init = function()
                vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            end,
        })

        conform.formatters.beautysh = {
            prepend_args = {
                "--force-function-style=paronly",
                "--indent-size=4",
            },
        }
        conform.formatters.clang_format = {
            prepend_args = {
                "--fallback-style=Google",
            },
        }

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                async = false,
                lsp_format = "last",
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
