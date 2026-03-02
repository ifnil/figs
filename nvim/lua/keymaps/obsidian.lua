local wk = require("which-key")

wk.add({
	{ "<leader>o", group = "obsidian" },
	{ "<leader>on", group = "new" },
	{ "<leader>ont", "<cmd>Obsidian new_from_template<cr>", desc = "new from template" },
	{ "<leader>onn", "<cmd>Obsidian new<cr>", desc = "new" },
	{ "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "workspaces" },
	{ "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "tags" },
	{ "<leader>oo", "<cmd>Obsidian open<cr>", desc = "open" },
	{ "<leader>os", "<cmd>Obsidian search<cr>", desc = "search" },
	{ "<leader>ol", "<cmd>Obsidian links<cr>", desc = "links" },
	{ "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "paste image" },
	{ "<leader>or", "<cmd>Obsidian rename<cr>", desc = "rename" },
})
