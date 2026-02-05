local M = {}

function M.get(c, opts)
  -- stylua: ignore
  return {
    TelescopeBorder         = { fg = c.fg, bg = c.bg },
    TelescopeTitle          = { fg = c.lightgreen },
    TelescopeNormal         = { fg = c.fg, bg = c.bg },
    TelescopePromptBorder   = { fg = c.red, bg = c.bg },
    TelescopePromptTitle    = { fg = c.red, bg = c.bg },
    TelescopeResultsComment = { fg = c.separator },
    TelescopeMatching       = { fg = c.cyan, bg = c.none, bold = true}
  }
end

return M
