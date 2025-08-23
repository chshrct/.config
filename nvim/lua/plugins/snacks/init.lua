require('snacks').setup({
	bigfile = {},
	quickfile = {},
	statuscolumn = {},
	explorer = {},
	words = {},
	indent = { enabled = false },
	scroll = { enabled = false },
	notifier = { enabled = false },
	input = {},
	scratch = {
		name = 'Notes',
		ft = 'markdown',
	},
	picker = {
		sources = {
			explorer = {
				layout = {
					layout = {
						position = 'right',
					},
				},
			},
		},
	},
})

require('plugins.snacks.keymaps')
