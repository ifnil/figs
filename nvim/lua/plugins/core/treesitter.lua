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
				"gdscript",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		opts = {
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
				},
				include_surrounding_whitespace = false,
				set_jumps = true,
			},
		},
	},
}
