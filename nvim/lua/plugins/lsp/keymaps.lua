local M = {}

M.lsp = function(event)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = event.buf, desc = "[l]sp: [r]ename" })
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = event.buf, desc = "[l]sp: [a]ction" })
  vim.keymap.set("n", "gd", ":Trouble lsp_definitions focus=true<CR>",
    { buffer = event.buf, desc = "lsp: [g]oto [d]efinition", silent = true })
  vim.keymap.set("n", "gr", ":Trouble lsp_references focus=true<CR>",
    { buffer = event.buf, desc = "lsp: [g]oto [r]eferences", silent = true })
  vim.keymap.set("n", "<leader>li", ":Trouble lsp_implementations focus=true<CR>",
    { buffer = event.buf, desc = "[l]sp: goto [i]mplementation", silent = true })
  vim.keymap.set("n", "<leader>lt", ":Trouble lsp_type_definitions focus=true<CR>",
    { buffer = event.buf, desc = "[l]sp: [t]ype definition", silent = true })
  vim.keymap.set("n", "<leader>ls", Snacks.picker.lsp_symbols,
    { buffer = event.buf, desc = "[l]sp: document [s]ymbols", silent = true, })
  vim.keymap.set("n", "<leader>lS", Snacks.picker.lsp_workspace_symbols,
    { buffer = event.buf, desc = "[l]sp: workspace [S]ymbols", silent = true })

  -- See `:help K` for why this keymap
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "lsp: hover documentation" })

  -- Lesser used LSP functionality
  vim.keymap.set("n", "<leader>ld", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[l]sp: goto [d]eclaration" })
  vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder,
    { buffer = event.buf, desc = "[l]sp: [w]orkspace [a]dd folder" })
  vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder,
    { buffer = event.buf, desc = "[l]sp: [w]orkspace [r]emove folder" })
  vim.keymap.set("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    { buffer = event.buf, desc = "[l]sp: [w]orkspace [l]ist folders" })
end

M.format = function(conform)
  vim.keymap.set("n", "<leader>lf",
    function() conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000, }) end,
    { desc = "[l]sp: [f]ormat" })
end

return M
