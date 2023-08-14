local tokyook, tokyonight = pcall(require, "tokyonight")
if not tokyook then
  return
end

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

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  color_overrides = {
    mocha = {
      base = "#1a1b26",
      mantle = "#1a1b26",
      crust = "#1a1b26",
      surface0 = "#1a1b26",
    },
  },
})

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- CMP transparent background
vim.cmd("highlight Pmenu guibg=NONE")
vim.g.neovide_transparency = 0.8
