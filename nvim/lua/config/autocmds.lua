vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- -- stylua: ignore
-- local filetype_to_servers = {
-- 	sh                      = { "bashls" },
-- 	bash                    = { "bashls" },
-- 	c                       = { "clangd" },
-- 	cpp                     = { "clangd" },
-- 	lua                     = { "lua_ls" },
-- 	rust                    = { "rust_analyzer" },
-- 	yaml                    = { "yamlls" },
-- 	["yaml.docker-compose"] = { "yamlls" },
-- 	["yaml.gitlab"]         = { "yamlls" },
-- 	sql                     = { "sqlls" },
-- 	mysql                   = { "sqlls" },
-- }
--
-- -- Auto-enable LSP servers based on filetype
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("LspAutoEnable", { clear = true }),
-- 	callback = function(args)
-- 		local servers = filetype_to_servers[args.match]
-- 		if servers then
-- 			for _, server in ipairs(servers) do
-- 				vim.lsp.enable(server, args.buf)
-- 			end
-- 		end
-- 	end,
-- })

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
