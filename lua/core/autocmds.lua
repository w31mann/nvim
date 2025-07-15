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
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
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
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
    group = cursorword_augroup,
    desc = "Create directories when saving files",
})
