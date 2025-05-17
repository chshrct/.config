local M = {
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
          arrayIndex = "Enable",
          setType = true,
          paramName = "All",
          paramType = true,
          semicolon = "SameLine",
          compose = true,
        },
        completion = {
          callSnippet = "Replace",
          keywordSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
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
  eslint = {
    root_dir = "/home/chshrct/Projects/dodo/shiftmanager-frontend",
    settings = {
      nodePath = ".yarn/sdks",
    }
  },
  hyprls = {},
  emmet_language_server = {},
  ts_ls = {},
  -- vtsls = {
  --   init_options = {
  --     hostInfo = "neovim",
  --   },
  --   settings = {
  --     complete_function_calls = true,
  --     enableMoveToFileCodeAction = true,
  --     autoUseWorkspaceTsdk = true,
  --     experimental = {
  --       maxInlayHintLength = 30,
  --       completion = {
  --         enableServerSideFuzzyMatch = true,
  --       },
  --     },
  --     typescript = {
  --       tsdk = "/home/chshrct/Projects/dodo/shiftmanager-frontend/.yarn/sdks/typescript/lib",
  --       tsserver = {
  --         maxTsServerMemory = 8192
  --       },
  --       updateImportsOnFileMove = { enabled = "always" },
  --       suggest = {
  --         completeFunctionCalls = true,
  --       },
  --       inlayHints = {
  --         enumMemberValues = { enabled = true },
  --         functionLikeReturnTypes = { enabled = true },
  --         parameterNames = { enabled = "literals" },
  --         parameterTypes = { enabled = true },
  --         propertyDeclarationTypes = { enabled = true },
  --         variableTypes = { enabled = false },
  --       },
  --     },
  --   },
  -- },

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
}

return M
