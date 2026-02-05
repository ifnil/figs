local colors = vim.g.mein_theme

local custom_theme = {
	normal = {
		a = { bg = colors.bg, fg = colors.green, gui = "italic" },
		b = { bg = colors.bg, fg = colors.green },
		c = { bg = colors.bg, fg = colors.gray },
	},
	insert = {
		a = { bg = colors.bg, fg = colors.blue, gui = "italic" },
		b = { bg = colors.bg, fg = colors.blue },
		c = { bg = colors.bg, fg = colors.gray },
	},
	visual = {
		a = { bg = colors.bg, fg = colors.pink, gui = "italic" },
		b = { bg = colors.bg, fg = colors.pink },
		c = { bg = colors.bg, fg = colors.gray },
	},
	replace = {
		a = { bg = colors.bg, fg = colors.red, gui = "italic" },
		b = { bg = colors.bg, fg = colors.red },
		c = { bg = colors.bg, fg = colors.gray },
	},
	command = {
		a = { bg = colors.bg, fg = colors.orange, gui = "italic" },
		b = { bg = colors.bg, fg = colors.orange },
		c = { bg = colors.bg, fg = colors.gray },
	},
	inactive = {
		a = { bg = colors.bg, fg = colors.dark },
		b = { bg = colors.bg, fg = colors.dark },
		c = { bg = colors.bg, fg = colors.dark },
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
					color = { bg = colors.bg, fg = "#ff9e64" },
				},
				{
					require("noice").api.status.mode.get,
					cond = require("noice").api.status.mode.has,
					color = { bg = colors.bg, fg = "#ff9e64" },
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
