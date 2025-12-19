local wk = require("which-key")

-- stylua: ignore
wk.add({
  { "<leader>q", group = "quit"},
  { "<leader>qq", "<cmd>quit<cr>", desc = "quit"},
  { "<leader>qa", "<cmd>quitall<cr>", desc = "quit all"},
  { "<leader>qw", function ()
      vim.cmd("stopinsert")
      vim.cmd("write")
      vim.cmd("quitall")
    end, desc = "write quit all"},
})

-- stylua: ignore
wk.add({

	{ "<leader>r", group = "session" },
  { "<leader>rs", function() require("persistence").load() end, desc = "restore session" },
  { "<leader>rS", function() require("persistence").select() end,desc = "select session" },
  { "<leader>rl", function() require("persistence").load({ last = true }) end, desc = "restore last session" },
  { "<leader>rd", function() require("persistence").stop() end, desc = "don't save current session" },
})
