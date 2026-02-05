local M = {}

function M.get(c, opts)
  local ret = {
    BlinkCmpMenuSelection = { bg = c.bg_visual },
    BlinkCmpKind = { bg = c.bg_visual },
    BlinkCmpScrollBarThumb = { bg = c.fg },
  }

  require("gum.groups.kinds").kinds(ret, "BlinkCmpItemKind%s")
  return ret
end

return M
