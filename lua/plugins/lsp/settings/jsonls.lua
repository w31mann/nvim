local repo_root = require("core.utils").project_root()

return {
    settings = {
        json = {
            validate = { enable = true },
            schemas = {
                {
                    description = "UCM SW package",
                    fileMatch = { "swpkg/**/manifest.json" },
                    url = "file://" .. repo_root .. "/schemas/swpkg/manifest.schema.json",
                },
                {
                    description = "UCM SW cluster",
                    fileMatch = { "swcl/**/manifest.json" },
                    url = "file://" .. repo_root .. "/schemas/swcl/manifest.schema.json",
                },
                {
                    description = "UCM config",
                    fileMatch = { "ucm.json" },
                    url = "file://" .. repo_root .. "/schemas/ucm-daemon/ucm.schema.json",
                },
                {
                    description = "fs-reader config",
                    fileMatch = { "fs-reader.json" },
                    url = "file://" .. repo_root .. "/schemas/fs-reader.schema.json",
                },
            },
        },
    },
}
