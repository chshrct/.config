vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require('conform').setup({
	formatters_by_ft = {
		go = { 'goimports', 'gofmt' },
		cs = { 'csharpier' },
		javascript = { 'prettier', 'eslint' },
		typescript = { 'prettier', 'eslint' },
		javascriptreact = { 'prettier', 'eslint' },
		typescriptreact = { 'prettier', 'eslint' },
		svelte = { 'prettier' },
		css = { 'prettier' },
		html = { 'prettier' },
		json = { 'prettier' },
		yaml = { 'prettier' },
		markdown = { 'prettier' },
		graphql = { 'prettier' },
		lua = { 'stylua' },
	},
	formatters = {
		csharpier = {
			command = 'csharpier',
			args = { 'format', '--write-stdout' },
		},
	},
})

vim.keymap.set('n', '<leader>lf', function()
	require('conform').format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = '[l]sp: [f]ormat' })
