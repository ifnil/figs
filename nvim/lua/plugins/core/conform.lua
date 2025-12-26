return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	lazy = true,
	cmd = "ConformInfo",
	opts = {
		notify_on_error = true,
		notify_no_formatters = true,

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		formatters_by_ft = {
			["*"] = { "codespell" },
			["_"] = { "trim_whitespace" },

			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			c = { "clang-format" },
			sh = { "shfmt" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			less = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			["markdown.mdx"] = { "prettier" },
			graphql = { "prettier" },
			handlebars = { "prettier" },
			json = { "fixjson", "prettier" },
			xml = { "xmlformatter" },
		},
	},
}
