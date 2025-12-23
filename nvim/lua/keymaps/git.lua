local wk = require("which-key")

-- stylua: ignore
wk.add({
	{ "<leader>g", group = "git" },
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "lazygit" },
  { "<leader>gb", function() require("snacks").picker.git_branches() end, desc = "git branches" },
  { "<leader>gl", function() require("snacks").picker.git_log() end, desc = "git log" },
  { "<leader>gL", function() require("snacks").picker.git_log_line() end, desc = "git log line" },
  { "<leader>gs", function() require("snacks").picker.git_status() end, desc = "git status" },
  { "<leader>gS", function() require("snacks").picker.git_stash() end, desc = "git stash" },
  { "<leader>gd", function() require("snacks").picker.git_diff() end, desc = "git diff (hunks)" },
  { "<leader>gf", function() require("snacks").picker.git_log_file() end, desc = "git log file" },
})
