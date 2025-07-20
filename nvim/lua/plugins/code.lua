vim.pack.add({
	{
		src = 'https://github.com/windwp/nvim-autopairs',
	},
	{
		src = 'https://github.com/windwp/nvim-ts-autotag',
	},
	{
		src = 'https://github.com/hiphish/rainbow-delimiters.nvim',
	},
})

require('nvim-autopairs').setup()
require('nvim-ts-autotag').setup()
require('rainbow-delimiters.setup').setup()
