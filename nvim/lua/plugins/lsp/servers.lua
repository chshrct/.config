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
  vtsls = {
    on_attach = function(client, bufnr)
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
  csharp_ls = {},
}

return M
