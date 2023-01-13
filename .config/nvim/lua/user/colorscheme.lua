local tokyook, tokyonight = pcall(require, "tokyonight")
if not tokyook then
	return
end

tokyonight.setup({
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
	end,
	on_colors = function(colors)
		colors.magenta = "#f7768e"
		colors.blue1 = "#7aa2f7"
	end,
})

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
