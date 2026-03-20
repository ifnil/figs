return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	cond = string.find(vim.fn.getcwd(), vim.fn.expand("~/notes")),
	opts = {
		legacy_commands = false,

		ui = {
			enable = false,
		},

		frontmatter = {
			enabled = true,
			sort = { "id", "aliases", "tags" },
		},

		workspaces = {
			{
				name = "work",
				path = "~/notes/work",
			},
			{
				name = "dev",
				path = "~/notes/dev",
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
				task = {
					notes_subdir = "tasks/",
				},
			},
		},

		daily_notes = {
			enabled = true,
			folder = "daily",
			template = "_templates/daily.md",
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
			return name
		end,
	},
}
