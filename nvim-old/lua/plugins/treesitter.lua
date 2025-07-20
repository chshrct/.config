return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = {
      { "<leader>v", desc = "Increment selection" },
      { "<leader>V", desc = "Schrink selection",  mode = "x" },
    },
    opts = {
      auto_install = true,
      highlight = { enable = true, use_languagetree = true },
      indent = { enable = true },
      ignore_install = { "help" },
      ensure_installed = {
        "lua",
        "luadoc",
        "html",
        "markdown",
        "markdown_inline",
        "regex",
        "vim",
        "vimdoc",
        "bash",
        "diff",
        "json",
        "toml",
        "yaml",
        "comment",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>v",
          node_incremental = "<leader>v",
          scope_incremental = "<nop>",
          node_decremental = "<leader>V",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
