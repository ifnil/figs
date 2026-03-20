return {
	"folke/snacks.nvim",
	opts = {
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = false },
		picker = { enabled = true },
		words = { enabled = true },
		explorer = { enabled = true },
		toggle = {
			wk_desc = {
				enabled = "disable ",
				disabled = "enable ",
			},
		},
		image = {
			enabled = true,
			resolve = function(path, src)
				local api = require("obsidian.api")
				if api.path_is_note(path) then
					return api.resolve_attachment_path(src)
				end
			end,
		},
	},
}
