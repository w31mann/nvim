return {
    settings = {
        yaml = {
            format = {
                enable = true,
            },
            editor = {
                tabSize = 4,
            },
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    },
}
