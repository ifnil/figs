local wk = require("which-key")

-- stylua: ignore
wk.add({

  { "<leader>s", group = "search"},
  { "<leader>s/", function() require("snacks").picker.search_history() end, desc = "search history" },
  { "<leader>sr", function() require("snacks").picker.registers() end, desc = "registers" },
  { "<leader>sa", function() require("snacks").picker.autocmds() end, desc = "autocmds" },
  { "<leader>sb", function() require("snacks").picker.lines() end, desc = "buffer lines" },
  { "<leader>sc", function() require("snacks").picker.command_history() end, desc = "command history" },
  { "<leader>sC", function() require("snacks").picker.commands() end, desc = "commands" },
  { "<leader>sd", function() require("snacks").picker.diagnostics() end, desc = "diagnostics" },
  { "<leader>sD", function() require("snacks").picker.diagnostics_buffer() end, desc = "buffer diagnostics" },
  { "<leader>sh", function() require("snacks").picker.help() end, desc = "help pages" },
  { "<leader>sH", function() require("snacks").picker.highlights() end, desc = "highlights" },
  { "<leader>si", function() require("snacks").picker.icons() end, desc = "icons" },
  { "<leader>sj", function() require("snacks").picker.jumps() end, desc = "jumps" },
  { "<leader>sk", function() require("snacks").picker.keymaps() end, desc = "keymaps" },
  { "<leader>sl", function() require("snacks").picker.loclist() end, desc = "location list" },
  { "<leader>sm", function() require("snacks").picker.marks() end, desc = "marks" },
  { "<leader>sM", function() require("snacks").picker.man() end, desc = "man pages" },
  { "<leader>sp", function() require("snacks").picker.lazy() end, desc = "search for plugin spec" },
  { "<leader>sq", function() require("snacks").picker.qflist() end, desc = "quickfix list" },
  { "<leader>sR", function() require("snacks").picker.resume() end, desc = "resume" },
  { "<leader>su", function() require("snacks").picker.undo() end, desc = "undo history" },
  { "<leader>uC", function() require("snacks").picker.colorschemes() end, desc = "colorschemes" },
})
