return {
	{ "nvim-mini/mini.nvim", version = false },
	{ "nvim-mini/mini.pairs", opts = {} },
	{ "nvim-mini/mini.surround", opts = {} },
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
