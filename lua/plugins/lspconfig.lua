-- lspconfig - https://github.com/neovim/nvim-lspconfig

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp_setup = require("plugins.lsp.setup")

        lsp_setup.init()

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                lsp_setup.bindings(ev.buf)

                if vim.b[ev.buf].diagnostics_disabled or vim.g.diagnostics_disabled then
                    vim.diagnostic.enable(false, { bufnr = ev.buf })
                end

                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                if client ~= nil and client:supports_method("textDocument/inlayHint", ev.buf) then
                    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                end
            end,
        })

        local servers = {
            "bashls",
            "clangd",
            "neocmake",
            -- "dockerls",
            "jsonls",
            "marksman",
            "lua_ls",
            -- "pyright",
            "taplo",
            "yamlls",
        }

        for _, server in pairs(servers) do
            vim.lsp.enable(server)

            local lsp_settings_found, lsp_settings =
                pcall(require, "plugins.lsp.settings." .. server)
            if lsp_settings_found then
                vim.lsp.config(server, lsp_settings)
            end
        end
    end,
}
