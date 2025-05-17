return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        -- tools installer
        "williamboman/mason.nvim",
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { "j-hui/fidget.nvim", opts = {} },

        -- Schema information
        "b0o/SchemaStore.nvim",
      },
      cmd = { "LspInfo", "LspInstall", "LspStart" },
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        vim.lsp.set_log_level('debug')

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
          callback = function(event)
            require("plugins.lsp.keymaps").lsp(event)
          end,
        })

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        local servers = require("plugins.lsp.servers")

        local ensure_installed = vim.tbl_keys(servers or {})

        require('mason-tool-installer').setup {
          ensure_installed = ensure_installed
        }

        for server_name, _ in pairs(servers) do
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            capabilities,
            server.capabilities or {}
          )
          vim.lsp.config(server_name, server or {})
          vim.lsp.enable(server_name)
        end
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
          javascript = { "prettier", "eslint" },
          typescript = { "prettier", "eslint" },
          javascriptreact = { "prettier", "eslint" },
          typescriptreact = { "prettier", "eslint" },
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
