-- Custom trailing whitespace linter for nvim-lint

local MAX_LINES_FOR_LINT = 10000

return {
    cmd = "echo",
    stdin = false,
    append_fname = false,
    args = {},
    stream = "stdout",
    ignore_exitcode = true,
    parser = function(output, bufnr)
        -- Check if buffer should be linted
        local forbidden_buftypes = {
            ["acwrite"] = true,
            ["help"] = true,
            ["nofile"] = true,
            ["prompt"] = true,
            ["terminal"] = true,
        }

        local forbidden_filetypes = {
            ["lazy"] = true,
            ["lua"] = true, -- lua_ls already handles trailing whitespace
            ["mason"] = true,
            ["TelescopePrompt"] = true,
        }

        if forbidden_buftypes[vim.bo[bufnr].buftype]
            or forbidden_filetypes[vim.bo[bufnr].filetype]
            or vim.bo[bufnr].binary
            or vim.api.nvim_buf_line_count(bufnr) >= MAX_LINES_FOR_LINT
        then
            return {}
        end

        local diagnostics = {}
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        for lnum, line in ipairs(lines) do
            local trailing = line:match("%s+$")
            if trailing then
                local last_non_space = #line - #trailing
                table.insert(diagnostics, {
                    lnum = lnum - 1,
                    col = last_non_space,
                    end_lnum = lnum - 1,
                    end_col = #line,
                    severity = vim.diagnostic.severity.HINT,
                    message = "Trailing whitespace",
                    source = "trailing-whitespace",
                })
            end
        end

        return diagnostics
    end,
}
