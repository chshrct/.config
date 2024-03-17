return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },

      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          require("plugins.lsp.keymaps").lsp(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- hints
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(event.buf, true)
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      local servers = {
        -- gopls = {},
        -- pyright = {},

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              hint = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
      })
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              "force",
              {},
              capabilities,
              server.capabilities or {}
            )
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
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
