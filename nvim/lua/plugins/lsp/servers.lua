local M = {}

M.servers = {
  lua_ls = {
    settings = {
      Lua = {
        -- Tell the language server which version of Lua you're using
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the 'vim' global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telementary = {
          enable = false,
        },
        hint = {
          arrayIndex = "Auto",
          enable = true,
          setType = true,
        },
      },
    },
  },
  -- web
  cssls = {},
  html = {},
  graphql = {},
  cssmodules_ls = {},
  tailwindcss = {},
  eslint = {},
  emmet_language_server = {},
  -- Probably want to disable formatting for this lang server
  vtsls = {},
  -- configs
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
  taplo = {},
  csharp_ls = {},
}

return M
