return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},

		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},

		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
		},

		views = {
			cmdline_popup = {
				border = {
					style = "single",
				},
			},

			popupmenu = {
				border = {
					style = "single",
				},
			},
		},
	},
	config = function(_, opts)
		-- HACK: noice shows messages from before it was enabled,
		-- but this is not ideal when Lazy is installing plugins,
		-- so clear the messages in this case.
		if vim.o.filetype == "lazy" then
			vim.cmd([[messages clear]])
		end
		require("noice").setup(opts)

		-- Show `:NoiceAll` in Telescope instead of a split.
		-- The bundled telescope extension is hardwired to the `history` filter,
		-- so swap in the unfiltered `all` filter while it builds its finder.
		local commands = require("noice.commands")
		local cmd = commands.cmd
		commands.cmd = function(name)
			if name ~= "all" or not pcall(require, "telescope") then
				return cmd(name)
			end
			local config = require("noice.config")
			local history = config.options.commands.history.filter
			config.options.commands.history.filter = config.options.commands.all.filter
			local ok, err = pcall(require("telescope").extensions.noice.noice, {})
			config.options.commands.history.filter = history
			if not ok then
				vim.notify(tostring(err), vim.log.levels.ERROR)
			end
		end
	end,
}
