return {
	{
		"ifnil/gum",
		lazy = false,
		-- dev = true,
		priority = 1000,
		opts = {
			transparent = false,
			terminal = true,
		},
	},
	{ "mgutz/gosu-colors" },
	{ "AlessandroYorba/Sierra" },
	{ "schickele/vim-fruchtig" },
	{ "daschw/leaf.nvim" },
	{
		"Skardyy/makurai-nvim",
		config = function()
			require("makurai").setup({
				transparent = false, -- removes the bg color
			})
			vim.cmd.colorscheme("makurai_dark")
		end,
	},
	{
		"jpwol/thorn.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = nil,
			background = "cold",
			transparent = false,
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
