local wk = require("which-key")

-- stylua: ignore
wk.add({
  { "<leader>f", group = "find"},
  { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "buffers" },
  { "<leader>fc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "find config file" },
  { "<leader>ff", function() require("snacks").picker.files() end, desc = "find files" },
  { "<leader>fg", function() require("snacks").picker.git_files() end, desc = "find git files" },
  { "<leader>fp", function() require("snacks").picker.projects() end, desc = "projects" },
  { "<leader>fr", function() require("snacks").picker.recent() end, desc = "recent" },
})
