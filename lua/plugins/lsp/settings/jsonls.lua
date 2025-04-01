return {
    settings = {
        json = {
            validate = { enable = true },
            schemas = {
                {
                    description = "aptiv-network-manager on Mac",
                    fileMatch = { "config.json" },
                    folderUri = "/Users/philip/src/aptiv-network-manager/sets.d",
                    url = "file:///Users/philip/src/aptiv-network-manager/sets.d/schema.json",
                },
                {
                    description = "aptiv-network-manager for Work",
                    fileMatch = { "config.json" },
                    folderUri =
                    "/home/user/src/mwd_internal/over-the-air/aptiv-network-manager/sets.d",
                    url =
                    "file:///home/user/src/mwd_internal/over-the-air/aptiv-network-manager/sets.d/schema.json",
                },
                {
                    description = "UCM SW package",
                    fileMatch = { "manifest.json" },
                    folderUri =
                    "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swpkg",
                    url =
                    "file:///home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swpkg/manifest.schema.json",
                },
                {
                    description = "UCM SW cluster",
                    fileMatch = { "manifest.json" },
                    folderUri =
                    "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swcl",
                    url =
                    "file:///home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swcl/manifest.schema.json",
                },
                {
                    description = "UCM config",
                    fileMatch = { "ucm.json" },
                    folderUri =
                    "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/ucm-daemon",
                    url =
                    "file:///home/user/src/mwd_internal/over-the-air/ucm/examples/configs/ucm-daemon/ucm.schema.json",
                },
                {
                    description = "fs-reader config",
                    fileMatch = { "fs-reader.json" },
                    folderUri =
                    "/home/user/src/mwd_internal/over-the-air/ucm/update-verification/fs-reader/examples/configs",
                    url =
                    "file:///home/user/src/mwd_internal/over-the-air/ucm/update-verification/fs-reader/examples/configs/fs-reader.schema.json",
                },
            },
        },
    },
}
