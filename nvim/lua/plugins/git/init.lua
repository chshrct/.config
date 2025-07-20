vim.pack.add({
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	{
		src = 'https://github.com/akinsho/git-conflict.nvim',
	},
})

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
