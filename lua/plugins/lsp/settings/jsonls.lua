return {
    settings = {
        json = {
            validate = { enable = true },
            schemas = require("schemastore").json.schemas({
                extra = {
                    {
                        name = "ucm_swpkg",
                        description = "UCM SW package",
                        fileMatch = { "manifest.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swpkg",
                        url =
                        "file:///home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swpkg/manifest.schema.json",
                    },
                    {
                        name = "ucm_swcl",
                        description = "UCM SW cluster",
                        fileMatch = { "manifest.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swcl",
                        url =
                        "file:///home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swcl/manifest.schema.json",
                    },
                    {
                        name = "ucm_cfg",
                        description = "UCM config",
                        fileMatch = { "ucm.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/ucm-daemon",
                        url =
                        "file:///home/user/src/mwd_internal/over-the-air/ucm/examples/configs/ucm-daemon/ucm.schema.json",
                    },
                    {
                        name = "fd-reader_cfg",
                        description = "fs-reader config",
                        fileMatch = { "fs-reader.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/update-verification/fs-reader/examples/configs",
                        url =
                        "file:///home/user/src/mwd_internal/over-the-air/ucm/update-verification/fs-reader/examples/configs/fs-reader.schema.json",
                    },
                },
            }),
        },
    },
}
