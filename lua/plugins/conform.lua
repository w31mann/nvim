-- conform.nvim - https://github.com/stevearc/conform.nvim

return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({
                    async = false,
                    -- never (default), fallback, prefer, first, last
                    lsp_format = "last",
                })
            end,
            { "n", "v" },
            desc = "Format",
        },
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                cpp = { "clang_format" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "isort", "black" },
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
    end,
}
