require('gitsigns').setup({
	signs = {
		add = { text = '▎' },
		change = { text = '▎' },
		delete = { text = '' },
		topdelete = { text = '' },
		changedelete = { text = '▎' },
		untracked = { text = '▎' },
	},
	signs_staged = {
		add = { text = '▎' },
		change = { text = '▎' },
		delete = { text = '' },
		topdelete = { text = '' },
		changedelete = { text = '▎' },
	},
	on_attach = function(_)
		require('plugins.git.keymaps').gitsigns()
	end,
})

require('git-conflict').setup()
