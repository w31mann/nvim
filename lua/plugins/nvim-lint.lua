-- nvim-lint - https://github.com/mfussenegger/nvim-lint

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "markdown", "gitcommit" },
    config = function()
        local nvim_lint = require("lint")

        -- Register custom linters
        nvim_lint.linters["trailing-whitespace"] = require("plugins.linters.trailing-whitespace")
        nvim_lint.linters["indentation"] = require("plugins.linters.indentation")

        -- Configure linters by filetype
        nvim_lint.linters_by_ft = {
            -- External linters
            markdown = { "markdownlint-cli2" },
            gitcommit = { "gitlint" },
            -- Custom linters for all filetypes (will be filtered by should_lint)
            ["*"] = { "trailing-whitespace", "indentation" },
        }

        local markdownlint = nvim_lint.linters["markdownlint-cli2"]
        markdownlint.args = {
            "--config",
            vim.fn.stdpath("config") .. "/configs/linters/.markdownlint.json",
        }

        local gitlint = nvim_lint.linters.gitlint
        gitlint.args = {
            "--contrib=contrib-title-conventional-commits",
            "--staged",
            "--msg-filename",
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
        }

        local nvim_lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

        -- More aggressive autocmd for custom buffer-based linters
        vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
            group = nvim_lint_augroup,
            callback = function()
                nvim_lint.try_lint()
                nvim_lint.try_lint("trailing-whitespace")
                nvim_lint.try_lint("indentation")
            end,
        })
    end,
}
