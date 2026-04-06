local core_augroup = vim.api.nvim_create_augroup("core_augroup", {
    clear = true,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "Search", timeout = 200 })
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
vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if vim.treesitter.language.add(lang or ev.match) then
            vim.treesitter.start(ev.buf)
        end
    end,
    group = core_augroup,
    desc = "Enable treesitter highlighting for filetypes with available parsers",
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
    callback = function(ev)
        local name = vim.api.nvim_buf_get_name(ev.buf)
        if name == "" then
            return
        end

        local dir = vim.fs.dirname(name)
        if not vim.uv.fs_stat(dir) then
            vim.fn.mkdir(dir, "p")
        end
    end,
    group = core_augroup,
    desc = "Create directories when saving files",
})

local colorcolumn_augroup = vim.api.nvim_create_augroup("colorcolumn_augroup", {
    clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "terminal", "qf" },
    callback = function()
        vim.opt_local.colorcolumn = ""
    end,
    group = colorcolumn_augroup,
    desc = "Disable colorcolumn for specific filetypes",
})

-- Trailing whitespace highlight
vim.api.nvim_set_hl(0, "ExtraWhitespace", { link = "DiagnosticError" })
vim.cmd("match ExtraWhitespace /\\s\\+$/")
