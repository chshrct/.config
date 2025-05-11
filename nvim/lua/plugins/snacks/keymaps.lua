local M

M = {
  { "<leader>x",  function() Snacks.explorer() end,                                       desc = "file e[x]plorer" },
  { "<leader>bd", function() Snacks.bufdelete() end,                                      desc = "[b]uffer [d]elete", },
  { "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "next reference",              mode = { "n", "t" }, },
  { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "prev reference",              mode = { "n", "t" }, },
  { "<leader>z",  function() Snacks.zen() end,                                            desc = "toggle [z]en mode", },
  { "<leader>Z",  function() Snacks.zen.zoom() end,                                       desc = "toggle [Z]oom", },
  { "<leader>lR", function() Snacks.rename.rename_file() end,                             desc = "[R]ename file", },
  { "<leader>n",  function() Snacks.scratch() end,                                        desc = "[n]otes", },
  { "<leader>sn", function() Snacks.scratch.select() end,                                 desc = "[s]earch [n]otes", },

  -- picker
  { "<leader>sb", function() Snacks.picker.buffers() end,                                 desc = "[s]earch [b]uffers" },
  { "<leader>ss", function() Snacks.picker.grep() end,                                    desc = "[s]earch [s]tring" },
  { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "[s]earch [w]ord",             mode = { "n", "x" } },
  { "<leader>sc", function() Snacks.picker.commands() end,                                desc = "[s]earch [c]ommands" },
  { "<leader>s:", function() Snacks.picker.command_history() end,                         desc = "[s]earch [:] command history" },
  { "<leader>sv", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[s]earch neo[v]im config" },
  { "<leader>sf", function() Snacks.picker.files() end,                                   desc = "[s]earch [f]iles" },
  { "<leader>sg", function() Snacks.picker.git_files() end,                               desc = "[s]earch [g]it files" },
  { "<leader>sr", function() Snacks.picker.recent() end,                                  desc = "[s]earch [r]ecent" },
  { '<leader>s"', function() Snacks.picker.registers() end,                               desc = "[s]earch \" registers" },
  { "<leader>sa", function() Snacks.picker.autocmds() end,                                desc = "[s]earch [a]utocommands" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "[s]earch [d]iagnostics" },
  { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "[s]earch [h]elp" },
  { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "[s]earch [H]ighlights" },
  { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "[s]earch [j]umps" },
  { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "[s]earch [k]eymaps" },
  { "<leader>sl", function() Snacks.picker.loclist() end,                                 desc = "[s]earch [l]ocation list" },
  { "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "[s]earch [m]arks" },
  { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "[s]earch [M]an pages" },
  { "<leader>sR", function() Snacks.picker.resume() end,                                  desc = "[s]earch [r]esume" },
  { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "[s]earch [q]uickfix list" },
  -- git
  { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "[g]it [s]tatus" },
  -- Grep
  { "<leader>/",  function() Snacks.picker.lines() end,                                   desc = "[s]earch current buffer" },
  { "<leader>?",  function() Snacks.picker.grep_buffers() end,                            desc = "[s]earch opened buffers" },

  -- LSP
  -- { "gd",          function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
  -- { "gr",          function() Snacks.picker.lsp_references() end,                          nowait = true,                        desc = "References" },
  -- { "gI",          function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
  -- { "gy",          function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  -- { "<leader>sls", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
}

return M
