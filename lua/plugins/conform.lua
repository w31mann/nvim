-- conform.nvim - https://github.com/stevearc/conform.nvim

local function setup_keymaps()
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
        require("conform").format({
            async = false,
            lsp_format = "last",
        })
    end, { desc = "Format file or range (in visual mode)" })
end

return {
    "stevearc/conform.nvim",
    keys = {
        { "<leader>f", mode = { "n", "v" }, desc = "Format file or range (in visual mode)" },
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                cpp = { "clang_format" },
                lua = { "stylua" },
                markdown = { "prettier" },
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

        setup_keymaps()
    end,
}
