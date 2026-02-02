local palette = {
	dark = {
		bg = "#000000",
		fg = "#DBD0C6",
		dark = "#282828",
		gray = "#91A4AD",
		green = "#96C2A1",
		blue = "#86BFD0",
		orange = "#F9ADA0",
		pink = "#D9ADD4",
		red = "#D2696C",
		yellow = "#FFD7AA",
		black = "#000000",
		white = "#ffffff",
	},

	light = {
		black = "#000000",
		white = "#ffffff",

		bg = "#d5dbdb",
		fg = "#000000",

		redb = "#f75e5e",
		redd = "#D2696C",
		oran = "#f0a373",
		pink = "#ff94f6",
		purp = "#ce87fa",
		teal = "#82ffe4",
		torq = "#78ffc7",
		blue = "#51e7f5",

		dark = "#282828",
		gray = "#91A4AD",
		green = "#96C2A1",
		orange = "#F9ADA0",
		yellow = "#FFD7AA",
	},
}

vim.g.theme = palette.dark

if vim.opt.background == "dark" then
	vim.g.theme = palette.dark
elseif vim.opt.background == "light" then
	vim.g.theme = palette.light
end
