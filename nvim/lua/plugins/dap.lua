return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Breakpoint
      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = "",
      })

      -- Conditional breakpoint
      vim.fn.sign_define("DapBreakpointCondition", {
        text = "◉",
        texthl = "DapBreakpointCondition",
        linehl = "",
        numhl = "",
      })

      -- Rejected breakpoint
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "✖",
        texthl = "DapBreakpointRejected",
        linehl = "",
        numhl = "",
      })

      -- Log point
      vim.fn.sign_define("DapLogPoint", {
        text = "ℹ",
        texthl = "DapLogPoint",
        linehl = "",
        numhl = "",
      })

      -- Stopped position (current execution line)
      vim.fn.sign_define("DapStopped", {
        text = "▶",
        texthl = "DapStopped",
        linehl = "CursorLine", -- highlight current line
        numhl = "DapStopped", -- optional: highlight line number
      })

      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#E51400" }) -- red
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#FFCC00" }) -- yellow
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#6A737D" }) -- gray
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#75BEFF" }) -- blue
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#4EC9B0", bold = true }) -- teal/green
    end,
  },
  -- close DAP UI when debugging session ends
  {
    "rcarriga/nvim-dap-ui",
    opts = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dap.listeners.after.event_initialized["dapui_auto"] = function()
        dapui.open()
      end

      local function close_ui()
        dapui.close()
      end

      dap.listeners.before.event_terminated["dapui_auto"] = close_ui
      dap.listeners.before.event_exited["dapui_auto"] = close_ui
      dap.listeners.before.disconnect["dapui_auto"] = close_ui

      return opts
    end,
  },
}
