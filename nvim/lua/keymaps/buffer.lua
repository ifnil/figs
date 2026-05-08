local wk = require("which-key")

-- buffer group
-- stylua: ignore
wk.add({
	{ "<leader>bb",  group = "buffers" },
	{ "<leader>bbp", "<Cmd>BufferLineTogglePin<CR>",            desc = "toggle pin" },
	{ "<leader>bbP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "delete non-pinned buffers" },
	{ "<leader>bbr", "<Cmd>BufferLineCloseRight<CR>",           desc = "delete buffers to the right" },
	{ "<leader>bbl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "delete buffers to the left" },
	{ "<S-h>",      "<cmd>bprev<cr>",                          desc = "prev buffer" },
	{ "<S-l>",      "<cmd>bnext<cr>",                          desc = "next buffer" },
	{ "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "prev buffer" },
	{ "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "next buffer" },
	{ "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "move buffer prev" },
	{ "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "move buffer next" },
})
