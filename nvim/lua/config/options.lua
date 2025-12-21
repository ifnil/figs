vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true
vim.opt.list = true
vim.opt.virtualedit = "block"
vim.opt.cursorline = true
vim.opt.cmdheight = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 250
vim.opt.scrolloff = 8
vim.opt.background = "dark"
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.pumheight = 0
vim.opt.clipboard = "unnamedplus"
vim.opt.winborder = "single"
vim.opt.mousemoveevent = true
vim.opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"help",
	"globals",
	"skiprtp",
	"folds",
}
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Clear search highlights when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		if vim.v.hlsearch == 1 and vim.fn.mode() == "n" then
			vim.cmd("nohlsearch")
		end
	end,
})
