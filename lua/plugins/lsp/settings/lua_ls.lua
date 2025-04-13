-- return {
--     settings = {
--         Lua = {
--             -- runtime = {
--             --     -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--             --     version = "LuaJIT",
--             -- },
--             -- diagnostics = {
--             --     -- Get the language server to recognize the `vim` global
--             --     globals = { "vim" },
--             -- },
--             -- hint = {
--             --     enable = true,
--             --     arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
--             --     await = true,
--             --     paramName = "Disable",  -- "All", "Literal", "Disable"
--             --     paramType = false,
--             --     semicolon = "Disable",  -- "All", "SameLine", "Disable"
--             --     setType = true,
--             -- },
--             -- workspace = {
--             --     -- Make the server aware of Neovim runtime files
--             --     library = vim.api.nvim_get_runtime_file("", true),
--             --     checkThirdParty = false,
--             -- },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }
return {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (
                    vim.uv.fs_stat(path .. "/.luarc.json")
                    or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                )
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            },
        })
    end,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            hint = {
                enable = true,
                arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                await = true,
                paramName = "Disable",  -- "All", "Literal", "Disable"
                paramType = false,
                semicolon = "Disable",  -- "All", "SameLine", "Disable"
                setType = true,
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
