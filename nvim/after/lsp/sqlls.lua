return {
	cmd = { "sql-language-server", "up" },
	filetypes = { "sql" },
	settings = {
		["sqlLanguageServer.lint"] = {
			["rules"] = {
				["column-new-line"] = "off",
				["linebreak-after-clause-keyword"] = "off",
				["where-clause-new-line"] = "off",
			},
		},
	},
}
