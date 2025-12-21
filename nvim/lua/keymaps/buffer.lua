local wk = require("which-key")

-- buffer group
-- stylua: ignore
wk.add({
	{ "<leader>b",  group = "buffers" },
	{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "toggle pin" },
	{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "delete non-pinned buffers" },
	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "delete buffers to the right" },
	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "delete buffers to the left" },
	{ "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "prev buffer" },
	{ "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "next buffer" },
	{ "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "prev buffer" },
	{ "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "next buffer" },
	{ "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "move buffer prev" },
	{ "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "move buffer next" },
})
