-- mason - https://github.com/williamboman/mason.nvim

return {
    "williamboman/mason.nvim",
    branch = "main",
    dependencies = {
        -- mason-lspconfig - https://github.com/williamboman/mason-lspconfig.nvim
        "williamboman/mason-lspconfig.nvim",
        -- mason-tool-installer - https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()

        local mason_lspconfig = require("mason-lspconfig")

        -- ensure LSP servers to be installed
        mason_lspconfig.setup({
            automatic_enable = false,
            automatic_installation = false,
            ensure_installed = {
                -- example on how to select specific version:
                -- "rust_analyzer@2024-04-29",
                "bashls",
                "clangd",
                -- "cmake",
                "neocmake",
                -- "dockerls",
                "jsonls",
                "lua_ls",
                "marksman",
                -- "pyright",
                "rust_analyzer",
                "taplo",
                "yamlls",
            },
        })

        local mason_tool_installer = require("mason-tool-installer")

        -- ensure formatters and linters to be installed
        mason_tool_installer.setup({
            ensure_installed = {
                "beautysh",
                -- "black",
                "clang-format",
                "codelldb",
                "gitlint",
                -- "isort",
                "markdownlint-cli2",
                "prettier",
                "shellcheck",
                "shellharden",
                "stylua",
            },
            auto_update = true,
        })
    end,
}
