return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = require("plugins.snacks.keymaps"),
  opts = {
    bigfile = {},
    quickfile = {},
    statuscolumn = {},
    words = {},
    indent = { enabled = false },
    scroll = { enabled = false },
    scratch = {
      name = "Notes",
      ft = "markdown",
    },
    picker = {}
  },
}
