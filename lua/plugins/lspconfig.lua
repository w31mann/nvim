-- lspconfig - https://github.com/neovim/nvim-lspconfig

local function extra_settings(server)
    if server == "bashls" then
        return require("plugins.lsp.settings.bashls")
    end
    if server == "clangd" then
        return require("plugins.lsp.settings.clangd")
    end
    if server == "pyright" then
        return require("plugins.lsp.settings.pyright")
    end
    if server == "rust_analyzer" then
        return require("plugins.lsp.settings.rust_analyzer")
    end
    if server == "lua_ls" then
        return require("plugins.lsp.settings.lua_ls")
    end
    if server == "jsonls" then
        return require("plugins.lsp.settings.jsonls")
    end
    if server == "yamlls" then
        return require("plugins.lsp.settings.yamlls")
    end

    return {}
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local handlers = require("plugins.lsp.handlers")

        require("lspconfig.ui.windows").default_options = {
            border = "single",
        }

        handlers.setup()

        local servers = {
            "bashls",
            "clangd",
            "cmake",
            "dockerls",
            "jsonls",
            "marksman",
            "lua_ls",
            "pyright",
            "taplo",
            "yamlls",
        }

        local ls_opts = {}

        for _, server in pairs(servers) do
            ls_opts = {
                on_attach = handlers.on_attach,
                capabilities = handlers.capabilities,
            }

            ls_opts = vim.tbl_deep_extend("force", extra_settings(server), ls_opts)

            lspconfig[server].setup(ls_opts)
        end
    end,
}
