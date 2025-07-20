return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = require("plugins.snacks.keymaps"),
  opts = {
    bigfile = {},
    quickfile = {},
    statuscolumn = {},
    explorer = {},
    words = {},
    indent = { enabled = false },
    scroll = { enabled = false },
    notifier = { enabled = false },
    input = {},
    scratch = {
      name = "Notes",
      ft = "markdown",
    },
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              position = "right"
            }
          }
        }
      }
    }
  },
}
