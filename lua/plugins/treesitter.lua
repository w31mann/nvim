-- treesitter - https://github.com/nvim-treesitter/nvim-treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- treesitter-context - https://github.com/nvim-treesitter/nvim-treesitter-context
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        ---@diagnostic disable: missing-fields
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "awk",
                "bash",
                "bitbake",
                "c",
                "cmake",
                "comment",
                "cpp",
                "devicetree",
                "diff",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "haskell",
                "html",
                "ini",
                "json",
                "jq",
                "kdl",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "objdump",
                "passwd",
                "python",
                "query",
                "regex",
                "rst",
                "rust",
                "ssh_config",
                "toml",
                "vim",
                "vimdoc",
                "wit",
                "xml",
                "yaml",
            },
            ignore_install = {},
            auto_install = false,
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        })
    end,
}
