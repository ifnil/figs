local wk = require("which-key")

-- stylua: ignore
wk.add({
	{ "<leader>D", group = "database" },
  { "<leader>Dd", function () require("dbee").toggle() end, desc = "dbee ui"},
  { "<leader>Db", "<cmd>DBUIToggle<cr>", desc = "dadbod ui"}
})
