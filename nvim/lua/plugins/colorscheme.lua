return {
  {
    "thesimonho/kanagawa-paper.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa-paper").setup({
        -- enable undercurls for underlined text
        undercurl = true,
        -- transparent background
        transparent = true,
        -- highlight background for the left gutter
        gutter = false,
        -- background for diagnostic virtual text
        diag_background = true,
        -- dim inactive windows. Disabled when transparent
        dim_inactive = true,
        -- set colors for terminal buffers
        terminal_colors = true,
        -- cache highlights and colors for faster startup.
        -- see Cache section for more details.
        cache = false,

        styles = {
          -- style for comments
          comment = { italic = true },
          -- style for functions
          functions = { italic = false },
          -- style for keywords
          keyword = { italic = false, bold = false },
          -- style for statements
          statement = { italic = false, bold = false },
          -- style for types
          type = { italic = false },
        },
        -- override default palette and theme colors
        colors = {
          palette = {},
          theme = {
            ink = {},
            canvas = {},
          },
        },
        -- adjust overall color balance for each theme [-1, 1]
        color_offset = {
          ink = { brightness = 1, saturation = 1 },
          canvas = { brightness = 0, saturation = 0 },
        },
        -- override highlight groups
        overrides = function(colors)
          return {
            -- example:
            -- popup menu
            Pmenu = { bg = "none" },
            PmenuSbar = { bg = 'none' },
            PmenuThumb = { bg = 'none' },

            -- floating windows
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            BlinkCmpMenuBorder = { bg = "none" },
            BlinkCmpMenu = { bg = "none" },
            BlinkCmpMenuSelection = { bg = "none" },
          }
        end,

        -- uses lazy.nvim, if installed, to automatically enable needed plugins
        auto_plugins = true,
        -- enable highlights for all plugins (disabled if using lazy.nvim)
        all_plugins = package.loaded.lazy == nil,
        -- manually enable/disable individual plugins.
        -- check the `groups/plugins` directory for the exact names
        plugins = {
          -- examples:
          -- rainbow_delimiters = true
          -- which_key = false
        },

        -- enable integrations with other applications
        integrations = {
          -- automatically set wezterm theme to match the current neovim theme
          wezterm = {
            enabled = true,
            -- neovim will write the theme name to this file
            -- wezterm will read from this file to know which theme to use
            path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme",
          },
        },
      })
      vim.cmd.colorscheme("kanagawa-paper-ink")
    end
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("kanagawa").setup({
        transparent = true,
        theme = "dragon",
        -- transparent bg gutter
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          local palette = colors.palette
          return {
            -- popup menu
            Pmenu = { bg = "none" },
            PmenuSbar = { bg = 'none' },
            PmenuThumb = { bg = 'none' },

            -- floating windows
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            BlinkCmpMenuBorder = { bg = "none" },
            BlinkCmpMenu = { bg = "none" },
            BlinkCmpMenuSelection = { bg = "none" },
          }
        end,
      })
      vim.cmd.colorscheme("kanagawa")
    end,
  },

  {
    "rose-pine/neovim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon",      -- auto, main, moon, or dawn
        dark_variant = "moon", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },

        -- Change specific vim highlight groups
        -- https://github.com/rose-pine/neovim/wiki/Recipes
        highlight_groups = {
          -- numbers
          CursorLineNr = { fg = "gold" },

          -- trouble
          TroubleNormal = { bg = "none" },
          TroubleCount = { bg = "none" },

          -- diffview
          DiffText = { bg = "text" },
          DiffChanged = { bg = "none", fg = "rose" },
          DiffAdded = { bg = "none", fg = "foam" },
          DiffRemoved = { bg = "none", fg = "love" },
        },
      })

      -- Set colorscheme after options
      vim.cmd("colorscheme rose-pine")
    end,
  },

  {
    "catppuccin/nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",             -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          indent_blankline = {
            enabled = false,
            scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false,
          },
          markdown = true,
          mason = true,
          neotest = true,
          dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          semantic_tokens = true,
          rainbow_delimiters = true,
          lsp_trouble = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
