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

  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
      exclude = {
        filetypes = { "lazy" },
      },
      scope = {
        enabled = false,
      },
    },
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

  -- context
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = function()
        vim.keymap.set("n", "<leader>cf", function()
          require("treesitter-context").go_to_context()
        end, { silent = true, desc = "[c]ontext [f]ocus" })
        vim.keymap.set("n", "<leader>ct", function()
          require("treesitter-context").toggle()
        end, { silent = true, desc = "[c]ontext [t]oggle" })
      end, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },

  -- markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = "markdown",
    opts = {},
  },
}
