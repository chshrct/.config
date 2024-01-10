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

            -- telescope
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = "none" },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
            TelescopeResultsBorder = { fg = theme.ui.bg_p1, bg = "none" },
            TelescopePreviewNormal = { bg = "none" },
            TelescopePreviewBorder = {
              bg = "none",
              fg = theme.ui.bg_p1,
            },

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

            -- treesitter context
            TreesitterContext = { bg = "none" },
            TreesitterContextLineNumber = { fg = palette.dragonAqua },
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
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "moon", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          headings = {
            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
          },
          -- Alternatively, set all headings at once.
          -- headings = "subtle",
        },
        -- Change specific vim highlight groups
        -- https://github.com/rose-pine/neovim/wiki/Recipes
        highlight_groups = {
          Directory = { fg = "foam", bg = "none" },
          WinSeparator = { fg = "highlight_high", bg = "none" },

          -- gitsigns
          GitSignsDelete = { fg = "love", bg = "none" },
          GitSignsChange = { fg = "gold", bg = "none" },
          GitSignsAdd = { fg = "foam", bg = "none" },

          -- telescope
          TelescopeTitle = { fg = "foam", bg = "none" },
          TelescopeBorder = { fg = "highlight_high", bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopePromptNormal = { bg = "none" },
          TelescopeResultsNormal = { fg = "subtle", bg = "none" },
          TelescopeSelection = { fg = "text", bg = "base" },
          TelescopePromptPrefix = { fg = "rose" },
          TelescopeSelectionCaret = { fg = "rose", bg = "none" },
          NoiceCmdlinePopupBorder = { fg = "highlight_high", bg = "none" },

          -- numbers
          CursorLineNr = { fg = "gold" },

          -- treesitter context
          TreesitterContext = { bg = "none" },
          TreesitterContextLineNumber = { fg = "iris" },

          -- noice
          NoiceCmdlineIcon = { fg = "rose", bg = "none" },
          NoiceCmdlineIconSearch = { fg = "rose", bg = "none" },
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
        flavour = "mocha", -- latte, frappe, macchiato, mocha
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
          noice = true,
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
          treesitter_context = true,
          rainbow_delimiters = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          lsp_trouble = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
