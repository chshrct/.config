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
        },
      },
    },
  },

  -- mini files
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
    },
    keys = require("plugins.navigation.keymaps").minifiles,
    config = function(_, opts)
      require("mini.files").setup(opts)

      local show_dotfiles = true
      local filter_show = function()
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
      end

      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window =
            require("mini.files").get_explorer_state().target_window
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require("mini.files").set_target_window(new_target_window)
            require("mini.files").go_in({ close_on_file = close_on_file })
          end
        end

        local desc = "Open in " .. direction .. " split"
        if close_on_file then
          desc = desc .. " and close"
        end
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        if cur_directory ~= nil then
          vim.fn.chdir(cur_directory)
        end
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.toggle_hidden or "g.",
            toggle_dotfiles,
            { buffer = buf_id, desc = "Toggle hidden files" }
          )

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.change_cwd or "gc",
            files_set_cwd,
            { buffer = args.data.buf_id, desc = "Set cwd" }
          )

          map_split(
            buf_id,
            opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s",
            "horizontal",
            false
          )
          map_split(
            buf_id,
            opts.mappings and opts.mappings.go_in_vertical or "<C-w>v",
            "vertical",
            false
          )
          map_split(
            buf_id,
            opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
            "horizontal",
            true
          )
          map_split(
            buf_id,
            opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V",
            "vertical",
            true
          )
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
  },

  -- fzf-lua
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = require("plugins.navigation.keymaps").fzf,
    opts = {},
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader>hl", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
        vim.keymap.set("n", string.format("<space>%d", idx), function()
          harpoon:list():select(idx)
        end)
      end
    end,
  },
}
