local wk = require("which-key")

-- stylua: ignore
wk.add({
	{ "<leader>G", group = "git" },
  { "<leader>Gb", function() require("snacks").picker.git_branches() end, desc = "git branches" },
  { "<leader>Gl", function() require("snacks").picker.git_log() end, desc = "git log" },
  { "<leader>GL", function() require("snacks").picker.git_log_line() end, desc = "git log line" },
  { "<leader>Gs", function() require("snacks").picker.git_status() end, desc = "git status" },
  { "<leader>GS", function() require("snacks").picker.git_stash() end, desc = "git stash" },
  { "<leader>Gd", function() require("snacks").picker.git_diff() end, desc = "git diff (hunks)" },
  { "<leader>Gf", function() require("snacks").picker.git_log_file() end, desc = "git log file" },
})
