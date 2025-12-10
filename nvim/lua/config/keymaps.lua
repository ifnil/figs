local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map({ "n", "x", "o", "i", "v" }, "<C-s>", function()
	vim.cmd("stopinsert")
	vim.cmd("write")
end, { desc = "write file" })

map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "flash jump" })

map("n", "<leader><space>", "<cmd>FzfLua files<cr>", { desc = "find files" })
map("n", "<leader>N", "<cmd>NoiceAll<cr>", { desc = "notifications" })
map({ "n", "v", "x" }, "<Esc>", "<cmd>noh<cr><Esc>", { desc = "return to normal", noremap = true })

require("keymaps.buffer")
