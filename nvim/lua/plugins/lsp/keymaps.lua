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
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded", focusable = true }) end,
    { buffer = event.buf, desc = "lsp: hover documentation" })
  -- vim.keymap.set({ "n", "i" }, "<C-k>",
  --   function() vim.lsp.buf.signature_help({ border = "rounded", focusable = true }) end,
  --   { buffer = event.buf, desc = "lsp: signature help" })

  -- Lesser used LSP functionality
  vim.keymap.set("n", "<leader>ld", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[l]sp: goto [d]eclaration" })
  vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder,
    { buffer = event.buf, desc = "[l]sp: [w]orkspace [a]dd folder" })
  vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder,
    { buffer = event.buf, desc = "[l]sp: [w]orkspace [r]emove folder" })
  vim.keymap.set("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    { buffer = event.buf, desc = "[l]sp: [w]orkspace [l]ist folders" })

  -- vtsls
  vim.keymap.set("n", "<leader>lio", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports" },
      },
    })
  end, { buffer = event.buf, desc = "[l]sp [i]mports [o]rganize" })
  vim.keymap.set("n", "<leader>lia", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.addMissingImports.ts" },
      },
    })
  end, { buffer = event.buf, desc = "[l]sp [i]mports [a]dd" })


  vim.keymap.set("n", "<leader>ll", ":LspEslintFixAll<CR>", { buffer = event.buf, desc = "[l]sp es[l]int fix" })

  local function client_supports_method(client, method, buf)
    if vim.fn.has 'nvim-0.11' == 1 then
      return client:supports_method(method, buf)
    else
      return client.supports_method(method, { buf = buf })
    end
  end

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    vim.keymap.set('n', '<leader>lh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { buf = event.buf })
    end, { buffer = event.buf, desc = 'toggle [L]sp inlay [H]ints' })
  end
end

M.format = function(conform)
  vim.keymap.set("n", "<leader>lf",
    function() conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000, }) end,
    { desc = "[l]sp: [f]ormat" })
end

return M
