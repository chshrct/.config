require('kanagawa-paper').setup({
	undercurl = true,
	transparent = true,
	gutter = false,
	diag_background = true,
	dim_inactive = true,
	terminal_colors = true,
	cache = false,

	styles = {
		comment = { italic = true },
		functions = { italic = false },
		keyword = { italic = false, bold = false },
		statement = { italic = false, bold = false },
		type = { italic = false },
	},
	colors = {
		palette = {},
		theme = {
			ink = {},
			canvas = {},
		},
	},
	color_offset = {
		ink = { brightness = 1, saturation = 1 },
		canvas = { brightness = 0, saturation = 0 },
	},
	overrides = function()
		return {
			-- example:
			-- popup menu
			Pmenu = { bg = 'none' },
			PmenuSbar = { bg = 'none' },
			PmenuThumb = { bg = 'none' },

			-- floating windows
			NormalFloat = { bg = 'none' },
			FloatBorder = { bg = 'none' },
			FloatTitle = { bg = 'none' },
			BlinkCmpMenuBorder = { bg = 'none' },
			BlinkCmpMenu = { bg = 'none' },
			BlinkCmpMenuSelection = { bg = 'none' },
		}
	end,

	auto_plugins = true,
	all_plugins = package.loaded.lazy == nil,
	plugins = {
		-- examples:
		-- rainbow_delimiters = true
		-- which_key = false
	},
})

package.preload['nvim-web-devicons'] = function()
	require('mini.icons').mock_nvim_web_devicons()
	return package.loaded['nvim-web-devicons']
end

vim.cmd.colorscheme('kanagawa-paper-ink')
