return {

  -- neotree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = require("plugins.navigation.keymaps").nvimtree,
    opts = {
      filters = {
        dotfiles = false,
        exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        adaptive_size = true,
        side = "right",
        width = 40,
        preserve_window_proportions = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = "none",
        highlight_opened_files = "none",

        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = "after",
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
          },
          glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
            },
          },
        },
      },
    },
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = require("plugins.navigation.keymaps").telescope,
    opts = function()
      local actions = require("telescope.actions")
      local telescopeConfig = require("telescope.config")
      local vimgrep_arguments =
        { unpack(telescopeConfig.values.vimgrep_arguments) }
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      local trouble = require("trouble.providers.telescope")

      return {
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--no-ignore",
              "--glob",
              "!**/.git/*",
            },
          },
          buffers = {
            mappings = {
              n = {
                ["<C-d>"] = actions.delete_buffer,
              },
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
            },
          },
        },
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
          path_display = { "truncate" },
          prompt_prefix = "   ",
          selection_caret = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
            },
          },
          file_ignore_patterns = { "node_modules" },
          extensions = {
            fzf = {
              fuzzy = true, -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = "smart_case", -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
          preview = {
            filesize_limit = 0.3,
          },
          mappings = {
            n = {
              ["Esc"] = actions.close,
              ["<C-c>"] = actions.close,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-t>"] = trouble.smart_open_with_trouble,
            },
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-t>"] = trouble.smart_open_with_trouble,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
  },
}
