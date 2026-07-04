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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "nasm",
	callback = function()
		vim.keymap.set("n", "<leader>mb", function()
			vim.cmd("write")
			vim.cmd("!nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r")
		end, { buffer = true, desc = "Build NASM file" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "nasm",
	callback = function()
		vim.bo.commentstring = "; %s"
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = false
	end,
})
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.zig", "*.zon" },
-- 	callback = function(ev)
-- 		vim.lsp.buf.format({ async = true })
-- 	end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		-- only start if a parser exists for this buffer
		local ok = pcall(vim.treesitter.start, ev.buf)
		if ok then
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end
	end,
})
