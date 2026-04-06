return {
    on_init = function(client)
        local root = client.root_dir
        if not root then
            return
        end

        client.settings = vim.tbl_deep_extend("force", client.settings, {
            yaml = {
                schemas = {
                    [root .. "/configs/schemas/profiles.json"] = root .. "/configs/profiles.yaml",
                },
            },
        })

        client:notify("workspace/didChangeConfiguration", { settings = client.settings })
    end,
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
        },
    },
}
