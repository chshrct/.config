local M = {}

M.diagnostic = function()
  vim.keymap.set(
    "n",
    "[d",
    vim.diagnostic.goto_prev,
    { desc = "previous [d]iagnostic message" }
  )
  vim.keymap.set(
    "n",
    "]d",
    vim.diagnostic.goto_next,
    { desc = "next [d]iagnostic message" }
  )
  vim.keymap.set(
    "n",
    "gl",
    vim.diagnostic.open_float,
    { desc = "[l]ine diagnostic" }
  )
end

M.lsp = function(bufnr)
  vim.keymap.set(
    "n",
    "<leader>lr",
    vim.lsp.buf.rename,
    { buffer = bufnr, desc = "[l]sp: [r]ename" }
  )
  vim.keymap.set(
    "n",
    "<leader>la",
    vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "[l]sp: [a]ction" }
  )
  vim.keymap.set(
    "n",
    "<leader>lf",
    vim.lsp.buf.format,
    { buffer = bufnr, desc = "[l]sp: [f]ormat" }
  )
  vim.keymap.set(
    "n",
    "gd",
    ":Trouble lsp_definitions<CR>",
    { buffer = bufnr, desc = "lsp: [g]oto [d]efinition", silent = true }
  )
  vim.keymap.set(
    "n",
    "gr",
    ":Trouble lsp_references<CR>",
    { buffer = bufnr, desc = "lsp: [g]oto [r]eferences", silent = true }
  )
  vim.keymap.set(
    "n",
    "gI",
    ":Trouble lsp_implementations<CR>",
    { buffer = bufnr, desc = "lsp: [g]oto [I]mplementation", silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>D",
    ":Trouble lsp_type_definitions<CR>",
    { buffer = bufnr, desc = "lsp: type [D]efinition", silent = true }
  )
  vim.keymap.set("n", "<leader>ws", ":Telescope lsp_document_symbols<CR>", {
    buffer = bufnr,
    desc = "lsp: [w]orkspace(document) [s]ymbols",
    silent = true,
  })
  vim.keymap.set(
    "n",
    "<leader>wS",
    ":Telescope lsp_dynamic_workspace_symbols<CR>",
    { buffer = bufnr, desc = "lsp: [w]orkspace [S]ymbols", silent = true }
  )

  -- See `:help K` for why this keymap
  vim.keymap.set(
    "n",
    "K",
    vim.lsp.buf.hover,
    { buffer = bufnr, desc = "lsp: hover documentation" }
  )
  vim.keymap.set(
    { "n", "i" },
    "<C-k>",
    vim.lsp.buf.signature_help,
    { buffer = bufnr, desc = "lsp: signature documentation" }
  )

  -- Lesser used LSP functionality
  vim.keymap.set(
    "n",
    "gD",
    vim.lsp.buf.declaration,
    { buffer = bufnr, desc = "lsp: [g]oto [D]eclaration" }
  )
  vim.keymap.set(
    "n",
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buffer = bufnr, desc = "lsp: [w]orkspace [a]dd folder" }
  )
  vim.keymap.set(
    "n",
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { buffer = bufnr, desc = "lsp: [w]orkspace [r]emove folder" }
  )
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = "lsp: [w]orkspace [l]ist folders" })
end

M.typescript = function(bufnr)
  vim.keymap.set(
    "n",
    "<leader>lo",
    ":TSToolsOrganizeImports<CR>",
    { buffer = bufnr, desc = "[l]sp: [o]rganize imports", silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>li",
    ":TSToolsAddMissingImports<CR>",
    { buffer = bufnr, desc = "[l]sp: add missing [i]mports", silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>lR",
    ":TSToolsRenameFile<CR>",
    { buffer = bufnr, desc = "[l]sp: [r]ename file", silent = true }
  )
end

return M
