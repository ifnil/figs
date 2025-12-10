return {
	"jpwol/thorn.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		theme = nil,
		background = "cold",
		transparent = true,
		terminal = true,

		styles = {
			keywords = { italic = true, bold = false },
			comments = { italic = true, bold = false },
			strings = { italic = true, bold = false },

			diagnostic = {
				underline = true,
				error = { highlight = true },
				hint = { highlight = false },
				info = { highlight = false },
				warn = { highlight = false },
			},
		},
	},
}
