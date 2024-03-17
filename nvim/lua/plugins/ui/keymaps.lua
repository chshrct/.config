local M = {}

M.trouble = {
  {
    "<leader>ed",
    "<cmd>TroubleToggle document_diagnostics<cr>",
    desc = "lsp: [e]rrors [d]ocument",
  },
  {
    "<leader>ew",
    "<cmd>TroubleToggle workspace_diagnostics<cr>",
    desc = "lsp: [e]rrors [w]orkspace",
  },
  {
    "<leader>lt",
    "<cmd>TroubleToggle loclist<cr>",
    desc = "[l]oclist [t]oggle",
  },
  {
    "<leader>qt",
    "<cmd>TroubleToggle quickfix<cr>",
    desc = "[q]uickfixlist [t]oggle",
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
