return {
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "saadparwaiz1/cmp_luasnip",

      -- sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local icons = require("settings.icons")

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = require("plugins.completion.keymaps").cmp(),
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind" },
          format = function(_, vim_item)
            vim_item.kind = (icons.kind[vim_item.kind] or "")
              .. " "
              .. vim_item.kind
            return vim_item
          end,
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter" },
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
        },
      })
    end,
  },

  -- copilot chat
  {
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      branch = "canary",
      dependencies = {
        { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
        { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
      },
      keys = {
        -- Toggle Copilot Chat Vsplit
        {
          "<leader>ccv",
          "<cmd>CopilotChatToggle<cr>",
          desc = "CopilotChat - Toggle Vsplit",
        },
        -- Quick chat with Copilot
        {
          "<leader>ccq",
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              vim.cmd("CopilotChatBuffer " .. input)
            end
          end,
          desc = "CopilotChat - Quick chat",
        },
        -- Show help actions with telescope
        {
          "<leader>cch",
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(
              actions.help_actions()
            )
          end,
          desc = "CopilotChat - Help actions",
        },
        -- Show prompts actions with telescope
        {
          "<leader>ccp",
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(
              actions.prompt_actions()
            )
          end,
          desc = "CopilotChat - Prompt actions",
        },
        -- Code related commands
        {
          "<leader>cce",
          "<cmd>CopilotChatExplain<cr>",
          desc = "CopilotChat - Explain code",
        },
        {
          "<leader>cct",
          "<cmd>CopilotChatTests<cr>",
          desc = "CopilotChat - Generate tests",
        },
        {
          "<leader>ccf",
          "<cmd>CopilotChatFixDiagnostic<cr>",
          desc = "CopilotChat - Fix Diagnostic",
        },
        {
          "<leader>ccr",
          "<cmd>CopilotChatReview<cr>",
          desc = "CopilotChat - Review code",
        },
        -- Chat with Copilot in visual mode
        {
          "<leader>ccv",
          ":CopilotChatVisual<cr>",
          mode = "x",
          desc = "CopilotChat - Open in vertical split",
        },
        -- Custom input for CopilotChat
        {
          "<leader>cci",
          function()
            local input = vim.fn.input("Ask Copilot: ")
            if input ~= "" then
              vim.cmd("CopilotChat " .. input)
            end
          end,
          desc = "CopilotChat - Ask input",
        },
        -- Clear buffer and chat history
        {
          "<leader>ccl",
          "<cmd>CopilotChatReset<cr>",
          desc = "CopilotChat - Clear buffer and chat history",
        },
      },
      config = function(_, opts)
        local chat = require("CopilotChat")
        local select = require("CopilotChat.select")
        -- Use unnamed register for the selection
        opts.selection = select.unnamed

        chat.setup(opts)

        vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
          chat.ask(args.args, { selection = select.visual })
        end, { nargs = "*", range = true })

        -- Restore CopilotChatBuffer
        vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
          chat.ask(args.args, { selection = select.buffer })
        end, { nargs = "*", range = true })
      end,
    },
  },
}
