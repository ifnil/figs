return {
	{ "nvim-mini/mini.nvim", version = false },
	{ "nvim-mini/mini.pairs", opts = {} },
	{
		"nvim-mini/mini.surround",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		},
	},
	{ "nvim-mini/mini.ai", opts = {} },
	{ "nvim-mini/mini.move", opts = {} },
	{ "nvim-mini/mini.comment", opts = {} },
	{ "nvim-mini/mini.align", opts = {} },
	{ "nvim-mini/mini.pick", opts = {} },
	{
		"nvim-mini/mini.indentscope",
		opts = {},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"Trouble",
					"alpha",
					"dashboard",
					"fzf",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"notify",
					"sidekick_terminal",
					"snacks_dashboard",
					"snacks_notif",
					"snacks_terminal",
					"snacks_win",
					"toggleterm",
					"trouble",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "SnacksDashboardOpened",
				callback = function(data)
					vim.b[data.buf].miniindentscope_disable = true
				end,
			})
		end,
	},
}
