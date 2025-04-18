local repo_root = require("core.utils").project_root()

return {
    settings = {
        json = {
            validate = { enable = true },
            schemas = {
                extra = {
                    {
                        description = "UCM SW package",
                        fileMatch = { "swpkg/manifest.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swpkg",
                        url = "file://" .. repo_root .. "/schemas/swpkg/manifest.schema.json",
                    },
                    {
                        description = "UCM SW cluster",
                        fileMatch = { "swcl/manifest.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swcl",
                        url = "file://" .. repo_root .. "/schemas/swcl/manifest.schema.json",
                    },
                    {
                        description = "UCM config",
                        fileMatch = { "ucm.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/ucm-daemon",
                        url = "file://" .. repo_root .. "/schemas/ucm-daemon/ucm.schema.json",
                    },
                    {
                        description = "fs-reader config",
                        fileMatch = { "fs-reader.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/update-verification/fs-reader/examples/configs",
                        url = "file://" .. repo_root .. "/schemas/fs-reader.schema.json",
                    },
                },
            },
        },
    },
}
