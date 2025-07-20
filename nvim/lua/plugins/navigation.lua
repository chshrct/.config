vim.pack.add({
	{
		src = 'https://github.com/echasnovski/mini.files',
	},
	{
		src = 'https://github.com/nvim-lua/plenary.nvim',
	},
	{
		src = 'https://github.com/ThePrimeagen/harpoon',
		version = 'harpoon2',
	},
})

require('mini.files').setup({
	windows = {
		preview = true,
		width_focus = 30,
		width_preview = 80,
	},
	options = {
		use_as_default_explorer = true,
	},
})

vim.keymap.set('n', '<leader>m', function()
	require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
end)

vim.api.nvim_create_autocmd('User', {
	pattern = 'MiniFilesActionRename',
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

local harpoon = require('harpoon')
harpoon:setup()

vim.keymap.set('n', '<leader>ha', function()
	harpoon:list():add()
end)
vim.keymap.set('n', '<leader>hl', function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

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
