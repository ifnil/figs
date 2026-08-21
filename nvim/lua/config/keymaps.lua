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

-- stylua: ignore
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "flash jump" })
map({ "n", "v", "x" }, "<Esc>", "<cmd>noh<cr><Esc>", { desc = "return to normal", noremap = true })

map("n", "<leader><space>", "<cmd>FzfLua files<cr>", { desc = "find files" })
map("n", "<leader>N", "<cmd>NoiceFzf<cr>", { desc = "notifications" })
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

vim.keymap.set("n", "k", function()
	return vim.v.count > 0 and "k" or (vim.wo.wrap and "gk" or "k")
end, { expr = true, silent = true })

vim.keymap.set("n", "j", function()
	return vim.v.count > 0 and "j" or (vim.wo.wrap and "gj" or "j")
end, { expr = true, silent = true })

map("v", "<", "<gv")
map("v", ">", ">gv")

vim.keymap.set("v", "<C-b>", ":lua require('markdowny').bold()<cr>", { buffer = 0 })
vim.keymap.set("v", "<C-i>", ":lua require('markdowny').italic()<cr>", { buffer = 0 })
vim.keymap.set("v", "<C-k>", ":lua require('markdowny').link()<cr>", { buffer = 0 })
vim.keymap.set("v", "<C-e>", ":lua require('markdowny').code()<cr>", { buffer = 0 })

require("keymaps.nogroup")
require("keymaps.buffer")
require("keymaps.code")
require("keymaps.git")
require("keymaps.search")
require("keymaps.find")
require("keymaps.session")
require("keymaps.toggle")
require("keymaps.org")
require("keymaps.projects")
require("keymaps.todo")

-- keymaps
vim.keymap.set({ "x", "o" }, "am", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "as", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)
vim.keymap.set("n", "<leader>a", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>A", function()
	require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
end)
vim.keymap.set({ "n", "x", "o" }, "]m", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ "n", "x", "o" }, "]o", function()
	require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
vim.keymap.set({ "n", "x", "o" }, "]s", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end)
vim.keymap.set({ "n", "x", "o" }, "]z", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)

vim.keymap.set({ "n", "x", "o" }, "]M", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[m", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[M", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
vim.keymap.set({ "n", "x", "o" }, "]d", function()
	require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[d", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end)

vim.keymap.set("n", "<leader>uu", function()
	local current = vim.diagnostic.config().underline
	vim.diagnostic.config({
		underline = not current,
		virtual_text = vim.diagnostic.config().virtual_text,
		signs = vim.diagnostic.config().signs,
	})
end, { desc = "Toggle LSP underlines" })
