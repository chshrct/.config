local M = {}

M.goToFix = function(capabilities, on_attach, servers)
  require("lspconfig")["omnisharp"].setup({
    handlers = {
      ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      enable_editorconfig_support = true,
      enable_ms_build_load_projects_on_demand = false,
      enable_roslyn_analyzers = true,
      organize_imports_on_format = true,
      enable_import_completion = true,
      sdk_include_prereleases = true,
      analyze_open_documents_only = false,
    },
    filetypes = (servers["omnisharp"] or {}).filetypes,
  })
end

return M
