local wk = require("which-key")

--stylua: ignore
wk.add({
	{ "<leader>d", group = "debug" },

	{ "<leader>dt", group = "testing" },
	{ "<leader>dtu", "<cmd>Dotnet testrunner<cr>", desc = "test runner" },
	{ "<leader>dtr", function() require("neotest").run.run() end, desc = "run test" },

	{ "<leader>dp", group = "profiler" },
})
