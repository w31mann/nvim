local icons = require("core.icons")

local severity_config = {
    { severity = vim.diagnostic.severity.ERROR, icon = icons.diagnostics.Error, hl = "DiagnosticError" },
    { severity = vim.diagnostic.severity.WARN, icon = icons.diagnostics.Warning, hl = "DiagnosticWarn" },
    { severity = vim.diagnostic.severity.INFO, icon = icons.diagnostics.Information, hl = "DiagnosticInfo" },
    { severity = vim.diagnostic.severity.HINT, icon = icons.diagnostics.Hint, hl = "DiagnosticHint" },
}

local function diagnostic_status()
    local counts = vim.diagnostic.count(0)
    local parts = {}

    for _, cfg in ipairs(severity_config) do
        local count = counts[cfg.severity] or 0
        if count > 0 then
            table.insert(parts, "%#" .. cfg.hl .. "#" .. cfg.icon .. " " .. count)
        end
    end

    if #parts == 0 then
        return ""
    end

    return table.concat(parts, " ") .. "%*"
end

local function lsp_status()
    local status = vim.lsp.status()
    if status ~= "" then
        return status
    end
    return ""
end

local function git_branch()
    return vim.b.gitsigns_head or ""
end

local function filename()
    local id = vim.b.terminal_id
    if id then
        return "terminal " .. id
    end
    return "%f"
end

function Statusline()
    local parts = {
        " " .. filename(),
        "%m%r",
        "  ",
        git_branch(),
        "%=",
        diagnostic_status(),
        "  ",
        lsp_status(),
        "  ",
        "%y",
        "  %l:%c  %p%% ",
    }
    return table.concat(parts)
end

vim.o.statusline = "%!v:lua.Statusline()"

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "LspAttach", "LspDetach", "LspProgress" }, {
    group = vim.api.nvim_create_augroup("statusline_redraw", { clear = true }),
    command = "redrawstatus",
})
