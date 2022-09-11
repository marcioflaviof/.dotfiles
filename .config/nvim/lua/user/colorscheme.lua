local statusok, onedark = pcall(require, "onedarkpro")
if not statusok then
  return
end

local tokyook, tokyonight = pcall(require, "tokyonight")
if not tokyook then
  return
end


tokyonight.setup({
  style = "night"
})

local colorscheme = "tokyonight"

onedark.setup({
  dark_theme = "onedark_dark",
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
