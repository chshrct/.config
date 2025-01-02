return {
  -- blink
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    build = "cargo build --release",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        cmdline = {
          preset = "enter",
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
      completion = {
        -- ghost_text = {
        --   enabled = true,
        -- },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ =
                    require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
              },
            },
          },
          -- auto_show = function(ctx)
          --   return ctx.mode == "cmdline" and true or false
          -- end,
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
        list = {
          selection = function(ctx)
            return ctx.mode == "cmdline" and "manual" or "preselect"
          end,
        },
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
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
      enabled = false,
      dependencies = {
        { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
        { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
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
  -- codeium
  {
    "Exafunction/codeium.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,

          -- These are the defaults

          -- Set to true if you never want completions to be shown automatically.
          manual = false,
          -- A mapping of filetype to true or false, to enable virtual text.
          filetypes = {},
          -- Whether to enable virtual text of not for filetypes not specifically listed above.
          default_filetype_enabled = true,
          -- How long to wait (in ms) before requesting completions after typing stops.
          idle_delay = 75,
          -- Priority of the virtual text. This usually ensures that the completions appear on top of
          -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
          -- desired.
          virtual_text_priority = 65535,
          -- Set to false to disable all key bindings for managing completions.
          map_keys = true,
          -- The key to press when hitting the accept keybinding but no completion is showing.
          -- Defaults to \t normally or <c-n> when a popup is showing.
          accept_fallback = nil,
          -- Key bindings for managing completions in virtual text mode.
          key_bindings = {
            -- Accept the current completion.
            accept = "<Tab>",
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = "<M-]>",
            -- Cycle to the previous completion.
            prev = "<M-[>",
          },
        },
      })
    end,
  },
  -- avante(Claude model)
  {
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- build = "make",
    build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.icons",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
