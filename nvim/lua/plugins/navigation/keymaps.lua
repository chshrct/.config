local M = {}

M.nvimtree = {
  {
    "<leader>xf",
    ":NvimTreeFocus<CR>",
    silent = true,
    desc = "e[x]plore [f]ocus",
  },
  {
    "<leader>xt",
    ":NvimTreeToggle<CR>",
    silent = true,
    desc = "e[x]plore [t]oggle",
  },
}

M.telescope = function()
  return {
    -- files and strings
    {
      "<leader>sf",
      ":Telescope find_files<CR>",
      desc = "[s]earch [f]iles",
    },
    {
      "<leader>so",
      ":Telescope oldfiles<CR>",
      desc = "[s]earch [o]ld files",
    },
    {
      "<leader>sb",
      ":Telescope buffers<CR>",
      desc = "[s]earch [b]uffers",
    },
    {
      "<leader>sg",
      ":Telescope git_files<CR>",
      desc = "[s]earch [g]it files",
    },
    {
      "<leader>ss",
      ":Telescope live_grep<CR>",
      desc = "[s]earch [s]tring",
    },
    {
      "<leader>sS",
      ":Telescope live_grep additional_args={'--hidden','--no-ignore'}<CR>",
      desc = "[s]earch [S]tring hidden/ignore",
    },
    {
      "<leader>sw",
      ":Telescope grep_string<CR>",
      desc = "[s]earch [w]ord under cursor",
    },
    {
      "<leader>sW",
      ":Telescope grep_string additional_args={'--hidden','--no-ignore'}<CR>",
      desc = "[s]earch [W]ord under cursor hidden/ignore",
    },
    {
      "<leader>/",
      ":Telescope current_buffer_fuzzy_find<CR>",
      silent = true,
      desc = "search fuzzy as [/]",
    },

    -- utils
    {
      "<leader>sh",
      ":Telescope help_tags<CR>",
      silent = true,
      desc = "[s]earch [h]elp",
    },
    {
      "<leader>sk",
      ":Telescope keymaps<CR>",
      silent = true,
      desc = "[s]earch [k]eymaps",
    },
    {
      "<leader>sm",
      ":Telescope marks<CR>",
      silent = true,
      desc = "[s]earch [m]arks",
    },
    {
      "<leader>sv",
      ":Telescope vim_options<CR>",
      silent = true,
      desc = "[s]earch [v]im options",
    },
    {
      "<leader>sr",
      ":Telescope registers<CR>",
      silent = true,
      desc = "[s]earch [r]egisters",
    },

    -- git
    {
      "<leader>gl",
      ":Telescope git_commits<CR>",
      silent = true,
      desc = "[g]it [l]og",
    },
    {
      "<leader>gb",
      ":Telescope git_branches<CR>",
      silent = true,
      desc = "[g]it [b]ranch",
    },
    {
      "<leader>gs",
      ":Telescope git_status<CR>",
      silent = true,
      desc = "[g]it [s]tatus",
    },
  }
end

return M
