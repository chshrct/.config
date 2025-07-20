vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

require('nvim-treesitter.configs').setup({
	auto_install = true,
	highlight = { enable = true, use_languagetree = true },
	indent = { enable = true },
	ignore_install = { 'help' },
	ensure_installed = {
		'lua',
		'luadoc',
		'html',
		'markdown',
		'markdown_inline',
		'regex',
		'vim',
		'vimdoc',
		'bash',
		'diff',
		'json',
		'toml',
		'yaml',
		'comment',
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<leader>v',
			node_incremental = '<leader>v',
			scope_incremental = '<nop>',
			node_decremental = '<leader>V',
		},
	},
})
