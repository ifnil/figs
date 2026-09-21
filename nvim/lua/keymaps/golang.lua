local wk = require("which-key")

wk.add({
	{
		"<leader>G",
		group = "golang",
		cond = function()
			return vim.bo.filetype == "go"
		end,
	},
	{ "<leader>Gi", "<cmd>GoImpl<cr>", desc = "GoImpl" },
})
