return {
	{ "mgutz/gosu-colors" },
	{
		"sharpchen/Eva-Theme.nvim",
		lazy = false,
		priority = 1000,
		build = ":EvaCompile",
	},
	{
		"Skardyy/makurai-nvim",
		config = function()
			-- you don't have to call setup
			require("makurai").setup({
				transparent = false, -- removes the bg color
			})

			vim.cmd.colorscheme("makurai_dark")
		end,
	},
	{ "schickele/vim-fruchtig" },
	{
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

			on_highlights = function(hl)
				hl.NormalFloat = { bg = "#000000" }
			end,
		},
	},
}
