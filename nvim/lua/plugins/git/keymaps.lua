local M = {}

M.gitsigns = function(buffer)
  local gs = package.loaded.gitsigns

  -- Navigation
  vim.keymap.set(
    "n",
    "]h",
    gs.next_hunk,
    { buffer = buffer, desc = "next [h]unk" }
  )
  vim.keymap.set(
    "n",
    "[h",
    gs.prev_hunk,
    { buffer = buffer, desc = "previous [h]unk" }
  )

  -- Actions
  vim.keymap.set(
    { "n", "v" },
    "<leader>hs",
    ":Gitsigns stage_hunk<CR>zz",
    { buffer = buffer, desc = "[h]unk [s]tage" }
  )
  vim.keymap.set(
    { "n", "v" },
    "<leader>hr",
    ":Gitsigns reset_hunk<CR>zz",
    { buffer = buffer, desc = "[h]unk [r]eset" }
  )
  vim.keymap.set(
    "n",
    "<leader>hS",
    gs.stage_buffer,
    { buffer = buffer, desc = "[h]unk [S]tage buffer" }
  )
  vim.keymap.set(
    "n",
    "<leader>hu",
    gs.undo_stage_hunk,
    { buffer = buffer, desc = "[h]unk [u]nstage" }
  )
  vim.keymap.set(
    "n",
    "<leader>hR",
    gs.reset_buffer,
    { buffer = buffer, desc = "[h]unk [R]eset buffer" }
  )
  vim.keymap.set(
    "n",
    "<leader>hp",
    gs.preview_hunk,
    { buffer = buffer, desc = "[h]unk preview" }
  )
  vim.keymap.set("n", "<leader>hd", function()
    vim.ui.input({ prompt = "Diff against" }, function(input)
      vim.cmd("Gitsigns diffthis " .. input .. " split=botright")
    end, { buffer = buffer, desc = "[h]unk diff" })
  end)
  vim.keymap.set(
    "n",
    "<leader>ht",
    gs.toggle_deleted,
    { buffer = buffer, desc = "[h]unk [t]oggle deleted" }
  )

  -- Text object
  vim.keymap.set(
    { "o", "x" },
    "ih",
    ":<C-U>Gitsigns select_hunk<CR>",
    { buffer = buffer, desc = "[i]nner [h]unk" }
  )
end

M.gitblame = {
  {
    "<leader>bt",
    "<cmd>GitBlameToggle<CR>",
    desc = "[b]lame [t]oggle",
  },
  {
    "<leader>by",
    "<cmd>GitBlameCopySHA<CR>",
    desc = "[b]lame [y]ank commit hash",
  },
  {
    "<leader>bf",
    "<cmd>GitBlameOpenFileURL<CR>",
    desc = "[b]lame file URL",
  },
  {
    "<leader>bc",
    "<cmd>GitBlameOpenCommitURL<CR>",
    desc = "[b]lame [c]ommit URL",
  },
}

M.diffview = {
  {
    "<leader>gd",
    function()
      vim.ui.input({ prompt = "Diff revision/options" }, function(input)
        if input then
          vim.api.nvim_command("DiffviewOpen" .. " " .. input)
        end
      end)
    end,
    desc = "[g]it [d]iff",
  },
  {
    "<leader>gf",
    function()
      vim.ui.input({ prompt = "Files history paths/options" }, function(input)
        if input then
          vim.api.nvim_command("DiffviewFileHistory" .. " " .. input)
        end
      end)
    end,
    desc = "[g]it [f]ile history",
  },
}

return M
