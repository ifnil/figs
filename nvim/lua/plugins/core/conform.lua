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
			javascript = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "markdownfmt" },
			c = { "clang-format" },
		},
	},
}
