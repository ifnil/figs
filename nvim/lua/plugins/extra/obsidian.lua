return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	cond = string.find(vim.fn.getcwd(), vim.fn.expand("~/notes")),
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/notes/work",
			},
		},
		templates = {
			folder = "_templates",
			customizations = {
				alert = {
					notes_subdir = "alerts/",
				},
				ticket = {
					notes_subdir = "tickets/",
				},
			},
		},
		attachments = {
			folder = "assets",
		},
		footer = {
			enabled = false,
		},

		note_id_func = function(title)
			if title == nil then
				return nil
			end

			local name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			return name -- "Hulk Hogan" → "hulk-hogan"
		end,
	},
}
