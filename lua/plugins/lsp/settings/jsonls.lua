return {
    on_init = function(client)
        local root = client.root_dir
        if not root then
            return
        end

        client.settings = vim.tbl_deep_extend("force", client.settings, {
            json = {
                validate = { enable = true },
                schemas = {
                    {
                        description = "UCM SW package",
                        fileMatch = { "swpkg/**/manifest.json" },
                        url = "file://" .. root .. "/schemas/swpkg/manifest.schema.json",
                    },
                    {
                        description = "UCM SW cluster",
                        fileMatch = { "swcl/**/manifest.json" },
                        url = "file://" .. root .. "/schemas/swcl/manifest.schema.json",
                    },
                    {
                        description = "UCM config",
                        fileMatch = { "ucm.json" },
                        url = "file://" .. root .. "/schemas/ucm-daemon/ucm.schema.json",
                    },
                    {
                        description = "BootCtl config",
                        fileMatch = { "bootctl**.json" },
                        url = "file://" .. root .. "/schemas/bootctl-daemon/bootctl.schema.json",
                    },
                    {
                        description = "fs-reader config",
                        fileMatch = { "fs-reader.json" },
                        url = "file://" .. root .. "/schemas/fs-reader.schema.json",
                    },
                },
            },
        })

        client:notify("workspace/didChangeConfiguration", { settings = client.settings })
    end,
    settings = {
        json = {
            validate = { enable = true },
        },
    },
}
