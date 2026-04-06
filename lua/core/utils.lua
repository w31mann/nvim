local utils = {}

function utils.toggleIndentation()
    vim.o.expandtab = not vim.o.expandtab
    if vim.o.expandtab then
        vim.notify("Using SPACES for indentation", vim.log.levels.INFO)
    else
        vim.notify("Using TABS for indentation", vim.log.levels.INFO)
    end
end

function utils.toggleQuickfixWindow()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win["quickfix"] == 1 then
            vim.cmd("botright cclose")
            return
        end
    end
    vim.cmd("botright copen")
end

function utils.toggleSpellChecking()
    vim.wo.spell = not vim.wo.spell
    if vim.wo.spell then
        vim.notify("Spelling enabled", vim.log.levels.INFO)
    else
        vim.notify("Spelling disabled", vim.log.levels.INFO)
    end
end

function utils.toggleLineNumbers()
    if vim.o.number and vim.o.relativenumber then
        vim.o.relativenumber = false
    elseif vim.o.number and not vim.o.relativenumber then
        vim.o.number = false
    else
        vim.o.number = true
        vim.o.relativenumber = true
    end

    vim.notify(
        string.format("Line Numbers: %s\nRelative Numbers: %s", vim.o.number, vim.o.relativenumber),
        vim.log.levels.INFO
    )
end

function utils.toggleDiagnostics(global)
    local bufnr = global and nil or 0
    local enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })

    vim.diagnostic.enable(not enabled, { bufnr = bufnr })

    if enabled then
        vim.notify("Diagnostics disabled", vim.log.levels.INFO)
    else
        vim.notify("Diagnostics enabled", vim.log.levels.INFO)
    end
end

function utils.toggleInlayHints()
    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    vim.notify(enabled and "Inlay hints disabled" or "Inlay hints enabled", vim.log.levels.INFO)
end

function utils.toggleCodeLens()
    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.codelens.is_enabled({ bufnr = bufnr })
    vim.lsp.codelens.enable(not enabled, { bufnr = bufnr })
    vim.notify(enabled and "Code lens disabled" or "Code lens enabled", vim.log.levels.INFO)
end

function utils.setup_clipboard()
    local clipboard_tools = { "wl-copy", "pbcopy", "win32yank.exe" }
    local has_clipboard_tool = false

    local is_root = vim.uv.getuid() == 0

    for _, tool in ipairs(clipboard_tools) do
        if vim.fn.executable(tool) == 1 then
            has_clipboard_tool = true
            break
        end
    end

    if not has_clipboard_tool or is_root then
        vim.g.clipboard = {
            name = "OSC 52",
            copy = {
                ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
                ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
            },
            paste = {
                ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
                ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
            },
        }
    end

    vim.o.clipboard = "unnamedplus"
end

return utils
