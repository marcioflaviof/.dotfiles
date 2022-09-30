local tokyook, tokyonight = pcall(require, "tokyonight")
if not tokyook then
  return
end

tokyonight.setup({
  style = "night",
})

local colorscheme = "tokyonight"

vim.g.catppuccin_flavour = "mocha"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
