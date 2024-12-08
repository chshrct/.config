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
    "<leader>gg",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit",
  },
  {
    "<C-t>",
    function()
      Snacks.terminal()
    end,
    desc = "Toggle Terminal",
  },
}
return M
