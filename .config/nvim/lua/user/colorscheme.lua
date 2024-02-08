local tokyook, tokyonight = pcall(require, "tokyonight")
if not tokyook then
  return
end

local nightfox = require("nightfox")

tokyonight.setup({
  transparent = true,
  style = "night",
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  on_highlights = function(hl, colors)
    hl.CursorLineNr = {
      fg = colors.orange,
      bold = true,
    }
    hl.LineNr = {
      fg = colors.blue0,
    }
    hl["@constructor.tsx"] = {
      fg = colors.red,
    }
  end,
})

nightfox.setup({
  options = {
    transparent = true,

    styles = {
      comments = "italic",
      keywords = "italic",
      types = "bold",
    }
  }
})

local colorscheme = "nightfox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- CMP transparent background
-- vim.cmd("highlight Pmenu guibg=NONE")
