vim.pack.add{ 'https://github.com/folke/snacks.nvim' }

require('snacks').setup({
	bigfile = {},
	quickfile = {},
	statuscolumn = {},
	explorer = {},
	words = {},
	indent = { enabled = false },
	scroll = { enabled = false },
	notifier = { enabled = false },
	input = {},
	scratch = {
		name = 'Notes',
		ft = 'markdown',
	},
	picker = {
		sources = {
			explorer = {
				layout = {
					layout = {
						position = 'right',
					},
				},
			},
		},
	},
})
_G.Snacks = require('snacks')

-- core
vim.keymap.set('n', '<leader>x', function() Snacks.explorer() end, { desc = 'file e[x]plorer' })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[b]uffer [d]elete' })
vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'next reference' })
vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'prev reference' })
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'toggle [z]en mode' })
vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'toggle [Z]oom' })
vim.keymap.set('n', '<leader>lR', function() Snacks.rename.rename_file() end, { desc = '[R]ename file' })
vim.keymap.set('n', '<leader>n', function() Snacks.scratch() end, { desc = '[n]otes' })
vim.keymap.set('n', '<leader>sn', function() Snacks.scratch.select() end, { desc = '[s]earch [n]otes' })

-- picker
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.buffers() end, { desc = '[s]earch [b]uffers' })
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.grep() end, { desc = '[s]earch [s]tring' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = '[s]earch [w]ord' })
vim.keymap.set('n', '<leader>sc', function() Snacks.picker.commands() end, { desc = '[s]earch [c]ommands' })
vim.keymap.set('n', '<leader>s:', function() Snacks.picker.command_history() end, { desc = '[s]earch [:] command history' })
vim.keymap.set('n', '<leader>sv', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, { desc = '[s]earch neo[v]im config' })
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.git_files() end, { desc = '[s]earch [g]it files' })
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.recent() end, { desc = '[s]earch [r]ecent' })
vim.keymap.set('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = '[s]earch " registers' })
vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = '[s]earch [a]utocommands' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = '[s]earch [H]ighlights' })
vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = '[s]earch [j]umps' })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[s]earch [k]eymaps' })
vim.keymap.set('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = '[s]earch [l]ocation list' })
vim.keymap.set('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = '[s]earch [m]arks' })
vim.keymap.set('n', '<leader>sM', function() Snacks.picker.man() end, { desc = '[s]earch [M]an pages' })
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = '[s]earch [r]esume' })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = '[s]earch [q]uickfix list' })

-- git
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = '[g]it [s]tatus' })

-- Grep
vim.keymap.set('n', '<leader>/', function() Snacks.picker.lines() end, { desc = '[s]earch current buffer' })
vim.keymap.set('n', '<leader>?', function() Snacks.picker.grep_buffers() end, { desc = '[s]earch opened buffers' })
