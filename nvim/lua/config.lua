-- disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.markdown_recommended_style = 0

local o = vim.opt

o.swapfile = false
o.autowrite = true -- Enable auto write
o.clipboard = 'unnamedplus' -- Sync with system clipboard
o.completeopt = 'menu,menuone,noselect'
o.conceallevel = 3 -- Hide * markup for bold and italic
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.cursorline = true -- Enable highlighting of the current line
o.expandtab = false -- Use tabs instead of spaces
o.formatoptions = 'jcroqlnt' -- tcqj
o.grepformat = '%f:%l:%c:%m'
o.grepprg = 'rg --vimgrep'
o.ignorecase = true -- Ignore case
o.inccommand = 'nosplit' -- preview incremental substitute
o.laststatus = 3
o.list = true -- Show some invisible characters (tabs...
o.mouse = 'a' -- Enable mouse mode
o.number = true -- Print line number
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.relativenumber = true -- Relative line numbers
o.scrolloff = 4 -- Lines of context
o.sidescrolloff = 8 -- Columns of context
o.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
o.shiftwidth = 0 -- Size of an indent
o.shortmess:append({ W = true, I = true, c = true })
o.showmode = false -- Dont show mode since we have a statusline
o.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
o.smartcase = true -- Don't ignore case with capitals
o.smartindent = true -- Insert indents automatically
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.tabstop = 4 -- Number of spaces a <Tab> in the file counts for
o.termguicolors = true -- True color support
o.timeoutlen = 300
o.undofile = true
o.undolevels = 10000
o.wildmode = 'longest:full,full' -- Command-line completion mode
o.winminwidth = 5 -- Minimum window width
o.wrap = false -- Disable line wrap
o.incsearch = true -- Highlight search on type
o.colorcolumn = '80' -- Indent for code length
o.listchars:append({ eol = '↵', tab = '  ' }) -- Show EOL, render tabs as spaces
o.smoothscroll = true -- Smooth scroll
o.guicursor = 'a:block-blinkon0-blinkoff0-reverse'

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = 'if_many',
		prefix = '●',
		severity_sort = true,
	},
	float = {
		severity_sort = true,
		source = 'if_many',
		border = 'rounded',
	},
	severity_sort = true,
	underline = true,
	virtual_lines = false,
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = require('icons').diagnostics.Error,
			[vim.diagnostic.severity.WARN] = require('icons').diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = require('icons').diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = require('icons').diagnostics.Info,
		},
	},
})
