local wk = require("which-key")

wk.add({
	{ "<leader>t", group = "todo" },
	{ "<leader>ta", "<cmd>Trouble todo<cr>", desc = "list todos" },
})
