return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
        {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = {
                    "nvim-neotest/nvim-nio",
                },
            },
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
        },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        require("nvim-dap-virtual-text").setup()

        dapui.setup()

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

        local sign = vim.fn.sign_define

        sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        sign("DapBreakpointCondition",
            { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
        sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

        vim.keymap.set(
            "n",
            "<leader>dt",
            require("dap").toggle_breakpoint,
            { desc = "Toggle Breakpoint" }
        )
        vim.keymap.set("n", "<leader>dc", require("dap").continue,
            { desc = "Continue debug session" })
        vim.keymap.set("n", "<leader>dC", require("dap").run_to_cursor, { desc = "Run To Cursor" })
        vim.keymap.set("n", "<leader>ds", function() require("dap").continue({ new = true }) end,
            { desc = "Start debug session" })
        vim.keymap.set("n", "<leader>di", require("dap").step_into, { desc = "Step Into" })
        vim.keymap.set("n", "<leader>do", require("dap").step_over, { desc = "Step Over" })
        vim.keymap.set("n", "<leader>db", require("dap").step_back, { desc = "Step Back" })
        vim.keymap.set("n", "<leader>du", require("dap").step_out, { desc = "Step Out" })
        vim.keymap.set("n", "<leader>dL",
            function()
                require("dap").list_breakpoints()
                require("core.utils").toggleQuickfixWindow()
            end,
            { desc = "List breakpoints" })
        vim.keymap.set("n", "<leader>dB", require("dap").clear_breakpoints,
            { desc = "Clear all breakpoints" })
        -- vim.keymap.set("n", "<leader>dd", require("dap").disconnect, { desc = "Disconnect" })
        -- vim.keymap.set("n", "<leader>dg", require("dap").session, { desc = "Get Session" })
        vim.keymap.set("n", "<leader>dp", require("dap").pause, { desc = "Pause" })
        -- vim.keymap.set("n", "<leader>dr", require("dap").repl.toggle, { desc = "Toggle Repl" })
        vim.keymap.set("n", "<leader>dr", require("dap").restart,
            { desc = "Restart the debug session" })
        -- vim.keymap.set("n", "<leader>dq", require("dap").close, { desc = "Quit" })
        vim.keymap.set("n", "<leader>dq", require("dap").terminate,
            { desc = "Terminate the debug session" })
        vim.keymap.set("n", "<leader>dU", function()
            require("dapui").toggle({ reset = true })
        end, { desc = "Toggle UI" })
    end,
}
