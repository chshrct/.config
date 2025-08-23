-- plugin declared in plugins/spec.lua

require('blink.cmp').setup({
	keymap = {
		preset = 'super-tab',
		['<CR>'] = { 'select_and_accept', 'fallback' },
		['<C-y>'] = { 'select_and_accept', 'fallback' },
		['<C-k>'] = { 'select_prev', 'fallback' },
		['<C-j>'] = { 'select_next', 'fallback' },
	},
	cmdline = {
		keymap = {
			preset = 'enter',
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },
		},
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
			menu = {
				auto_show = true,
			},
		},
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = 'normal',
	},
	sources = {
		default = { 'lsp', 'path', 'buffer' },
	},
	signature = {
		enabled = true,
		window = {
			border = 'rounded',
		},
	},
	completion = {
		-- ghost_text = {
		--   enabled = true,
		-- },
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			border = 'rounded',
			draw = {
				treesitter = { 'lsp' },
				components = {
					kind_icon = {
						ellipsis = false,
						text = function(ctx)
							local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
							return kind_icon
						end,
					},
				},
			},
			-- auto_show = function(ctx)
			--   return ctx.mode == "cmdline" and true or false
			-- end,
		},
		documentation = {
			window = {
				border = 'rounded',
			},
		},
		list = {
			selection = {
				preselect = function(ctx)
					return ctx.mode ~= 'cmdline'
				end,
				auto_insert = true,
			},
		},
	},
})
