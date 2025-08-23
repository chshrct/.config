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

vim.api.nvim_create_autocmd('User', {
	pattern = 'MiniFilesActionRename',
	callback = function(event)
		local Snacks = require('snacks')
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

local harpoon = require('harpoon')
harpoon:setup()

require('plugins.navigation.keymaps')
