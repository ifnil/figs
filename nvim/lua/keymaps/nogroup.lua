local wk = require("which-key")

-- stylua: ignore
wk.add({
	{ "<leader>/", function() require("snacks").picker.grep() end, desc = "grep" },
})
