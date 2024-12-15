local M = {}

M.nvimtree = {
  {
    "<leader>xf",
    ":NvimTreeFocus<CR>",
    desc = "e[x]plore [f]ocus",
    silent = true,
  },
  {
    "<leader>xt",
    ":NvimTreeToggle<CR>",
    desc = "e[x]plore [t]oggle",
    silent = true,
  },
}

M.telescope = function()
  return {
    -- files and strings
    {
      "<leader>sf",
      ":Telescope find_files<CR>",
      desc = "[s]earch [f]iles",
      silent = true,
    },
    {
      "<leader>so",
      ":Telescope oldfiles<CR>",
      desc = "[s]earch [o]ld files",
      silent = true,
    },
    {
      "<leader>sb",
      ":Telescope buffers<CR>",
      desc = "[s]earch [b]uffers",
      silent = true,
    },
    {
      "<leader>sg",
      ":Telescope git_files<CR>",
      desc = "[s]earch [g]it files",
      silent = true,
    },
    {
      "<leader>ss",
      ":Telescope live_grep<CR>",
      desc = "[s]earch [s]tring",
      silent = true,
    },
    {
      "<leader>sS",
      ":Telescope live_grep additional_args={'--hidden','--no-ignore'}<CR>",
      desc = "[s]earch [S]tring hidden/ignore",
      silent = true,
    },
    {
      "<leader>sw",
      ":Telescope grep_string<CR>",
      desc = "[s]earch [w]ord under cursor",
      silent = true,
    },
    {
      "<leader>sW",
      ":Telescope grep_string additional_args={'--hidden','--no-ignore'}<CR>",
      desc = "[s]earch [W]ord under cursor hidden/ignore",
      silent = true,
    },
    {
      "<leader>/",
      ":Telescope current_buffer_fuzzy_find<CR>",
      desc = "search fuzzy as [/]",
      silent = true,
    },

    -- utils
    {
      "<leader>sh",
      ":Telescope help_tags<CR>",
      desc = "[s]earch [h]elp",
      silent = true,
    },
    {
      "<leader>sk",
      ":Telescope keymaps<CR>",
      desc = "[s]earch [k]eymaps",
      silent = true,
    },
    {
      "<leader>sm",
      ":Telescope marks<CR>",
      desc = "[s]earch [m]arks",
      silent = true,
    },
    {
      "<leader>sv",
      ":Telescope vim_options<CR>",
      desc = "[s]earch [v]im options",
      silent = true,
    },
    {
      "<leader>sr",
      ":Telescope registers<CR>",
      desc = "[s]earch [r]egisters",
      silent = true,
    },

    -- git
    {
      "<leader>gl",
      ":Telescope git_commits<CR>",
      desc = "[g]it [l]og",
      silent = true,
    },
    {
      "<leader>gb",
      ":Telescope git_branches<CR>",
      desc = "[g]it [b]ranch",
      silent = true,
    },
    {
      "<leader>gs",
      ":Telescope git_status<CR>",
      desc = "[g]it [s]tatus",
      silent = true,
    },
  }
end

return M
