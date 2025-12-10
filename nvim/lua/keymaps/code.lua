local wk = require("which-key")

-- code group
wk.add({
	{ "<leader>c", group = "code" },
	{ "<leader>cs", "<cmd>Trouble symbols<cr>", desc = "symbols" },
})
