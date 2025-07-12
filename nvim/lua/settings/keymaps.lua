-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- better up/down
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
vim.keymap.set(
  "n",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP')

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- move lines
vim.keymap.set(
  "n",
  "<A-j>",
  "<cmd>m .+1<cr>==",
  { desc = "Move line down", silent = true }
)
vim.keymap.set(
  "n",
  "<A-k>",
  "<cmd>m .-2<cr>==",
  { desc = "Move line up", silent = true }
)
vim.keymap.set(
  "i",
  "<A-j>",
  "<esc><cmd>m .+1<cr>==gi",
  { desc = "Move line down", silent = true }
)
vim.keymap.set(
  "i",
  "<A-k>",
  "<esc><cmd>m .-2<cr>==gi",
  { desc = "Move line up", silent = true }
)
vim.keymap.set(
  "v",
  "<A-j>",
  ":m '>+1<cr>gv=gv",
  { desc = "Move line down", silent = true }
)
vim.keymap.set(
  "v",
  "<A-k>",
  ":m '<-2<cr>gv=gv",
  { desc = "Move line up", silent = true }
)

-- keep cursor after concat lines
vim.keymap.set("n", "J", "mzJ`z")

-- vertical center movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Insert blank line
vim.keymap.set(
  "n",
  "]<leader>",
  "o<Esc>k",
  { desc = "Insert blank line bottom" }
)
vim.keymap.set("n", "[<leader>", "O<Esc>j", { desc = "Insert blank line top" })

-- Resize window using <shift> arrow keys
vim.keymap.set(
  "n",
  "<S-Up>",
  "<cmd>resize +2<CR>",
  { desc = "Increase window vertically", silent = true }
)
vim.keymap.set(
  "n",
  "<S-Down>",
  "<cmd>resize -2<CR>",
  { desc = "Decrease window vertically", silent = true }
)
vim.keymap.set(
  "n",
  "<S-Left>",
  "<cmd>vertical resize -2<CR>",
  { desc = "Decrease window horizontally", silent = true }
)
vim.keymap.set(
  "n",
  "<S-Right>",
  "<cmd>vertical resize +2<CR>",
  { desc = "Increase window horizontally", silent = true }
)

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- disable highlight search
vim.keymap.set("n", "<leader>th", ":nohlsearch<CR>", {
  desc = "Toggle Search Highlight",
  silent = true,
})

-- diagnostic
vim.keymap.set(
  "n",
  "[d",
  function()
    vim.diagnostic.jump({ count = -1, float = true })
  end,
  { desc = "previous [d]iagnostic message" }
)
vim.keymap.set(
  "n",
  "]d",
  function()
    vim.diagnostic.jump({ count = 1, float = true })
  end,
  { desc = "next [d]iagnostic message" }
)
vim.keymap.set(
  "n",
  "gl",
  vim.diagnostic.open_float,
  { desc = "[l]ine diagnostic" }
)
