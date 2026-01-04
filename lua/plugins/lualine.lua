-- lualine - https://github.com/hoob3rt/lualine.nvim

return {
    "hoob3rt/lualine.nvim",
    event = "VeryLazy",
    config = function()
        local function snacks_terminal()
            local buf = vim.api.nvim_get_current_buf()
            local term_id = vim.b[buf].snacks_terminal and vim.b[buf].snacks_terminal.id
            if term_id then
                return string.format("Terminal #%d", term_id)
            end
            return ""
        end

        local icons = require("core.icons")

        require("lualine").setup({
            options = {
                theme = "catppuccin",
                section_separators = "",
                component_separators = "",
                globalstatus = true,
                icons_enabled = true,
            },
            sections = {
                lualine_a = {
                    {
                        function()
                            return "▊"
                        end,
                        padding = { right = 1 },
                    },
                },
                lualine_b = {
                    {
                        snacks_terminal,
                        cond = function()
                            return vim.bo.filetype == "snacks_terminal"
                        end,
                    },
                    {
                        "filename",
                        cond = function()
                            return vim.bo.filetype ~= "snacks_terminal"
                        end,
                        file_status = true,
                        path = 1,
                        symbols = {
                            modified = " " .. icons.ui.Pencil,
                            readonly = " " .. icons.ui.Lock,
                            unnamed = "[No Name]",
                            directory = icons.kind.Folder,
                        },
                    },
                },
                lualine_c = {
                    {
                        "branch",
                        icon = icons.git.Branch,
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                    },
                    "filetype",
                },
                lualine_y = {
                    { "searchcount" },
                    { "progress" },
                },
                lualine_z = {
                    {
                        "location",
                        right_padding = 0,
                    },
                },
            },
        })
    end,
}
