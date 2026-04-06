local lsp_setup = require("plugins.lsp.setup")

lsp_setup.init()

local lsp_attach_augroup = vim.api.nvim_create_augroup("lsp_attach_augroup", {
    clear = true,
})
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_augroup,
    callback = function(ev)
        lsp_setup.bindings(ev.buf)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client:supports_method("textDocument/inlayHint", ev.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end

        if client ~= nil and client:supports_method("textDocument/codeLens", ev.buf) then
            vim.lsp.codelens.enable(true, { bufnr = ev.buf })
        end
    end,
    desc = "Setup a LSP client on attach",
})

local servers = {
    "bashls",
    "clangd",
    "neocmake",
    "jsonls",
    "marksman",
    "lua_ls",
    "rust_analyzer",
    "taplo",
    "yamlls",
}

for _, server in pairs(servers) do
    local lsp_settings_found, lsp_settings = pcall(require, "plugins.lsp.settings." .. server)
    if lsp_settings_found then
        vim.lsp.config(server, lsp_settings)
    end

    vim.lsp.enable(server)
end
