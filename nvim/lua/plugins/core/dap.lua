return {
	{
		"mfussenegger/nvim-dap",
		recommended = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		-- config = function()
		-- 	require("config.dap.dap")
		-- end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		-- config = function()
		-- 	require("config.dap.dap-ui")
		-- end,
	},
	{ "nvim-neotest/nvim-nio" },
	{
		"Issafalcon/neotest-dotnet",
		lazy = false,
		dependencies = {
			"nvim-neotest/neotest",
		},
	},
	{
		"nvim-neotest/neotest",
		requires = {
			"Issafalcon/neotest-dotnet",
		},
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		-- opts = {
		-- 	adapters = {
		-- 		require("neotest-dotnet")({
		-- 			dap = {
		-- 				args = { justMyCode = false },
		-- 				adapter_name = "netcoredbg",
		-- 			},
		-- 		}),
		-- 	},
		-- },
	},
}
