local statusok, onedark = pcall(require, "onedarkpro")
if not statusok then
	return
end

local colorscheme = "tokyonight"
vim.g.tokyonight_style = "night"
onedark.setup({
	dark_theme = "onedark_dark",
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
