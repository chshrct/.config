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
  -- eslint = {
  --   root_dir = "/home/chshrct/Projects/shiftmanager-frontend",
  --   settings = {
  --     experimental = {
  --       useFlatConfig = true
  --     },
  --     packageManager = "yarn",
  --     nodePath = ".yarn/sdks",
  --   }
  -- },
  hyprls = {},
  -- emmet_language_server = {},
  -- ts_ls = {},
  csharp_ls = {},

  vtsls = {
    init_options = {
      hostInfo = "neovim",
    },
    root_markers = { ".git/", "package.json" },
    settings = {
      refactor_auto_rename = true,
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
            entriesLimit = 20,
          },
        },
      },
      typescript = {
        tsdk = ".yarn/sdks/typescript/lib",
        tsserver = {
          maxTsServerMemory = 8192
        },
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },

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
