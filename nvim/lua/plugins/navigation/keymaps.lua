vim.keymap.set('n', '<leader>m', function()
	require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
end)

local harpoon = require('harpoon')
vim.keymap.set('n', '<leader>ha', function()
	harpoon:list():add()
end)
vim.keymap.set('n', '<leader>hl', function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
	vim.keymap.set('n', string.format('<space>%d', idx), function()
		harpoon:list():select(idx)
	end)
end
