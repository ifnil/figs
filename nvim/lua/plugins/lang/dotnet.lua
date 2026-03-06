return {
	"GustavEikaas/easy-dotnet.nvim",
	ft = { "cs" },
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local dotnet = require("easy-dotnet")
		dotnet.setup({
			managed_terminal = {
				auto_hide = true, -- auto hides terminal if exit code is 0
				auto_hide_delay = 1000, -- delay before auto hiding, 0 = instant
			},

			lsp = {
				enabled = true, -- Enable builtin roslyn lsp
				preload_roslyn = true, -- Start loading roslyn before any buffer is opened
				roslynator_enabled = true, -- Automatically enable roslynator analyzer
				easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
				auto_refresh_codelens = true,
				analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
				config = {},
			},
		})
	end,
}

-- return {
-- 	{
-- 		"seblyng/roslyn.nvim",
-- 		---@module 'roslyn.config'
-- 		---@type RoslynNvimConfig
-- 		ft = { "cs", "razor" },
-- 		opts = {
-- 			-- your configuration comes here; leave empty for default settings
-- 		},
-- 	},
-- }
