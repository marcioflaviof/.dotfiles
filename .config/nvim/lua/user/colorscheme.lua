local tokyonight = require("tokyonight")
local nightfox = require("nightfox")
local catppuccin = require("catppuccin")

tokyonight.setup({
  transparent = false,
  style = "night",
  -- styles = {
  --   sidebars = "transparent",
  --   floats = "transparent",
  -- },
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
    transparent = false,

    styles = {
      comments = "italic",
      keywords = "italic",
      types = "bold",
    }
  }
})

catppuccin.setup({
  transparent_background = false,
  styles = {
    comments = { "italic" },
    keywords = { "italic" },
    types = { "bold" },
  }
})

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- CMP transparent background
-- vim.cmd("highlight Pmenu guibg=NONE")
