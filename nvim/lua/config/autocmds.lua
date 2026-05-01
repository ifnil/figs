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

-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true }),
-- 	callback = function(args)
-- 		local buf = args.buf
-- 		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
-- 		if ok and stats and stats.size > 100 * 1024 * 1024 then
-- 			return
-- 		end
-- 		if pcall(vim.treesitter.start, buf) then
-- 			vim.bo[buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
-- 		end
-- 	end,
-- })

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
