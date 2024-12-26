return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = require("plugins.snacks.keymaps"),
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    indent = { enabled = false },
    scroll = { enabled = false },
    scratch = {
      name = "Notes",
      ft = "markdown",
    },
  },
}
