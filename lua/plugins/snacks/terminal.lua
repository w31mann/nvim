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

-- Filetypes to exclude from toggle all terminals
local toggle_exception_filetypes = {
    "opencode_terminal",
}

-- Track which terminals were last visible for sticky toggle behavior
local last_visible_terminals = {}

-- Filter terminals by excluding exception filetypes
local function filter_user_terminals(terminals)
    local user_terminals = {}
    for _, term in ipairs(terminals) do
        if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = term.buf })
            local is_exception = false
            for _, exception_ft in ipairs(toggle_exception_filetypes) do
                if filetype == exception_ft then
                    is_exception = true
                    break
                end
            end
            if not is_exception then
                table.insert(user_terminals, term)
            end
        end
    end
    return user_terminals
end

-- Get list of currently visible terminal buffer IDs
local function get_visible_terminal_buffers(terminals)
    local visible = {}
    for _, term in ipairs(terminals) do
        if term.win and vim.api.nvim_win_is_valid(term.win) then
            table.insert(visible, term.buf)
        end
    end
    return visible
end

-- Check if any terminals are currently visible
local function has_visible_terminals(terminals)
    for _, term in ipairs(terminals) do
        if term.win and vim.api.nvim_win_is_valid(term.win) then
            return true
        end
    end
    return false
end

-- Clean up last visible list by removing invalid buffer IDs
local function clean_last_visible_list()
    local valid_buffers = {}
    for _, buf_id in ipairs(last_visible_terminals) do
        if vim.api.nvim_buf_is_valid(buf_id) then
            table.insert(valid_buffers, buf_id)
        end
    end
    last_visible_terminals = valid_buffers
end

-- Hide all visible terminals and remember which were visible
local function hide_visible_terminals(terminals)
    local visible_buffers = get_visible_terminal_buffers(terminals)
    last_visible_terminals = visible_buffers

    for _, term in ipairs(terminals) do
        if term.win and vim.api.nvim_win_is_valid(term.win) then
            term:hide()
        end
    end
end

-- Show terminals based on last visible state
local function show_remembered_terminals(terminals)
    clean_last_visible_list()

    -- If no memory or all remembered terminals deleted, show all
    if #last_visible_terminals == 0 then
        for _, term in ipairs(terminals) do
            term:show()
        end
        return
    end

    -- Show only previously visible terminals
    for _, term in ipairs(terminals) do
        for _, buf_id in ipairs(last_visible_terminals) do
            if term.buf == buf_id then
                term:show()
                break
            end
        end
    end
end

-- Toggle all terminals with sticky visibility behavior
local function toggle_all_terminals()
    local terminals = Snacks.terminal.list()

    -- If no terminals exist, create one
    if #terminals == 0 then
        Snacks.terminal.toggle()
        return
    end

    local user_terminals = filter_user_terminals(terminals)

    -- If no user terminals exist, create one
    if #user_terminals == 0 then
        Snacks.terminal.toggle()
        return
    end

    -- Toggle based on visibility state
    if has_visible_terminals(user_terminals) then
        hide_visible_terminals(user_terminals)
    else
        show_remembered_terminals(user_terminals)
    end
end

-- Helper for smart terminal toggle (count-aware)
local function smart_terminal_toggle()
    local count = vim.v.count
    if count > 0 then
        Snacks.terminal.toggle(nil, { count = count })
    else
        toggle_all_terminals()
    end
end

-- Setup keybindings and autocmds
function M.setup()
    -- Global keybindings
    -- Mac
    vim.keymap.set("n", "†", smart_terminal_toggle, {
        desc = "Toggle all terminals (or specific with count)",
    })
    vim.keymap.set("t", "µ", "<c-\\><c-n>", { desc = "Terminal normal mode" })
    vim.keymap.set("t", "†", toggle_all_terminals, { desc = "Toggle all terminals" })

    -- Linux
    vim.keymap.set("n", "<m-t>", smart_terminal_toggle, {
        desc = "Toggle all terminals (or specific with count)",
    })
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
