return {

  {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        { "j-hui/fidget.nvim", opts = {} },

        -- Autoformatting
        "stevearc/conform.nvim",

        -- Schema information
        "b0o/SchemaStore.nvim",
      },
      lazy = true,
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      config = function()
        require("neodev").setup({
          -- library = {
          --   plugins = { "nvim-dap-ui" },
          --   types = true,
          -- },
        })

        -- hover round border
        local orig_util_open_floating_preview =
          vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
          opts = opts or {}
          opts.border = "rounded"
          return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        local capabilities = nil
        if pcall(require, "cmp_nvim_lsp") then
          capabilities = require("cmp_nvim_lsp").default_capabilities()
        end

        local lspconfig = require("lspconfig")

        local servers = {
          lua_ls = true,
          -- web
          cssls = true,
          html = true,
          graphql = true,
          cssmodules_ls = true,
          tailwindcss = true,
          eslint = true,
          emmet_language_server = true,
          -- Probably want to disable formatting for this lang server
          ts_ls = true,
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
          taplo = true,
          csharp_ls = true,
        }

        local servers_to_install = vim.tbl_filter(function(key)
          local t = servers[key]
          if type(t) == "table" then
            return not t.manual_install
          else
            return t
          end
        end, vim.tbl_keys(servers))

        require("mason").setup()
        local ensure_installed = {
          "stylua",
          "lua_ls",
          -- "tailwind-language-server",
        }

        vim.list_extend(ensure_installed, servers_to_install)
        require("mason-tool-installer").setup({
          ensure_installed = ensure_installed,
        })

        for name, config in pairs(servers) do
          if config == true then
            config = {}
          end
          config = vim.tbl_deep_extend("force", {}, {
            capabilities = capabilities,
          }, config)

          lspconfig[name].setup(config)
        end

        local disable_semantic_tokens = {
          lua = true,
        }

        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local bufnr = args.buf
            local client = assert(
              vim.lsp.get_client_by_id(args.data.client_id),
              "must have valid client"
            )

            vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
            local filetype = vim.bo[bufnr].filetype
            require("plugins.lsp.keymaps").lsp(args)
            if disable_semantic_tokens[filetype] then
              client.server_capabilities.semanticTokensProvider = nil
            end
          end,
        })
      end,
    },
  },

  -- format
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
      })

      require("plugins.lsp.keymaps").format(conform)
    end,
  },
}
