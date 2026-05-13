local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		{ import = "plugins.ui" },
		{ import = "plugins.core" },
		{ import = "plugins.navigation" },
		{ import = "plugins.lang" },
		{ import = "plugins.extra" },
	},
	checker = { enabled = true },
	dev = {
		path = "~/code/plugins",
	},
})

vim.cmd("colorscheme gum")

require("neotest").setup({
	adapters = {
		require("neotest-dotnet")({
			dap = {
				-- Extra arguments for nvim-dap configuration
				-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
				args = { justMyCode = false },
				-- Enter the name of your dap adapter, the default value is netcoredbg
				adapter_name = "netcoredbg",
			},
			-- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
			-- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
			custom_attributes = {
				xunit = { "MyCustomFactAttribute" },
				nunit = { "MyCustomTestAttribute" },
				mstest = { "MyCustomTestMethodAttribute" },
			},
			-- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
			dotnet_additional_args = {
				"--verbosity detailed",
			},
			-- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
			-- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
			--       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
			discovery_root = "project", -- Default
		}),
	},
})
