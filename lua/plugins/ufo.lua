-- ufo -- https://github.com/kevinhwang91/nvim-ufo

return {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    config = function()
        local ufo = require("ufo")

        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (" 󰁂 %d "):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0

            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)

                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)

                    local hlGroup = chunk[2]

                    table.insert(newVirtText, { chunkText, hlGroup })

                    chunkWidth = vim.fn.strdisplaywidth(chunkText)

                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
        end

        ufo.setup({
            fold_virt_text_handler = handler,
            close_fold_kinds_for_ft = {
                -- default = { "comment", "imports" },
                -- default = { "comment" },
            },
            provider_selector = function(bufnr, filetype, buftype)
                return { "lsp", "indent" }
            end,
            preview = {
                win_config = {
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                },
            },
        })

        vim.keymap.set("n", "zR", require("ufo").openAllFolds, {
            desc = "Open all folds",
        })
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds, {
            desc = "Close all folds",
        })
        vim.keymap.set("n", "zP", require("ufo").peekFoldedLinesUnderCursor, {
            desc = "Peak into fold",
        })
    end,
}
