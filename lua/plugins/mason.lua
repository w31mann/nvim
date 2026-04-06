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
    },
    auto_update = true,
})
