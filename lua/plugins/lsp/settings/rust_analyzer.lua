return {
    settings = {
        ["rust-analyzer"] = {
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
