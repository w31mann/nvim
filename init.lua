local config_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")
vim.opt.rtp:prepend(config_root)

-- Build hooks must be registered before vim.pack.add()
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

local gh = function(x)
    return "https://github.com/" .. x
end

vim.pack.add({
    { src = gh("catppuccin/nvim"), name = "catppuccin" },
    gh("neovim/nvim-lspconfig"),
    gh("williamboman/mason.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
    gh("lewis6991/gitsigns.nvim"),
    gh("stevearc/conform.nvim"),
    gh("mfussenegger/nvim-lint"),
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1") },
    gh("rafamadriz/friendly-snippets"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("nvim-treesitter/nvim-treesitter-context"),
    gh("ibhagwan/fzf-lua"),
})

-- Colorscheme must be configured before loading (setup before colorscheme)
require("plugins.catppuccin")

require("core.options")
require("core.keymaps")
require("core.autocmds")
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
