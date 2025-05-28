local core_augroup = vim.api.nvim_create_augroup("core_augroup", {
    clear = true,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
    end,
    group = core_augroup,
    desc = "Highlight on yank",
})
vim.api.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
    group = core_augroup,
    desc = "Restore the cursor position",
})
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
    group = core_augroup,
    desc = "Equalize splits",
})

local cursorword_augroup = vim.api.nvim_create_augroup("cursorword_augroup", {
    clear = true,
})
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function(ev)
        local lsp_clients = vim.lsp.get_clients({ bufnr = ev.buf })
        for _, client in ipairs(lsp_clients) do
            if client:supports_method("textDocument/documentHighlight", ev.buf) then
                vim.lsp.buf.document_highlight()
                break
            end
        end
    end,
    group = cursorword_augroup,
    desc = "Highlight the word under cursor",
})
vim.api.nvim_create_autocmd({ "CursorMoved", "ModeChanged" }, {
    callback = function(ev)
        local lsp_clients = vim.lsp.get_clients({ bufnr = ev.buf })
        for _, client in ipairs(lsp_clients) do
            if client:supports_method("textDocument/documentHighlight", ev.buf) then
                vim.lsp.buf.clear_references()
                break
            end
        end
    end,
    group = cursorword_augroup,
    desc = "Reset the highlight for word under cursor",
})
