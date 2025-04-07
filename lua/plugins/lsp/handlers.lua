local function lsp_keymaps(bufnr)
    local telescope_builtin_ok, telescope_builtin = pcall(require, "telescope.builtin")
    if not telescope_builtin_ok then
        vim.keymap.set("n", "grr", vim.lsp.buf.references, {
            buffer = bufnr,
            desc = "Go to references",
        })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
            buffer = bufnr,
            desc = "Go to definition",
        })
        vim.keymap.set("n", "gri", vim.lsp.buf.implementation, {
            buffer = bufnr,
            desc = "Go to implementation",
        })
    else
        vim.keymap.set("n", "grr", telescope_builtin.lsp_references, {
            buffer = bufnr,
            desc = "Search references",
        })
        vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, {
            buffer = bufnr,
            desc = "Go to definition",
        })
        vim.keymap.set("n", "gri", telescope_builtin.lsp_implementations, {
            buffer = bufnr,
            desc = "Go to implementation",
        })
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
        buffer = bufnr,
        desc = "Go to declaration",
    })
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {
        buffer = bufnr,
        desc = "Go to definition",
    })
    vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, {
        buffer = bufnr,
        desc = "Code actions",
    })
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, {
        buffer = bufnr,
        desc = "Rename",
    })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        buffer = bufnr,
        desc = "Hover information",
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

    vim.keymap.set("n", "<leader>tv", function()
        local new_config = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = new_config })
    end, { desc = "Toggle diagnostic virtual_lines" })
end

local m = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
if blink_cmp_ok then
    m.capabilities = blink_cmp.get_lsp_capabilities(capabilities)
end

m.setup = function()
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

m.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
        vim.diagnostic.enable(false, { bufnr = bufnr })
    end

    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

return m
