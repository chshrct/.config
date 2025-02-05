local M = {}

M.minifiles = {
  { "<leader>m", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "[m]ini files (Current file directory)", },
  { "<leader>M", function() require("mini.files").open(vim.uv.cwd(), true) end,                 desc = "[M]ini files (Current working directory)", },
}

M.fzf = function()
  return {
    -- files and strings
    { "<leader>sf", ":FzfLua files<CR>",        desc = "[f]ind [f]iles",               silent = true, },
    { "<leader>so", ":FzfLua oldfiles<CR>",     desc = "[s]earch [o]ld files",         silent = true, },
    { "<leader>sb", ":FzfLua buffers<CR>",      desc = "[s]earch [b]uffers",           silent = true, },
    { "<leader>sg", ":FzfLua git_files<CR>",    desc = "[s]earch [g]it files",         silent = true, },
    { "<leader>ss", ":FzfLua live_grep<CR>",    desc = "[s]earch [s]tring",            silent = true, },
    { "<leader>sw", ":FzfLua grep_cword<CR>",   desc = "[s]earch [w]ord under cursor", silent = true, },
    { "<leader>/",  ":FzfLua grep_curbuf<CR>",  desc = "search fuzzy as [/]",          silent = true, },

    -- utils
    { "<leader>sh", ":FzfLua helptags<CR>",     desc = "[s]earch [h]elp",              silent = true, },
    { "<leader>sk", ":FzfLua keymaps<CR>",      desc = "[s]earch [k]eymaps",           silent = true, },
    { "<leader>sm", ":FzfLua marks<CR>",        desc = "[s]earch [m]arks",             silent = true, },
    { "<leader>sr", ":FzfLua registers<CR>",    desc = "[s]earch [r]egisters",         silent = true, },

    -- git
    { "<leader>gl", ":FzfLua git_commits<CR>",  desc = "[g]it [l]og",                  silent = true, },
    { "<leader>gb", ":FzfLua git_branches<CR>", desc = "[g]it [b]ranch",               silent = true, },
    { "<leader>gs", ":FzfLua git_status<CR>",   desc = "[g]it [s]tatus",               silent = true, },
  }
end
return M
