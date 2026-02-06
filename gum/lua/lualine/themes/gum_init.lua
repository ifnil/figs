local M = {}

function M.get(style)
  local colors = require("gum.colors").setup(style)

  return {
    normal = {
      a = { bg = colors.bg, fg = colors.green, gui = "italic" },
      b = { bg = colors.bg, fg = colors.green },
      c = { bg = colors.bg, fg = colors.gray },
    },
    insert = {
      a = { bg = colors.bg, fg = colors.blue, gui = "italic" },
      b = { bg = colors.bg, fg = colors.blue },
      c = { bg = colors.bg, fg = colors.gray },
    },
    visual = {
      a = { bg = colors.bg, fg = colors.pink, gui = "italic" },
      b = { bg = colors.bg, fg = colors.pink },
      c = { bg = colors.bg, fg = colors.gray },
    },
    replace = {
      a = { bg = colors.bg, fg = colors.red, gui = "italic" },
      b = { bg = colors.bg, fg = colors.red },
      c = { bg = colors.bg, fg = colors.gray },
    },
    command = {
      a = { bg = colors.bg, fg = colors.orange, gui = "italic" },
      b = { bg = colors.bg, fg = colors.orange },
      c = { bg = colors.bg, fg = colors.gray },
    },
    inactive = {
      a = { bg = colors.bg, fg = colors.dark },
      b = { bg = colors.bg, fg = colors.dark },
      c = { bg = colors.bg, fg = colors.dark },
    },
  }
end

return M
