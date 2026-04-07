local config_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")
vim.opt.rtp:prepend(config_root)

require("core.pack")

require("plugins.catppuccin")

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.usercmds")
require("core.statusline")
require("core.terminal")

require("plugins.treesitter")
require("plugins.treesitter-context")
require("plugins.gitsigns")
require("plugins.mason")
require("plugins.lspconfig")
require("plugins.conform")
require("plugins.nvim-lint")
require("plugins.blink-cmp")
require("plugins.fzf-lua")
