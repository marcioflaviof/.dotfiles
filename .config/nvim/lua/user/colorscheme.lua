local tokyook, tokyonight = pcall(require, "tokyonight")
if not tokyook then
  return
end

local catok, catppuccin = pcall(require, "catppuccin")
if not catok then
  return
end

tokyonight.setup({
  style = "night",
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent"
  },
  on_highlights = function(hl, colors)
    hl.CursorLineNr = {
      fg = colors.orange,
      bold = true
    }
    hl.LineNr = {
      fg = colors.blue0,
    }
  end
})

catppuccin.setup({
  transparent_background = true,
})

vim.g.catppuccin_flavour = "mocha"

local colorscheme = "tokyonight"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
