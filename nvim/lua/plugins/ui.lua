require('lualine').setup {
	options = {
		globalstatus = true,
		icons_enabled = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",
				symbols = {
					added = require("icons").git.LineAdded .. " ",
					modified = require("icons").git.LineModified .. " ",
					removed = require("icons").git.LineRemoved .. " ",
				},
			},
			{

				"diagnostics",
				symbols = {
					error = require("icons").diagnostics.Error,
					warn = require("icons").diagnostics.Warn,
					info = require("icons").diagnostics.Info,
					hint = require("icons").diagnostics.Hint,
				},
			},
		},
		lualine_c = {
			{
				"filetype",
				icon_only = true,
				separator = "",
				padding = { left = 1, right = 0 },
			},
			{
				"filename",
				path = 1,
				symbols = { modified = "  ", readonly = "", unnamed = "" },
			},
		},
		lualine_x = {
			"encoding",
		},
		lualine_y = {
			{
				"progress",
			},
		},
	},
	extensions = { "quickfix" },
}
