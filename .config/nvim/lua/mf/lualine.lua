local cmp_status_ok, lualine = pcall(require, "lualine")
if not cmp_status_ok then
	return
end

local window_width_limit = 70

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > window_width_limit
	end,
	-- check_git_workspace = function()
	--   local filepath = vim.fn.expand "%:p:h"
	--   local gitdir = vim.fn.finddir(".git", filepath .. ";")
	--   return gitdir and #gitdir > 0 and #gitdir < #filepath
	-- end,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	color = {},
	cond = conditions.hide_in_width,
}
local treesitter = {
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return ""
		end
		return ""
	end,
	cond = conditions.hide_in_width,
}

---- CONFIG

local config = {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { diagnostics, treesitter, "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
}

lualine.setup(config)
