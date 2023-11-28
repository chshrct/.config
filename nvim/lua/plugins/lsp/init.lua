return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", cmd = "Mason", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "Hoffs/omnisharp-extended-lsp.nvim",
    },
    config = function()
      require("plugins.lsp.keymaps").diagnostic()

      local on_attach = function(client, bufnr)
        require("plugins.lsp.keymaps").lsp(bufnr)
        -- hints
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(bufnr, true)
        end
      end

      local servers = {
        lua_ls = {
          Lua = {
            hint = {
              enable = true,
            },
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
        omnisharp = {
          enable_editorconfig_support = true,
          enable_ms_build_load_projects_on_demand = false,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          sdk_include_prereleases = true,
          analyze_open_documents_only = false,
        },
      }

      require("neodev").setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          if server_name ~= "tsserver" then
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            })
          end
        end,
      })

      -- c# go to definition fix
      require("plugins.lsp.languages.c#").goToFix(
        capabilities,
        on_attach,
        servers
      )
    end,
  },

  -- typescript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(client, bufnr)
        require("plugins.lsp.keymaps").lsp(bufnr)
        require("plugins.lsp.keymaps").typescript(bufnr)

        -- hints
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(bufnr, true)
        end
      end,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
        },
      },
    },
  },

  -- Linters/Formatter
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local nls = require("null-ls")
      local hasEslint = function(utils)
        return utils.root_has_file({ ".eslintrc.json" })
      end
      nls.setup({
        sources = {
          -- Lua
          nls.builtins.formatting.stylua,
          -- JS/TS
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.eslint_d.with({ -- js/ts linter
            condition = hasEslint,
          }),
          nls.builtins.diagnostics.eslint_d.with({ -- js/ts linter
            condition = hasEslint,
          }),
          nls.builtins.code_actions.eslint_d.with({ -- js/ts linter
            condition = hasEslint,
          }),
        },
      })
    end,
  },
}
