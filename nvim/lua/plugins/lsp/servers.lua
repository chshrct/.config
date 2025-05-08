local M = {}

M.servers = {
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
  hyprls = {},
  emmet_language_server = {},
  vtsls = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>lio", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.organizeImports" },
          },
        })
      end, { buffer = bufnr, desc = "[l]sp [i]mports [o]rganize" })
      vim.keymap.set("n", "<leader>lia", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.addMissingImports" },
          },
        })
      end, { buffer = bufnr, desc = "[l]sp [i]mports [a]dd" })
      vim.keymap.set("n", "<leader>lF", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.fixAll" },
          },
        })
      end, { buffer = bufnr, desc = "[l]sp [F]ix all" })
    end,
    -- explicitly add default filetypes, so that we can extend
    -- them in related extras
    settings = {
      complete_function_calls = true,
      vtsls = {
        init_options = { hostInfo = "neovim" },
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
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
