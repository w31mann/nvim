local config_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h")
local nvim_lint = require("lint")

nvim_lint.linters["trailing-whitespace"] = require("plugins.linters.trailing-whitespace")
nvim_lint.linters["indentation"] = require("plugins.linters.indentation")

nvim_lint.linters_by_ft = {
    markdown = { "markdownlint-cli2" },
    gitcommit = { "gitlint" },
    ["*"] = { "trailing-whitespace", "indentation" },
}

local markdownlint = nvim_lint.linters["markdownlint-cli2"]
markdownlint.args = {
    "--config",
    config_root .. "/configs/linters/.markdownlint.json",
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

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
    callback = function()
        nvim_lint.try_lint()
        nvim_lint.try_lint("trailing-whitespace")
        nvim_lint.try_lint("indentation")
    end,
})
