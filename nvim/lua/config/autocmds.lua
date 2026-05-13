vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- LspAttach autocmd for custom keybindings and buffer-local settings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspAttachConfig", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		vim.cmd("ColorizerAttachToBuffer")
	end,
})

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- Clear search highlights when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		if vim.v.hlsearch == 1 and vim.fn.mode() == "n" then
			vim.cmd("nohlsearch")
		end
	end,
})

-- Autocmd to set filetype for .sql files to plsql
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.sql" },
	command = "setf plsql",
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.zig", "*.zon" },
-- 	callback = function(ev)
-- 		vim.lsp.buf.format({ async = true })
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "<filetype>" },
-- 	callback = function()
-- 		vim.treesitter.start()
-- 		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- 		vim.wo[0][0].foldmethod = "expr"
-- 	end,
-- })
