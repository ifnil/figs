return {
	cmd = { "asm-lsp" },
	filetypes = { "asm", "vmasm" },
	root_dir = function(fname)
		return vim.fs.dirname(vim.fs.find({ ".asm-lsp.toml", ".git" }, { path = fname, upward = true })[1])
	end,
	single_file_support = true,
}
