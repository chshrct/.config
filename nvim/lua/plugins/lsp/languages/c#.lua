local M = {}

M.goToFix = function(capabilities, on_attach, servers)
  require("lspconfig")["omnisharp"].setup({
    handlers = {
      ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers["omnisharp"],
    filetypes = (servers["omnisharp"] or {}).filetypes,
  })
end

return M
