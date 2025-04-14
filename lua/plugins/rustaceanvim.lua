-- rustaceanvim - https://github.com/mrcjkb/rustaceanvim

return {
    "mrcjkb/rustaceanvim",
    enabled = true,
    -- version = "^5",
    ft = { "rust" },
    config = function()
        vim.g.rustaceanvim = {
            -- LSP configuration
            server = {
                -- https://rust-analyzer.github.io/book/configuration.html
                default_settings = {
                    cargo = {
                        features = "all",
                    },
                    completion = {
                        autoimport = {
                            enable = false,
                        },
                        fullFunctionSignatures = {
                            enable = true,
                        },
                    },
                    diagnostics = {
                        experimental = {
                            enable = true,
                        },
                    },
                    hover = {
                        actions = {
                            references = {
                                enable = true,
                            },
                        },
                    },
                    check = {
                        command = "clippy",
                    },
                    lens = {
                        references = {
                            adt = {
                                enable = true,
                            },
                            enumVariant = {
                                enable = true,
                            },
                            method = {
                                enable = true,
                            },
                            trait = {
                                enable = true,
                            },
                        },
                    },
                    rustfmt = {
                        rangeFormatting = {
                            enable = true,
                        },
                    },
                },
            },
        }
    end,
}
