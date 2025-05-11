return {
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

  -- conflict
  {
    'akinsho/git-conflict.nvim',
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    version = "*",
    opts = {}
  }
}
