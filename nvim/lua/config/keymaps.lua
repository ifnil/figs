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

map({ "n" }, "<leader>e", function()
	require("snacks").explorer()
end, { desc = "open file tree" })

map("n", "<leader><space>", "<cmd>FzfLua files<cr>", { desc = "find files" })
map("n", "<leader>N", "<cmd>NoiceFzf<cr>", { desc = "notifications" })
map({ "n", "v", "x" }, "<Esc>", "<cmd>noh<cr><Esc>", { desc = "return to normal", noremap = true })

map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- stylua: ignore
map({ "n", "t" }, "<C-/>", function() require("snacks").terminal() end, { desc = "terminal" })

-- stylua: ignore
map({ "n", "t" }, "<C-_>", function() require("snacks").terminal() end, { desc = "terminal" })

require("keymaps.nogroup")
require("keymaps.buffer")
require("keymaps.code")
require("keymaps.git")
require("keymaps.search")
require("keymaps.find")
require("keymaps.session")
require("keymaps.toggle")
