local M = {}

M.minifiles = {
  { "<leader>m", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "[m]ini files (Current file directory)", },
  { "<leader>M", function() require("mini.files").open(vim.uv.cwd(), true) end,                 desc = "[M]ini files (Current working directory)", },
}

return M
