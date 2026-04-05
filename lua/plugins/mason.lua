-- mason - https://github.com/williamboman/mason.nvim

return {
    "williamboman/mason.nvim",
    branch = "main",
    dependencies = {
        -- mason-tool-installer - https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()

        require("mason-tool-installer").setup({
            ensure_installed = {
                -- lsp
                "bash-language-server",
                "clangd",
                "neocmakelsp",
                "json-lsp",
                "lua-language-server",
                "marksman",
                "rust-analyzer",
                "taplo",
                "yaml-language-server",
                -- formatters
                "beautysh",
                "clang-format",
                "prettier",
                "shellharden",
                "stylua",
                -- linters
                "gitlint",
                "markdownlint-cli2",
                "shellcheck",
                -- dap
                "codelldb",
            },
            auto_update = true,
        })
    end,
}
