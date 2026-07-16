return {
	{
		"danilshvalov/org-modern.nvim",
		dependencies = { "nvim-orgmode/orgmode" },
	},
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			local Menu = require("org-modern.menu")

			require("orgmode").setup({
				org_agenda_files = "~/org/**/*",
				org_default_notes_file = "~/org/refile.org",
				org_hide_leading_stars = true,
				ui = {
					menu = {
						handler = function(data)
							Menu:new({
								window = {
									margin = { 1, 0, 1, 0 },
									padding = { 0, 1, 0, 1 },
									title_pos = "center",
									border = "single",
									zindex = 1000,
								},
								icons = { separator = "➜" },
							}):open(data)
						end,
					},
				},
			})

			vim.lsp.enable("org")
		end,
	},
}
