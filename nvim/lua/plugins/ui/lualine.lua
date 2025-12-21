local colors = _G.theme.colors

local custom_theme = {
	normal = {
		a = { bg = colors.black, fg = colors.green, gui = "bold" },
		b = { bg = colors.black, fg = colors.green },
		c = { bg = colors.black, fg = colors.gray },
	},
	insert = {
		a = { bg = colors.black, fg = colors.blue, gui = "bold" },
		b = { bg = colors.black, fg = colors.blue },
		c = { bg = colors.black, fg = colors.gray },
	},
	visual = {
		a = { bg = colors.pink, fg = colors.black, gui = "bold" },
		b = { bg = colors.black, fg = colors.pink },
		c = { bg = colors.black, fg = colors.gray },
	},
	replace = {
		a = { bg = colors.red, fg = colors.black, gui = "bold" },
		b = { bg = colors.black, fg = colors.red },
		c = { bg = colors.black, fg = colors.gray },
	},
	command = {
		a = { bg = colors.orange, fg = colors.black, gui = "bold" },
		b = { bg = colors.black, fg = colors.orange },
		c = { bg = colors.black, fg = colors.gray },
	},
	inactive = {
		a = { bg = colors.black, fg = colors.dark },
		b = { bg = colors.black, fg = colors.dark },
		c = { bg = colors.black, fg = colors.dark },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {

		sections = {
			lualine_x = {
				{
					require("noice").api.status.command.get,
					cond = require("noice").api.status.command.has,
					color = { fg = "#ff9e64" },
				},
				{
					require("noice").api.status.mode.get,
					cond = require("noice").api.status.mode.has,
					color = { fg = "#ff9e64" },
				},
				{
					require("noice").api.status.search.get,
					cond = require("noice").api.status.search.has,
					color = { fg = "#ff9e64" },
				},
			},
		},
		options = {
			theme = custom_theme,
		},
	},
}
