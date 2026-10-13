return {
	"Goshujinsama/nvim-strudel",
	ft = "strudel",
	build = "cd server && npm install && npm run build",
	keys = {
		{ "<C-CR>", "<cmd>StrudelEval<cr>", ft = "strudel", desc = "Strudel: Eval" },
		{ "<leader>ss", "<cmd>StrudelStop<cr>", ft = "strudel", desc = "Strudel: Stop" },
	},
	config = function()
		require("strudel").setup()
	end,
}
