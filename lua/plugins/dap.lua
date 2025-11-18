-- nvim-dap - https://github.com/mfussenegger/nvim-dap

local function setup_listeners()
    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
end

local function setup_signs()
    vim.fn.sign_define(
        "DapBreakpoint",
        { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
        "DapLogPoint",
        { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" }
    )
end

local function setup_adapters()
    local dap = require("dap")

    dap.adapters.lldb = {
        type = "executable",
        command = "codelldb",
    }
end

local function setup_keymaps()
    local dap = require("dap")

    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debug session" })
    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run To Cursor" })
    vim.keymap.set("n", "<leader>ds", function()
        dap.continue({ new = true })
    end, { desc = "Start debug session" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Step Back" })
    vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dL", function()
        dap.list_breakpoints()
        require("core.utils").toggleQuickfixWindow()
    end, { desc = "List breakpoints" })
    vim.keymap.set("n", "<leader>dB", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
    vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
    vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart the debug session" })
    vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate the debug session" })
end

return {
    "mfussenegger/nvim-dap",
    keys = {
        { "<leader>dt", mode = "n", desc = "Toggle Breakpoint" },
        { "<leader>dc", mode = "n", desc = "Continue debug session" },
        { "<leader>dC", mode = "n", desc = "Run To Cursor" },
        { "<leader>ds", mode = "n", desc = "Start debug session" },
        { "<leader>di", mode = "n", desc = "Step Into" },
        { "<leader>do", mode = "n", desc = "Step Over" },
        { "<leader>db", mode = "n", desc = "Step Back" },
        { "<leader>du", mode = "n", desc = "Step Out" },
        { "<leader>dL", mode = "n", desc = "List breakpoints" },
        { "<leader>dB", mode = "n", desc = "Clear all breakpoints" },
        { "<leader>dp", mode = "n", desc = "Pause" },
        { "<leader>dr", mode = "n", desc = "Restart the debug session" },
        { "<leader>dq", mode = "n", desc = "Terminate the debug session" },
    },
    dependencies = {
        {
            -- nvim-dap-ui - https://github.com/rcarriga/nvim-dap-ui
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "nvim-neotest/nvim-nio",
            },
        },
        -- nvim-dae-virtual-text - https://github.com/theHamsta/nvim-dap-virtual-text
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dapui = require("dapui")

        ---@diagnostic disable-next-line: missing-parameter
        require("nvim-dap-virtual-text").setup()
        dapui.setup()

        setup_listeners()
        setup_signs()
        setup_adapters()
        setup_keymaps()
    end,
}
