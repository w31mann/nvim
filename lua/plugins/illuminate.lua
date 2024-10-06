-- illuminate - https://github.com/RRethy/vim-illuminate

return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        require("illuminate").configure({
            delay = 300,
            large_file_cutoff = 5000,
            min_count_to_highlight = 2,
        })
    end,
}
