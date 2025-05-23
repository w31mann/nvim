local utils = {}

function utils.toggleIndentation()
    local title = "Toggle Indentation"

    if vim.o.expandtab then
        vim.opt.expandtab = false
        vim.notify("Using TABS for indentation", vim.log.levels.INFO, { title = title })
    else
        vim.opt.expandtab = true
        vim.notify("Using SPACES for indentation", vim.log.levels.INFO, { title = title })
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
    vim.opt_local.spell = not (vim.opt_local.spell:get())
    if vim.opt_local.spell:get() then
        vim.notify("Spelling enabled", vim.log.levels.INFO)
    else
        vim.notify("Spelling disabled", vim.log.levels.INFO)
    end
end

function utils.toggleLineNumbers()
    if vim.o.number and vim.o.relativenumber then
        vim.opt.relativenumber = false
    elseif vim.o.number and not vim.o.relativenumber then
        vim.opt.number = false
    else
        vim.opt.number = true
        vim.opt.relativenumber = true
    end

    vim.notify(
        string.format("Line Numbers: %s\nRelative Numbers: %s", vim.o.number, vim.o.relativenumber),
        vim.log.levels.INFO,
        { title = "Toggle Line Numbers" }
    )
end

function utils.toggleDiagnostics(global)
    local vars, bufnr, cmd

    if global then
        vars = vim.g
        bufnr = nil
    else
        vars = vim.b
        bufnr = 0
    end

    vars.diagnostics_disabled = not vars.diagnostics_disabled
    if vars.diagnostics_disabled then
        cmd = "disable"
        vim.notify("Diagnostics disabled", vim.log.levels.INFO)
    else
        cmd = "enable"
        vim.notify("Diagnostics enabled", vim.log.levels.INFO)
    end

    vim.diagnostic[cmd](bufnr)
end

function utils.toggleInlayHints()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        vim.notify("Inlay hints disabled", vim.log.levels.INFO)
    else
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        vim.notify("Inlay hints enabled", vim.log.levels.INFO)
    end
end

function utils.project_root(root_patterns)
    root_patterns = root_patterns or { ".git" }

    local current_buf_path = vim.api.nvim_buf_get_name(0)
    if current_buf_path == "" then
        return nil
    end

    local current_dir = vim.fs.dirname(current_buf_path)
    local root_file = vim.fs.find(root_patterns, { upward = true, path = current_dir })[1]

    if root_file then
        return vim.fs.dirname(root_file)
    else
        return nil
    end
end

function utils.color_palette()
    local palette

    local catppuccin_ok, catppuccin = pcall(require, "catppucin.palettes")
    local tokyonight_ok, tokyonight = pcall(require, "tokyonight.colors")

    if catppuccin_ok then
        palette = catppuccin().get_palette()
    elseif tokyonight_ok then
        palette = tokyonight.setup()
    end

    return palette
end

return utils
