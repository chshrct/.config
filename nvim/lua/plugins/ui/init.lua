return {
  -- devicons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    opts = {
      options = {
        globalstatus = true,
        disabled_filetypes = { statusline = { "lazy" } },
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
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
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree" },
    },
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      -- Terminal window mode mapping
      function _G.set_terminal_keymaps()
        local opts =
          { buffer = 0, desc = "Terminal windows mode", silent = true }
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      require("toggleterm").setup({
        open_mapping = [[<c-t>]],
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        direction = "vertical",
      })
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
