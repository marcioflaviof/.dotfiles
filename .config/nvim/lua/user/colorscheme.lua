local tokyook, tokyonight = pcall(require, "tokyonight")
if not tokyook then
	return
end

tokyonight.setup({
	style = "night",
	transparent = true,
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
		-- hl["@tag.delimiter.tsx"] = {
		-- 	fg = colors.red,
		-- }
		hl["@constructor.tsx"] = {
			fg = colors.red,
		}
		-- hl["@tag.attribute.tsx"] = {
		-- 	fg = colors.blue,
		-- }
	end,
})

require("nightfox").setup({
	options = {
		transparent = true,
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
