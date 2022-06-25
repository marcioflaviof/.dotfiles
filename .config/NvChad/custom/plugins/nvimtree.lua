local present, nvimtree = pcall(require, "nvim-tree")

if not present then
	return
end

require("base46").load_highlight("nvimtree")

local options = {
	filters = {
		dotfiles = true,
	},
	view = {
		side = "left",
		width = 25,
		hide_root_folder = true,
	},
	git = {
		enable = true,
		ignore = false,
	},
}

-- check for any override
options = require("core.utils").load_override(options, "kyazdani42/nvim-tree.lua")

nvimtree.setup(options)
