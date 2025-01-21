return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<leader>pr", function() require("persistence").load() end,                desc = "[p]ersistence [r]estore", },
    { "<leader>sp", function() require("persistence").select() end,              desc = "[s]earch [p]ersistence", },
    { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "[p]ersistence [l]oad", },
    { "<leader>ps", function() require("persistence").stop() end,                desc = "[p]ersistence [s]top", },
  },
}
