-- snacks.scope - https://github.com/folke/snacks.nvim/blob/main/docs/scope.md

local M = {}

M.config = {
    enabled = true,
    cursor = false,
    edge = true,
    treesitter = {
        blocks = {
            enabled = true,
        },
    },
}

return M
