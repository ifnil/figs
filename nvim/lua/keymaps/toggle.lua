local wk = require("which-key")

wk.add({
	{ "<leader>u", group = "ui/toggles" },
	{ "<leader>uG", "<cmd>Gitsigns toggle_signs<cr>", desc = "git signs" },
	{ "<leader>uR", "<cmd>RenderMarkdown toggle<cr>", desc = "render markdown" },
})

Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.profiler():map("<leader>upp")
Snacks.toggle.profiler_highlights():map("<leader>uph")
Snacks.toggle.zen():map("<leader>uz")

Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")

Snacks.toggle
	.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
	:map("<leader>uc")

Snacks.toggle
	.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
	:map("<leader>uA")

if vim.lsp.inlay_hint then
	Snacks.toggle.inlay_hints():map("<leader>uh")
end
