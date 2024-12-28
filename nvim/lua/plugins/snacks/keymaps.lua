local M
M = {

  {
    "<leader>bd",
    function()
      Snacks.bufdelete()
    end,
    desc = "Delete Buffer",
  },
  {
    "<C-t>",
    function()
      Snacks.terminal()
    end,
    desc = "Toggle Terminal",
  },

  {
    "]]",
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    desc = "Next Reference",
    mode = { "n", "t" },
  },
  {
    "[[",
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    desc = "Prev Reference",
    mode = { "n", "t" },
  },

  {
    "<leader>z",
    function()
      Snacks.zen()
    end,
    desc = "Toggle Zen Mode",
  },
  {
    "<leader>Z",
    function()
      Snacks.zen.zoom()
    end,
    desc = "Toggle Zoom",
  },

  {
    "<leader>lR",
    function()
      Snacks.rename.rename_file()
    end,
    desc = "Rename File",
  },
  {
    "<leader>n",
    function()
      Snacks.scratch()
    end,
    desc = "[n]otes",
  },
  {
    "<leader>sn",
    function()
      Snacks.scratch.select()
    end,
    desc = "[s]earch [n]otes",
  },
}
return M
