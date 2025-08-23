if vim.loader and vim.loader.enable then
	vim.loader.enable()
end

require('plugins.spec')
require('autocmds')
require('keymaps')
require('options')
require('plugins')
require('lsp')
