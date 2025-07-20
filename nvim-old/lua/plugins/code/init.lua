return {
  -- autotag
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
  },

  -- autopairs
  {
    "echasnovski/mini.pairs",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },

  -- rainbow brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  },

  -- comments
  {
    "folke/ts-comments.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
  },

  -- surround
  {
    "echasnovski/mini.surround",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    version = false,
    opts = {},
  },

  -- markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "markdown",
    opts = {
      code = {
        disable_background = true,
        border = "none",
      },
    },
  },

  {
    'lbrayner/vim-rzip', -- GitHub plugin specifier
  }
}
