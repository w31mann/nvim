-- lspconfig - https://github.com/neovim/nvim-lspconfig

local function extra_settings(server)
    if server == "bashls" then
        return require("plugins.lsp.settings.bashls")
    elseif server == "clangd" then
        return require("plugins.lsp.settings.clangd")
    elseif server == "pyright" then
        return require("plugins.lsp.settings.pyright")
    elseif server == "rust_analyzer" then
        return require("plugins.lsp.settings.rust_analyzer")
    elseif server == "lua_ls" then
        return require("plugins.lsp.settings.lua_ls")
    elseif server == "jsonls" then
        return require("plugins.lsp.settings.jsonls")
    elseif server == "yamlls" then
        return require("plugins.lsp.settings.yamlls")
    elseif server == "neocmake" then
        return require("plugins.lsp.settings.neocmake")
    else
        return {}
    end
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local handlers = require("plugins.lsp.handlers")

        handlers.setup()

        local servers = {
            "bashls",
            "clangd",
            "neocmake",
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
