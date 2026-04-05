local m = {}

m.init = function()
    local icons = require("core.icons")

    local diagnostics_config = {
        virtual_text = {
            prefix = "",
            current_line = true,
        },
        -- virtual_lines = {
        --     current_line = true,
        -- },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            },
        },
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "if_many",
            header = "",
            suffix = "",
            format = function(d)
                local t = vim.deepcopy(d)
                if d.code then
                    t.message = string.format("%s [%s]", t.message, t.code):gsub("1. ", "")
                end
                return t.message
            end,
        },
    }

    vim.diagnostic.config(diagnostics_config)
end

m.bindings = function(bufnr)
    vim.keymap.set("n", "grr", function()
        require("snacks").picker.lsp_references()
    end, { buffer = bufnr, desc = "Search references" })
    vim.keymap.set("n", "gd", function()
        require("snacks").picker.lsp_definitions()
    end, { buffer = bufnr, desc = "Go to definition" })
    vim.keymap.set("n", "gri", function()
        require("snacks").picker.lsp_implementations()
    end, { buffer = bufnr, desc = "Go to implementation" })
    vim.keymap.set("n", "grt", function()
        require("snacks").picker.lsp_type_definitions()
    end, { buffer = bufnr, desc = "Go to type definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
        buffer = bufnr,
        desc = "Go to declaration",
    })
    vim.keymap.set("n", "S", vim.lsp.buf.signature_help, {
        buffer = bufnr,
        desc = "Signature help",
    })
    vim.keymap.set("n", "<leader><leader>d", function()
        require("core.utils").toggleDiagnostics(true)
    end, {
        buffer = bufnr,
        desc = "Toggle diagnostics (globally)",
    })
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {
        buffer = bufnr,
        desc = "List workspace folders",
    })

    -- mac
    -- <option> - d
    vim.keymap.set("n", "∂", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, { buffer = bufnr, desc = "Go to next diagnostic" })
    -- <option> - D
    vim.keymap.set("n", "™", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, { buffer = bufnr, desc = "Go to previous diagnostic" })

    -- linux
    vim.keymap.set("n", "<m-d>", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, { buffer = bufnr, desc = "Go to next diagnostic" })
    vim.keymap.set("n", "<m-D>", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, { buffer = bufnr, desc = "Go to previous diagnostic" })

    vim.keymap.set("n", "<leader>iH", require("core.utils").toggleInlayHints, {
        buffer = bufnr,
        desc = "Toggle inlay hints",
    })

    vim.keymap.set("n", "<leader>iL", require("core.utils").toggleCodeLens, {
        buffer = bufnr,
        desc = "Toggle code lens",
    })

    vim.keymap.set("n", "<leader>tv", function()
        local new_config = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = new_config })
    end, { desc = "Toggle diagnostic virtual_lines" })
end

return m
