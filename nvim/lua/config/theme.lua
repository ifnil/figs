-- stylua: ignore
local palette = {
  dark = {
    bg     = "#000000",
    fg     = "#DBD0C6",

    black  = "#000000",
    white  = "#ffffff",
    dark   = "#282828",
    gray   = "#91A4AD",
    green  = "#96C2A1",
    blue   = "#86BFD0",
    orange = "#F9ADA0",
    pink   = "#D9ADD4",
    red    = "#D2696C",
    yellow = "#FFD7AA",

    visual = "#000000"
  },

  light = {
    -- bg     = "#e1e4dc",
    bg     = "#e2e4eb",
    fg     = "#2e2c2f",

    black  = "#000000",
    white  = "#ffffff",
    redb   = "#f75e5e",
    redd   = "#D2696C",
    oran   = "#f0a373",
    pink   = "#ff94f6",
    purp   = "#ce87fa",
    teal   = "#82ffe4",
    torq   = "#78ffc7",
    blue   = "#51e7f5",

    dark   = "#282828",
    gray   = "#91A4AD",
    green  = "#96C2A1",
    orange = "#F9ADA0",
    yellow = "#FFD7AA",

    visual = "#b3e0c5",
  },
}

vim.opt.background = "dark"
vim.g.mein_theme = palette.dark
