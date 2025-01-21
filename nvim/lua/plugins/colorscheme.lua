return {
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
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
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "None", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- floating windows
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = "none", fg = theme.ui.fg_dim },
            MasonNormal = { bg = "none", fg = theme.ui.fg_dim },
          }
        end,
      })
      vim.cmd.colorscheme("kanagawa")
    end,
  },

  {
    "rose-pine/neovim",
    enabled = true,
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
