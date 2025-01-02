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

      -- Set <space>1..<space>5 be my shortcuts to moving to the files
      for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
        vim.keymap.set("n", string.format("<space>%d", idx), function()
          harpoon:list():select(idx)
        end)
      end
    end,
  },
}
