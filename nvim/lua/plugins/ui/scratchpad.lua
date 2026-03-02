return {
	"athar-qadri/scratchpad.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local scratchpad = require("scratchpad")
		scratchpad:setup({ settings = { sync_on_ui_close = true } })
	end,
}
