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
      local diagnosticsIcons = require("settings.icons").diagnostics
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
            {

              "diagnostics",
              symbols = {
                error = diagnosticsIcons.Error,
                warn = diagnosticsIcons.Warn,
                info = diagnosticsIcons.Info,
                hint = diagnosticsIcons.Hint,
              },
            },
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

  -- lightbulb
  {
    "kosayoda/nvim-lightbulb",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = { "antoinemadec/FixCursorHold.nvim" },
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true },
    }
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = require("plugins.ui.keymaps").trouble,
  },
}
