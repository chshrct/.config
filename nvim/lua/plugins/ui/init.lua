return {
  -- devicons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local gitIcons = require("settings.icons").git
      return {
        options = {
          globalstatus = true,
          icons_enabled = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = gitIcons.LineAdded .. " ",
                modified = gitIcons.LineModified .. " ",
                removed = gitIcons.LineRemoved .. " ",
              },
            },
            "diagnostics",
          },
          lualine_c = {
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              "filename",
              path = 1,
              symbols = { modified = "  ", readonly = "", unnamed = "" },
            },
          },
          lualine_x = {
            "encoding",
            {
              "fileformat",
            },
          },
          lualine_y = {
            {
              "progress",
              separator = "|",
            },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. " " .. os.date("%R")
            end,
          },
        },
        extensions = { "nvim-tree", "mason", "fzf", "lazy", "quickfix" },
      }
    end,
  },

  -- dressing
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- lightbulb
  {
    "kosayoda/nvim-lightbulb",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = { "antoinemadec/FixCursorHold.nvim" },
    config = function()
      require("nvim-lightbulb").setup({
        autocmd = { enabled = true },
        sign = { enabled = false },
        virtual_text = { enabled = true },
      })
    end,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = require("plugins.ui.keymaps").trouble,
  },
}
