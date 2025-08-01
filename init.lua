vim.loader.enable()

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.utils")

-- lazy plugin manager - https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_ok, lazy = pcall(require, "lazy")
if lazy_ok then
    lazy.setup({
        { import = "plugins" },
        { import = "plugins.colorschemes" },
    }, {
        -- check for plugin updates and notify
        checker = {
            enabled = false,
            notify = true,
        },
        -- check for config updates to update the UI but do not notify
        change_detection = {
            notify = false,
        },
        ui = {
            border = "single",
        },
        rocks = {
            enabled = false,
        },
    })
else
    vim.notify("Lazy failed to setup plugins", vim.log.levels.ERROR)
end
