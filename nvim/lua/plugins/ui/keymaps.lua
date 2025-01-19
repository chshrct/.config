local M = {}

M.trouble = {
  { "<leader>ed", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", desc = "lsp: [e]rrors [d]ocument", },
  { "<leader>ew", "<cmd>Trouble diagnostics toggle focus=true<cr>",              desc = "lsp: [e]rrors [w]orkspace", },
  { "<leader>lt", "<cmd>Trouble loclist toggle focus=true<cr>",                  desc = "[l]oclist [t]oggle", },
  { "<leader>qt", "<cmd>Trouble qflist toggle focus=true<cr>",                   desc = "[q]uickfixlist [t]oggle", },
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
