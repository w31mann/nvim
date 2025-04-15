local root_patterns = { ".git" }
local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

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
                        "file://" .. root_dir .. "/schemas/swpkg/manifest.schema.json",
                    },
                    {
                        name = "ucm_swcl",
                        description = "UCM SW cluster",
                        fileMatch = { "manifest.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/pkg-manifests/swcl",
                        url =
                        "file://" .. root_dir .. "/schemas/swcl/manifest.schema.json",
                    },
                    {
                        name = "ucm_cfg",
                        description = "UCM config",
                        fileMatch = { "ucm.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/examples/configs/ucm-daemon",
                        url =
                        "file://" .. root_dir .. "/schemas/ucm-daemon/ucm.schema.json",
                    },
                    {
                        name = "fd-reader_cfg",
                        description = "fs-reader config",
                        fileMatch = { "fs-reader.json" },
                        -- folderUri =
                        -- "/home/user/src/mwd_internal/over-the-air/ucm/update-verification/fs-reader/examples/configs",
                        url =
                        "file://" .. root_dir .. "/schemas/fs-reader.schema.json",
                    },
                },
            }),
        },
    },
}
