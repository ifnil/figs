local wk = require("which-key")

-- stylua: ignore
wk.add({
  { "<leader>d",  group = "debug" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
  { "<leader>du", function() require("dapui").toggle() end,          desc = "toggle ui" },
})
