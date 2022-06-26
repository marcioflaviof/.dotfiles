local present, nvimtree = pcall(require, "nvim-tree")

if not present then
	return
end

local config_status_ok, nvimtree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvimtree_config.nvim_tree_callback

require("base46").load_highlight("nvimtree")

local options = {
	filters = {
		dotfiles = true,
	},
	view = {
		side = "left",
		width = 25,
		hide_root_folder = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
	},
	git = {
		enable = true,
		ignore = false,
	},
}

-- check for any override
options = require("core.utils").load_override(options, "kyazdani42/nvim-tree.lua")

nvimtree.setup(options)
