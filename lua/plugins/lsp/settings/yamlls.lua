local repo_root = require("core.utils").project_root()

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
            schemas = {
                [repo_root .. "/configs/schemas/profiles.json"] = repo_root .. "/configs/profiles.yaml",
            },
        },
    },
}
