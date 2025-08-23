require('lsp.completion')
-- plugins declared in plugins/spec.lua

local ok_mason, mason = pcall(require, 'mason')
if ok_mason then mason.setup() end

local capabilities = {}
local ok_blink, blink = pcall(require, 'blink.cmp')
if ok_blink then
	capabilities = blink.get_lsp_capabilities()
end

local servers = require('lsp.servers')

local server_names = vim.tbl_keys(servers or {})

for server_name, _ in pairs(servers) do
	local server = servers[server_name] or {}
	server.capabilities =
		vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
	vim.lsp.config(server_name, server or {})
end

local ok_mason_lsp, mason_lsp = pcall(require, 'mason-lspconfig')
if ok_mason_lsp then
	mason_lsp.setup({
		ensure_installed = server_names,
	})
end

local ok_mason_tools, mason_tools = pcall(require, 'mason-tool-installer')
if ok_mason_tools then
	mason_tools.setup({ ensure_installed = server_names })
end

pcall(function() require('fidget').setup() end)
pcall(function() require('nvim-lightbulb').setup({
	autocmd = { enabled = true },
	sign = { enabled = false },
	virtual_text = {
		enabled = true,
	},
}) end)

require('lsp.format')
require('lsp.lint')

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
	callback = require('lsp.keymaps')
})
