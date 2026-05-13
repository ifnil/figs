return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		ft = { "cs" },
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local dotnet = require("easy-dotnet")
			dotnet.setup({
				test_runner = {
					auto_start_testrunner = false,
					hide_legend = false,
					---@type "split" | "vsplit" | "float" | "buf"
					viewmode = "float",
					---@type number|nil
					vsplit_width = nil,
					---@type string|nil "topleft" | "topright"
					vsplit_pos = nil,
					icons = {
						passed = "",
						skipped = "",
						failed = "",
						success = "",
						reload = "",
						test = "",
						sln = "󰘐",
						project = "󰘐",
						dir = "",
						package = "",
						class = "",
						build_failed = "󰒡",
					},
					mappings = {
						run_test_from_buffer = { lhs = "<leader>tR", desc = "run test from buffer" },
						get_build_errors = { lhs = "<leader>e", desc = "get build errors" },
						peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
						debug_test_from_buffer = { lhs = "<leader>d", desc = "run test from buffer" },
						debug_test = { lhs = "<leader>d", desc = "debug test" },
						go_to_file = { lhs = "g", desc = "go to file" },
						run_all = { lhs = "<leader>R", desc = "run all tests" },
						run = { lhs = "<leader>tr", desc = "run test" },
						peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
						expand = { lhs = "o", desc = "expand" },
						expand_node = { lhs = "E", desc = "expand node" },
						collapse_all = { lhs = "W", desc = "collapse all" },
						close = { lhs = "q", desc = "close testrunner" },
						refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
						cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
					},
				},
				lsp = {
					enabled = true,
					preload_roslyn = true,
					roslynator_enabled = true,
					easy_dotnet_analyzer_enabled = true,
					analyzer_assemblies = {},
					config = {},
				},
			})
		end,
	},
}
