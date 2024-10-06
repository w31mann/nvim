-- nvim-ts-context-commentstring - https://github.com/JoosepAlviste/nvim-ts-context-commentstring

return {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
        require("ts_context_commentstring").setup {
            enable_autocmd = false,
            languages = {
                html = "<!-- %s -->",
                systemd = "# %s",
                hog = "# %s",
                wit = "/// %s",
                c = "// %s",
                cpp = "// %s",
                rust = "// %s",
            },
        }

        -- setup neovim native comment function
        local get_option = vim.filetype.get_option

        ---@diagnostic disable: duplicate-set-field
        vim.filetype.get_option = function(filetype, option)
            return option == "commentstring"
                and require("ts_context_commentstring.internal").calculate_commentstring()
                or get_option(filetype, option)
        end
    end,
}
