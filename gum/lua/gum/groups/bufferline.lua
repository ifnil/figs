local M = {}

function M.get(c, opts)
  local ret = {
    BufferLineFill = { bg = c.bg },
    BufferLineError = { bg = c.bg },
    BufferLinePick = { bg = c.bg },
    BufferLineCloseButton = { bg = c.bg },
    BufferLineTab = { bg = c.bg },
    BufferLineTabClose = { bg = c.bg },
    BufferLineBuffer = { bg = c.bg },
    BufferLineBufferVisible = { bg = c.bg },
    BufferLineBufferSelected = { bg = c.bg },
    BufferLineCloseButtonSelected = { bg = c.bg },
    BufferLineOffsetSeparator = { fg = c.bg },
    BufferLineBackground = { bg = c.bg },
    BufferLineSeparator = { bg = c.bg },
    BufferLineSeparatorVisible = { bg = c.bg },
    BufferLineIndicatorSelected = { bg = c.bg },
    BufferLineIndicatorVisible = { bg = c.bg },
    BufferLineDiagnostic = { bg = c.bg },
    BufferLineInfo = { bg = c.bg },
    BufferLineInfoVisible = { bg = c.bg },
    BufferLineDiagnosticVisible = { bg = c.bg },
    BufferLineDiagnosticSelected = { bg = c.bg },
    BufferLineModified = { fg = c.red, bg = c.bg },
    BufferLineModifiedSelected = { fg = c.red, bg = c.bg },
    BufferLineModifiedVisible = { fg = c.red, bg = c.bg },
    BufferLineHint = { bg = c.bg },
    BufferLineHintSelected = { bg = c.bg },
    BufferLineDuplicate = { bg = c.bg },
    BufferLineDuplicateVisible = { bg = c.bg },
    BufferLineCloseBUttonVisible = { bg = c.bg },
    BufferLineWarning = { bg = c.bg },
    BufferLineNumbers = { bg = c.bg },
    BufferLineNumbersVisible = { bg = c.bg },
  }

  local devicons = require("nvim-web-devicons")
  local icons = devicons.get_icons()
  for _, icon in pairs(icons) do
    if icon.name then
      ret["BufferLineDevIcon" .. icon.name] = { bg = c.bg }
      ret["BufferLineDevIcon" .. icon.name .. "Selected"] = { bg = c.bg }
      ret["BufferLineDevIcon" .. icon.name .. "Inactive"] = { bg = c.bg }
    end
  end

  return ret
end

return M
