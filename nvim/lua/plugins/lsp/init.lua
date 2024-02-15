return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", cmd = "Mason", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
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
    end,
  },

  -- typescript tools
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
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

  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      })

      require("plugins.lsp.keymaps").format(conform)
    end,
  },
}
