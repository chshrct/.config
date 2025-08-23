-- plugin declared in plugins/spec.lua

require('conform').setup({
	formatters_by_ft = {
		go = { 'goimports', 'gofmt' },
		cs = { 'csharpier' },
		-- javascript = { 'prettier', 'eslint' },
		-- typescript = { 'prettier', 'eslint' },
		-- javascriptreact = { 'prettier', 'eslint' },
		-- typescriptreact = { 'prettier', 'eslint' },
		-- svelte = { 'prettier' },
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

-- keymap moved to lsp/keymaps.lua
