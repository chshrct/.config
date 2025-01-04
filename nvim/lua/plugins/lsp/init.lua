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
        "williamboman/mason-lspconfig.nvim",

        { "j-hui/fidget.nvim", opts = {} },

        -- Schema information
        "b0o/SchemaStore.nvim",
      },
      cmd = { "LspInfo", "LspInstall", "LspStart" },
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        -- Настройка диагностики
        vim.diagnostic.config({
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            severity_sort = true,
          },
          float = {
            severity_sort = true,
            source = 'if_many',
            border = "rounded",
          },
          severity_sort = true,
          underline = true,
          update_in_insert = false
        })

        -- border
        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, {
              border = "rounded",
              focusable = true,
            })

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
          callback = function(event)
            require("plugins.lsp.keymaps").lsp(event)

            local client = vim.lsp.get_client_by_id(event.data.client_id)

            -- inlay hints toggle
            if
                client
                and client.supports_method(
                  vim.lsp.protocol.Methods.textDocument_inlayHint
                )
            then
              vim.keymap.set("n", "<leader>tH", function()
                vim.lsp.inlay_hint.enable(
                  not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                )
              end, {
                buffer = event.buf,
                desc = "[t]oggle inlay [H]ints",
              })
            end
          end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend(
          "force",
          capabilities,
          require("blink.cmp").get_lsp_capabilities()
        )

        local servers = require("plugins.lsp.servers").servers
        require("mason").setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {})

        require("mason-lspconfig").setup({
          ensure_installed = ensure_installed,
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
