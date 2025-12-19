local wk = require("which-key")

-- code group
-- stylua: ignore
wk.add({
	{ "<leader>c", group = "code" },
	{ "<leader>cs", "<cmd>Trouble symbols<cr>", desc = "symbols" },
  { "<leader>cy", function() require("snacks").picker.lsp_symbols() end, desc = "symbols (snacks)" },
  { "<leader>sS", function() require("snacks").picker.lsp_workspace_symbols() end, desc = "lsp workspace symbols" },
})

-- stylua: ignore
wk.add({
  { "gd",  function() require("snacks").picker.lsp_definitions() end,      desc = "goto definition" },
  { "gD",  function() require("snacks").picker.lsp_declarations() end,     desc = "goto declaration" },
  { "gr",  function() require("snacks").picker.lsp_references() end,       nowait = true, desc = "references" },
  { "gI",  function() require("snacks").picker.lsp_implementations() end,  desc = "goto implementation" },
  { "gy",  function() require("snacks").picker.lsp_type_definitions() end, desc = "goto t[y]pe definition" },
  { "gai", function() require("snacks").picker.lsp_incoming_calls() end,   desc = "c[a]lls incoming" },
  { "gao", function() require("snacks").picker.lsp_outgoing_calls() end,   desc = "c[a]lls outgoing" },
})
