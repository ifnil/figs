return {
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()
			require("nvim-treesitter").install({
				"c",
				"toml",
				"sql",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"query",
				"tsx",
				"typescript",
				"yaml",
				"lua",
				"luadoc",
				"luap",
				"vim",
				"vimdoc",
				"xml",
				"printf",
				"html",
				"javascript",
				"json",
				"jsdoc",
				"diff",
				"ocaml",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup()
		end,
	},
}
