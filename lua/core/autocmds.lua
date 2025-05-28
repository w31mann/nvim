local core_augroup = vim.api.nvim_create_augroup("core_augroup", {
    clear = true,
})
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
    end,
    group = core_augroup,
})
-- restore position
vim.api.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
    group = core_augroup,
})
-- equalize splits
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
    group = core_augroup,
})

-- highlight word under cursor using LSP
local cursorword_augroup = vim.api.nvim_create_augroup("cursorword_augroup", {
    clear = true,
})
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function(event_args)
        local line_count = vim.api.nvim_buf_line_count(event_args.buf)
        if line_count < 10000 then
            vim.lsp.buf.document_highlight()
        end
    end,
    group = cursorword_augroup,
})
vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
    callback = function(event_args)
        local line_count = vim.api.nvim_buf_line_count(event_args.buf)
        if line_count < 10000 then
            vim.lsp.buf.clear_references()
        end
    end,
    group = cursorword_augroup,
})
