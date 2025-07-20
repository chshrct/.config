require('lsp.completion')

vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
	{ src = 'https://github.com/b0o/SchemaStore.nvim' },
	{ src = 'https://github.com/j-hui/fidget.nvim' },
	{ src = 'https://github.com/kosayoda/nvim-lightbulb' },
	{ src = 'https://github.com/lbrayner/vim-rzip' },
})

require('mason').setup()

local capabilities = require('blink.cmp').get_lsp_capabilities()

local servers = require('lsp.servers')

local server_names = vim.tbl_keys(servers or {})

for server_name, _ in pairs(servers) do
	local server = servers[server_name] or {}
	server.capabilities =
		vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
	vim.lsp.config(server_name, server or {})
end

require('mason-lspconfig').setup({
	automatic_enable = server_names,
})

require('mason-tool-installer').setup({
	ensure_installed = server_names,
})

require('fidget').setup()
require('nvim-lightbulb').setup({
	autocmd = { enabled = true },
	sign = { enabled = false },
	virtual_text = {
		enabled = true,
	},
})

require('lsp.format')

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
	callback = function(event)
		vim.keymap.set(
			'n',
			'<leader>lr',
			vim.lsp.buf.rename,
			{ buffer = event.buf, desc = '[l]sp: [r]ename' }
		)
		vim.keymap.set(
			'n',
			'<leader>la',
			vim.lsp.buf.code_action,
			{ buffer = event.buf, desc = '[l]sp: [a]ction' }
		)
		vim.keymap.set('n', 'gd', function()
			Snacks.picker.lsp_definitions({
				layout = { preset = 'ivy_split', layout = { height = 0.2 } },
			})
		end, {
			buffer = event.buf,
			desc = 'lsp: [g]oto [d]efinition',
			silent = true,
		})
		vim.keymap.set('n', 'gr', function()
			Snacks.picker.lsp_references({
				layout = { preset = 'ivy_split', layout = { height = 0.2 } },
			})
		end, {
			buffer = event.buf,
			desc = 'lsp: [g]oto [r]eferences',
			silent = true,
		})
		vim.keymap.set(
			'n',
			'<leader>li',
			function()
				Snacks.picker.lsp_implementations({
					layout = { preset = 'ivy_split', layout = { height = 0.2 } },
				})
			end,
			{ buffer = event.buf, desc = '[l]sp: goto [i]mplementation', silent = true }
		)
		vim.keymap.set('n', '<leader>lt', function()
			Snacks.picker.lsp_type_definitions({
				layout = { preset = 'ivy_split', layout = { height = 0.2 } },
			})
		end, {
			buffer = event.buf,
			desc = '[l]sp: [t]ype definition',
			silent = true,
		})
		vim.keymap.set(
			'n',
			'<leader>ls',
			Snacks.picker.lsp_symbols,
			{ buffer = event.buf, desc = '[l]sp: document [s]ymbols', silent = true }
		)
		vim.keymap.set(
			'n',
			'<leader>lS',
			Snacks.picker.lsp_workspace_symbols,
			{ buffer = event.buf, desc = '[l]sp: workspace [S]ymbols', silent = true }
		)
		vim.keymap.set('n', 'K', function()
			vim.lsp.buf.hover({ border = 'rounded', focusable = true })
		end, { buffer = event.buf, desc = 'lsp: hover documentation' })

		-- Lesser used LSP functionality
		vim.keymap.set('n', '<leader>ld', function()
			Snacks.picker.lsp_declarations({
				layout = { preset = 'ivy_split', layout = { height = 0.2 } },
			})
		end, { buffer = event.buf, desc = '[l]sp: goto [d]eclaration' })
		vim.keymap.set(
			'n',
			'<leader>lwa',
			vim.lsp.buf.add_workspace_folder,
			{ buffer = event.buf, desc = '[l]sp: [w]orkspace [a]dd folder' }
		)
		vim.keymap.set(
			'n',
			'<leader>lwr',
			vim.lsp.buf.remove_workspace_folder,
			{ buffer = event.buf, desc = '[l]sp: [w]orkspace [r]emove folder' }
		)
		vim.keymap.set('n', '<leader>lwl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = event.buf, desc = '[l]sp: [w]orkspace [l]ist folders' })

		-- Inlay hints toggle when supported
		local function client_supports_method(client, method, buf)
			if vim.fn.has('nvim-0.11') == 1 then
				return client:supports_method(method, buf)
			else
				return client.supports_method(method, { buf = buf })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(
				client,
				vim.lsp.protocol.Methods.textDocument_inlayHint,
				event.buf
			)
		then
			vim.keymap.set('n', '<leader>lh', function()
				vim.lsp.inlay_hint.enable(
					not vim.lsp.inlay_hint.is_enabled({ buf = event.buf })
				)
			end, { buffer = event.buf, desc = 'toggle [L]sp inlay [H]ints' })
		end
	end,
})
