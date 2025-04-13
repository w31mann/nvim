-- lspconfig - https://github.com/neovim/nvim-lspconfig

-- local function extra_settings(server)
--     if server == "bashls" then
--         return require("plugins.lsp.settings.bashls")
--     elseif server == "clangd" then
--         return require("plugins.lsp.settings.clangd")
--     elseif server == "pyright" then
--         return require("plugins.lsp.settings.pyright")
--     elseif server == "rust_analyzer" then
--         return require("plugins.lsp.settings.rust_analyzer")
--     elseif server == "lua_ls" then
--         return require("plugins.lsp.settings.lua_ls")
--     elseif server == "jsonls" then
--         return require("plugins.lsp.settings.jsonls")
--     elseif server == "yamlls" then
--         return require("plugins.lsp.settings.yamlls")
--     elseif server == "neocmake" then
--         return require("plugins.lsp.settings.neocmake")
--     else
--         return {}
--     end
-- end

-- return {
--     "neovim/nvim-lspconfig",
--     config = function()
--         local lspconfig = require("lspconfig")
--         local handlers = require("plugins.lsp.handlers")
--
--         handlers.setup()
--
--         local servers = {
--             "bashls",
--             "clangd",
--             "neocmake",
--             "dockerls",
--             "jsonls",
--             "marksman",
--             "lua_ls",
--             "pyright",
--             "taplo",
--             "yamlls",
--         }
--
--         local ls_opts = {}
--
--         for _, server in pairs(servers) do
--             ls_opts = {
--                 on_attach = handlers.on_attach,
--                 capabilities = handlers.capabilities,
--             }
--
--             ls_opts = vim.tbl_deep_extend("force", extra_settings(server), ls_opts)
--
--             lspconfig[server].setup(ls_opts)
--         end
--     end,
-- }

return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                -- Unset 'formatexpr'
                vim.bo[args.buf].formatexpr = nil
                -- Unset 'omnifunc'
                vim.bo[args.buf].omnifunc = nil
                -- Unmap K
                vim.keymap.del("n", "K", { buffer = args.buf })
            end,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                if vim.b[ev.buf].diagnostics_disabled or vim.g.diagnostics_disabled then
                    vim.diagnostic.enable(false, { bufnr = ev.buf })
                end

                if client ~= nil and client:supports_method("textDocument/inlayHint", ev.buf) then
                    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                end
            end,
        })
        vim.lsp.enable("bashls")
        vim.lsp.config("bashls", require("plugins.lsp.settings.bashls"))

        vim.lsp.enable("lua_ls")
    end,
}
