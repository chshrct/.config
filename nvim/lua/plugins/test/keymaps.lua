local M = {}

M.neotest = {
  {
    "<leader>tf",
    function()
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    desc = "[t]est [f]ile",
  },
  {
    "<leader>tF",
    function()
      require("neotest").run.run(vim.loop.cwd())
    end,
    desc = "[t]ests all [F]iles",
  },
  {
    "<leader>tr",
    function()
      require("neotest").run.run()
    end,
    desc = "[t]est [r]un",
  },
  {
    "<leader>tt",
    function()
      require("neotest").summary.toggle()
    end,
    desc = "[t]ests [t]oggle summary",
  },
  {
    "<leader>to",
    function()
      require("neotest").output.open({ enter = true, auto_close = true })
    end,
    desc = "[t]ests [o]utput",
  },
  {
    "<leader>tO",
    function()
      require("neotest").output_panel.toggle()
    end,
    desc = "[t]oggle test [O]utput Panel",
  },
  {
    "<leader>ts",
    function()
      require("neotest").run.stop()
    end,
    desc = "[t]ests [s]top",
  },
}

return M
