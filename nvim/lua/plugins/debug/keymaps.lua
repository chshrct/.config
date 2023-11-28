local M = {}

M.dapui = {
  {
    "<leader>td",
    function()
      require("dapui").toggle({})
    end,
    desc = "[t]oggle [d]ebug",
  },
  {
    "<leader>de",
    function()
      require("dapui").eval()
    end,
    desc = "[d]ebug [e]val",
    mode = { "n", "v" },
  },
}

M.dap = {
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "[d]ebug set [B]reakpoint condition",
  },
  {
    "<leader>db",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "[d]ebug set [b]reakpoint",
  },
  {
    "<leader>dc",
    function()
      require("dap").continue()
    end,
    desc = "[d]ebug [c]ontinue",
  },
  {
    "<leader>dC",
    function()
      require("dap").run_to_cursor()
    end,
    desc = "[d]ebug run to [C]ursor",
  },
  {
    "<leader>dg",
    function()
      require("dap").goto_()
    end,
    desc = "[d]ebug [g]o to line (no execute)",
  },
  {
    "<leader>di",
    function()
      require("dap").step_into()
    end,
    desc = "[d]ebug step [i]nto",
  },
  {
    "<leader>dj",
    function()
      require("dap").down()
    end,
    desc = "[d]ebug down",
  },
  {
    "<leader>dk",
    function()
      require("dap").up()
    end,
    desc = "[d]ebug up",
  },
  {
    "<leader>dl",
    function()
      require("dap").run_last()
    end,
    desc = "[d]ebug run [l]ast",
  },
  {
    "<leader>dO",
    function()
      require("dap").step_out()
    end,
    desc = "[d]ebug step [O]ut",
  },
  {
    "<leader>do",
    function()
      require("dap").step_over()
    end,
    desc = "[d]ebug step [o]ver",
  },
  {
    "<leader>dp",
    function()
      require("dap").pause()
    end,
    desc = "[d]ebug [p]ause",
  },
  {
    "<leader>dr",
    function()
      require("dap").repl.toggle()
    end,
    desc = "[d]ebug [r]EPL",
  },
  {
    "<leader>ds",
    function()
      require("dap").session()
    end,
    desc = "[d]ebug [s]ession",
  },
  {
    "<leader>dT",
    function()
      require("dap").terminate()
    end,
    desc = "[d]ebug [T]erminate",
  },
  {
    "<leader>dw",
    function()
      require("dap.ui.widgets").hover()
    end,
    desc = "[d]ebug [w]idgets",
  },
  {
    "<leader>dt",
    function()
      require("neotest").run.run({ strategy = "dap" })
    end,
    desc = "[d]ebug [t]est",
  },
}

return M
