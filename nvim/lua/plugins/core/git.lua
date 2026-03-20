return {
	{ "lewis6991/gitsigns.nvim" },
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},

		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
