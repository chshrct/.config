return {

  -- dap
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    keys = require("plugins.debug.keymaps").dap,
    config = function()
      -- icons
      local icons = require("editor.icons").ui
      vim.fn.sign_define(
        "DapBreakpoint",
        { text = icons.Bug, texthl = "DiagnosticWarn" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = icons.DebugConsole, texthl = "DiagnosticHint" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = icons.Target, texthl = "DiagnosticError" }
      )
      vim.fn.sign_define(
        "DapLogPoint",
        { text = icons.Note, texthl = "DiagnosticInfo" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = icons.DoubleChevronRight, texthl = "DiagnosticOk" }
      )

      -- dotnet settings
      require("plugins.debug.languages.dotnet").setup()
    end,
  },

  -- dapui
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "theHamsta/nvim-dap-virtual-text" },
    keys = require("plugins.debug.keymaps").dapui,
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
