-- plugin declared in plugins/spec.lua

local lint = require('lint')

lint.linters_by_ft = {
	lua = { 'selene' },
}

local aug = vim.api.nvim_create_augroup('NvimLint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
	group = aug,
	callback = function()
		lint.try_lint()
	end,
})

-- keymap moved to lsp/keymaps.lua
