-- snacks.terminal - https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md

local M = {}

-- Terminal config for snacks.setup()
M.config = {
    enabled = true,
    win = {
        style = "terminal",
        wo = {
            winbar = "",
        },
    },
}

-- Toggle all terminals: hide if any visible, show all if none visible
local function toggle_all_terminals()
    local terminals = Snacks.terminal.list()
    if #terminals == 0 then
        return
    end

    local any_visible = false
    for _, term in ipairs(terminals) do
        if term.win and vim.api.nvim_win_is_valid(term.win) then
            any_visible = true
            break
        end
    end

    for _, term in ipairs(terminals) do
        if any_visible then
            term:hide()
        else
            term:show()
        end
    end
end

-- Helper for smart terminal toggle (count-aware)
local function smart_terminal_toggle()
    if vim.v.count > 0 then
        Snacks.terminal.toggle(nil, { count = vim.v.count })
    else
        toggle_all_terminals()
    end
end

-- Setup keybindings and autocmds
function M.setup()
    -- Global keybindings
    -- Mac
    vim.keymap.set("n", "†", function()
        Snacks.terminal.toggle()
    end, { desc = "Toggle terminal" })
    vim.keymap.set("t", "µ", "<c-\\><c-n>", { desc = "Terminal normal mode" })
    vim.keymap.set("t", "†", toggle_all_terminals, { desc = "Toggle all terminals" })

    -- Linux
    vim.keymap.set("n", "<m-t>", function()
        Snacks.terminal.toggle()
    end, { desc = "Toggle terminal" })
    vim.keymap.set("t", "<m-m>", "<c-\\><c-n>", { desc = "Terminal normal mode" })
    vim.keymap.set("t", "<m-t>", toggle_all_terminals, { desc = "Toggle all terminals" })

    -- Buffer-local keybindings for terminal buffers
    -- When in a terminal: no count = toggle all, with count = toggle specific
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "snacks_terminal",
        callback = function(event)
            vim.keymap.set("n", "†", smart_terminal_toggle, {
                buffer = event.buf,
                desc = "Toggle all terminals (or specific with count)",
            })
            vim.keymap.set("n", "<m-t>", smart_terminal_toggle, {
                buffer = event.buf,
                desc = "Toggle all terminals (or specific with count)",
            })
        end,
    })

    -- Auto-close terminal buffers when quitting to allow Neovim to exit
    vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
            local terminals = Snacks.terminal.list()
            for _, term in ipairs(terminals) do
                if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
                    vim.api.nvim_buf_delete(term.buf, { force = true })
                end
            end
        end,
    })
end

return M
