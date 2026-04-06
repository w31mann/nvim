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
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

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
