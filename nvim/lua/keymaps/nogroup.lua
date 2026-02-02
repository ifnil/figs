local wk = require("which-key")

-- stylua: ignore
wk.add({
  -- { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "file tree"},
	{ "<leader>/", function() require("snacks").picker.grep() end, desc = "grep" },
  { "<leader>e", function() require("snacks").explorer() end, desc = "file tree"},
})
