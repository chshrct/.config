local M = {}

M.noice = {
  {
    "<leader>snl",
    function()
      require("noice").cmd("last")
    end,
    desc = "[s]earch [n]oice [l]ast message",
  },
  {
    "<leader>snh",
    function()
      require("noice").cmd("history")
    end,
    desc = "[s]earch [n]oice [h]istory",
  },
  {
    "<leader>sna",
    function()
      require("noice").cmd("all")
    end,
    desc = "[s]earch [n]oice [a]ll messages",
  },
}

M.trouble = {
  {
    "<leader>et",
    "<cmd>TroubleToggle document_diagnostics<cr>",
    desc = "[e]rrors [t]oggle (document)",
  },
  {
    "<leader>Et",
    "<cmd>TroubleToggle workspace_diagnostics<cr>",
    desc = "[E]rrors [t]oggle (workspace)",
  },
  {
    "<leader>lt",
    "<cmd>TroubleToggle loclist<cr>",
    desc = "[l]ocallist [t]oggle",
  },
  {
    "<leader>qt",
    "<cmd>TroubleToggle quickfix<cr>",
    desc = "[q]uickfix [t]oggle",
  },
  {
    "[q",
    function()
      if require("trouble").is_open() then
        require("trouble").previous({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end
    end,
    desc = "previous trouble/[q]uickfix item",
  },
  {
    "]q",
    function()
      if require("trouble").is_open() then
        require("trouble").next({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end
    end,
    desc = "next trouble/[q]uickfix item",
  },
}

return M
