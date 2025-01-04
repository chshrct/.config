return {
  -- neogit
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = function()
      return {
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signs_staged = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
        },

        on_attach = function(_)
          require("plugins.git.keymaps").gitsigns()
        end,
      }
    end,
  },

  -- git blame
  {
    "f-person/git-blame.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = require("plugins.git.keymaps").gitblame,
    opts = {
      enabled = false,
    },
  },

  -- diff
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = require("plugins.git.keymaps").diffview,
    opts = {},
  },
}
