local M = {}

local terminals = {}
local last_visible = {}

local function get_or_create_terminal(id)
    if terminals[id] and vim.api.nvim_buf_is_valid(terminals[id].buf) then
        return terminals[id]
    end

    local buf = vim.api.nvim_create_buf(false, true)
    terminals[id] = { buf = buf, win = nil, id = id }
    return terminals[id]
end

local function open_terminal_window(term)
    if term.win and vim.api.nvim_win_is_valid(term.win) then
        vim.api.nvim_set_current_win(term.win)
        return
    end

    vim.cmd("botright split")
    vim.api.nvim_win_set_height(0, 20)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, term.buf)
    term.win = win

    -- Start terminal if buffer is empty
    if vim.bo[term.buf].buftype ~= "terminal" then
        vim.cmd("terminal")
        term.buf = vim.api.nvim_get_current_buf()
        terminals[term.id].buf = term.buf
        vim.b[term.buf].terminal_id = term.id
    end

    vim.cmd("startinsert")
end

local function hide_terminal(term)
    if term.win and vim.api.nvim_win_is_valid(term.win) then
        vim.api.nvim_win_close(term.win, true)
        term.win = nil
    end
end

local function is_visible(term)
    return term.win and vim.api.nvim_win_is_valid(term.win)
end

local function get_visible_ids()
    local ids = {}
    for id, term in pairs(terminals) do
        if is_visible(term) then
            table.insert(ids, id)
        end
    end
    return ids
end

local function has_any_visible()
    for _, term in pairs(terminals) do
        if is_visible(term) then
            return true
        end
    end
    return false
end

function M.toggle_all()
    -- No terminals exist: create one
    if vim.tbl_isempty(terminals) then
        local term = get_or_create_terminal(1)
        open_terminal_window(term)
        return
    end

    if has_any_visible() then
        last_visible = get_visible_ids()
        for _, term in pairs(terminals) do
            hide_terminal(term)
        end
    else
        -- Restore previously visible, or show all
        local to_show = #last_visible > 0 and last_visible or vim.tbl_keys(terminals)
        for _, id in ipairs(to_show) do
            local term = terminals[id]
            if term and vim.api.nvim_buf_is_valid(term.buf) then
                open_terminal_window(term)
            end
        end
    end
end

function M.hide_current()
    local buf = vim.api.nvim_get_current_buf()
    for _, term in pairs(terminals) do
        if term.buf == buf then
            hide_terminal(term)
            return
        end
    end
end

function M.smart_toggle()
    local count = vim.v.count
    if count > 0 then
        local term = get_or_create_terminal(count)
        if is_visible(term) then
            hide_terminal(term)
        else
            open_terminal_window(term)
        end
    elseif vim.bo.buftype == "terminal" then
        M.hide_current()
    else
        M.toggle_all()
    end
end

-- Keybindings
-- Mac
vim.keymap.set("n", "†", M.smart_toggle, { desc = "Toggle terminals (count-aware)" })
vim.keymap.set("t", "†", M.hide_current, { desc = "Hide current terminal" })
vim.keymap.set("t", "µ", "<c-\\><c-n>", { desc = "Terminal normal mode" })
-- Linux
vim.keymap.set("n", "<m-t>", M.smart_toggle, { desc = "Toggle terminals (count-aware)" })
vim.keymap.set("t", "<m-t>", M.hide_current, { desc = "Hide current terminal" })
vim.keymap.set("t", "<m-m>", "<c-\\><c-n>", { desc = "Terminal normal mode" })

-- Clean up terminals on quit so nvim can exit
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        for _, term in pairs(terminals) do
            if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
                vim.api.nvim_buf_delete(term.buf, { force = true })
            end
        end
    end,
})

return M
