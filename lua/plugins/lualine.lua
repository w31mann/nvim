-- lualine - https://github.com/hoob3rt/lualine.nvim

return {
    "hoob3rt/lualine.nvim",
    event = "VeryLazy",
    config = function()
        local palette = require("core.utils").color_palette()

        local colors = {
            error = palette.red,
            warn = palette.yellow,
            info = palette.green,
            white = palette.text,
            purple = palette.mauve,
            bg0 = palette.mantle,
            bg1 = palette.surface0,
            accent = palette.maroon,
        }

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
                theme = "auto",
                section_separators = "",
                component_separators = "",
                globalstatus = true,
                icons_enabled = true,
            },
            extensions = {},
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
                        file_status = true,
                        path = 1,
                        color = { fg = colors.white },
                        symbols = {
                            modified = " " .. icons.ui.Pencil, -- Text to show when the file is modified.
                            readonly = " " .. icons.ui.Lock,   -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]",             -- Text to show for unnamed buffers.
                            directory = icons.kind.Folder,     -- Text to show when the buffer is a directory
                        },
                    },
                },
                lualine_c = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.purple },
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
                    {
                        "searchcount",
                    },
                    {
                        "progress",
                        color = { fg = colors.white, bg = colors.bg0 },
                    },
                },
                lualine_z = {
                    {
                        "location",
                        right_padding = 0,
                        color = { fg = colors.white, bg = colors.bg0 },
                    },
                },
            },

            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        "filename",
                        file_status = true,
                    },
                },
                lualine_c = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.purple },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
