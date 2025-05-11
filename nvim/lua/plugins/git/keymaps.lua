local M = {}

M.gitsigns = function(buffer)
  local gs = package.loaded.gitsigns

  -- Navigation
  vim.keymap.set("n", "]h", gs.next_hunk, { buffer = buffer, desc = "next [h]unk" })
  vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = buffer, desc = "previous [h]unk" })

  -- Actions
  vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>zz", { buffer = buffer, desc = "[h]unk [s]tage" })
  vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>zz", { buffer = buffer, desc = "[h]unk [r]eset" })
  vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = buffer, desc = "[h]unk [S]tage buffer" })
  vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = buffer, desc = "[h]unk [u]nstage" })
  vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = buffer, desc = "[h]unk [R]eset buffer" })
  vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = buffer, desc = "[h]unk preview" })
  vim.keymap.set("n", "<leader>hd",
    function()
      vim.ui.input({ prompt = "Diff against" },
        function(input) vim.cmd("Gitsigns diffthis " .. input .. " split=botright") end)
    end,
    { buffer = buffer, desc = "[h]unk diff" })
  vim.keymap.set("n", "<leader>ht", gs.toggle_deleted, { buffer = buffer, desc = "[h]unk [t]oggle deleted" })
  vim.keymap.set("n", "<leader>bt", ":<C-U>Gitsigns toggle_current_line_blame<CR>",
    { buffer = buffer, desc = "[b]lame line [t]oggle" })
  vim.keymap.set("n", "<leader>gb", ":<C-U>Gitsigns blame<CR>", { buffer = buffer, desc = "[b]lame toggle" })
end

return M
