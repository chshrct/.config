return {
  -- blink
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        lazy = true,
        opts = {},
        config = function()
          -- monkeypatch cmp.ConfirmBehavior for Avante
          require("cmp").ConfirmBehavior = {
            Insert = "insert",
            Replace = "replace",
          }
        end,
      },
    },
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      cmdline = {
        keymap = {
          preset = "enter",
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
        },
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = true
            }
          },
          menu = {
            auto_show = true
          }
        }
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files", "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100,
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
            opts = {},
          },
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
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            auto_insert = true,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = { "InsertEnter" },
    config = function()
      require("copilot").setup({
        copilot_model = "gpt-4o-copilot",
        suggestion = {
          auto_trigger = true,
        },
      })
    end,
  },

  -- avante
  {
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "copilot",
      model = "claude",
      copilot = {
        endpoint = "https://api.githubcopilot.com/",
        model = "claude-3.7-sonnet",
        temperature = 0,
        max_tokens = 8192,
      },
      language_server = {
        diagnostics = true,
        formatting = true,
      },
      ui = {
        markdown = true,
        code_actions = {
          enabled = true,
          virtual_text = true,
        },
        diagnostics = {
          virtual_text = true,
        },
      },
    },
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
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
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
