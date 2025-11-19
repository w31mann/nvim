-- Custom indentation linter for nvim-lint

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
        local expandtab = vim.bo[bufnr].expandtab

        for lnum, line in ipairs(lines) do
            -- Check for mixed tabs and spaces on same line
            if line:match("^\t+ ") or line:match("^ +\t") then
                local indent = line:match("^%s*")
                table.insert(diagnostics, {
                    lnum = lnum - 1,
                    col = 0,
                    end_lnum = lnum - 1,
                    end_col = #indent,
                    severity = vim.diagnostic.severity.WARN,
                    message = "Mixed tabs and spaces in indentation",
                    source = "indentation",
                })
            -- Check for wrong indentation style (tabs when spaces expected)
            elseif expandtab and line:match("^\t") then
                local tabs = line:match("^\t+")
                table.insert(diagnostics, {
                    lnum = lnum - 1,
                    col = 0,
                    end_lnum = lnum - 1,
                    end_col = #tabs,
                    severity = vim.diagnostic.severity.HINT,
                    message = "Tabs used, but spaces expected (expandtab is on)",
                    source = "indentation",
                })
            -- Check for spaces when tabs expected
            elseif not expandtab and line:match("^  ") then
                local spaces = line:match("^ +")
                table.insert(diagnostics, {
                    lnum = lnum - 1,
                    col = 0,
                    end_lnum = lnum - 1,
                    end_col = #spaces,
                    severity = vim.diagnostic.severity.HINT,
                    message = "Spaces used, but tabs expected (expandtab is off)",
                    source = "indentation",
                })
            end
        end

        return diagnostics
    end,
}
