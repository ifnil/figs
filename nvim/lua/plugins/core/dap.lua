return {
	{
		"mfussenegger/nvim-dap",
		recommended = true,
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		config = function()
			require("config.dap")
		end,
	},
}
