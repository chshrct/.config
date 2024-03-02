return {

  -- neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = require("plugins.navigation.keymaps").neotree,
    opts = {
      popup_border_style = "rounded",
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      window = {
        position = "right",
        width = 50,
        mappings = {
          ["<space>"] = false,
          ["o"] = "open",
          ["h"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(
                state,
                node
              )
            else
              require("neo-tree.ui.renderer").focus_node(
                state,
                node:get_parent_id()
              )
            end
          end,
          ["l"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              if not node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(
                  state,
                  node
                )
              elseif node:has_children() then
                require("neo-tree.ui.renderer").focus_node(
                  state,
                  node:get_child_ids()[1]
                )
              end
            end
          end,
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
        },
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        window = {
          mappings = {
            ["~"] = {
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
            },
          },
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        window = {
          mappings = {
            ["~"] = {
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
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
