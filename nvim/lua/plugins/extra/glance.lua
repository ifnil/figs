return {
	{
		"dnlhc/glance.nvim",
		config = function()
			require("glance").setup({
				-- Configuration options
			})
			-- Map keys to glance actions
			vim.keymap.set("n", "gD", "<cmd>Glance definitions<CR>")
			vim.keymap.set("n", "gY", "<cmd>Glance type_definitions<CR>")
		end,
	},
	{
		"rmagatti/goto-preview",
		dependencies = { "rmagatti/logger.nvim" },
		event = "BufEnter",
		config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
	},
}
