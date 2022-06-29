local M = {}

local override = require("custom.override")

M.options = {
	user = function()
		vim.opt.scrolloff = 8
		vim.opt.number = true
		vim.opt.tabstop = 4
		vim.opt.softtabstop = 4
		vim.opt.shiftwidth = 2
		vim.opt.expandtab = true
		vim.opt.smartindent = true
		vim.opt.termguicolors = true
		vim.opt.autoread = true
		vim.opt.completeopt = { "menuone", "noselect" }
		vim.opt.mouse = "a"
		vim.opt.guifont = "JetBrainsMono Nerd Font:h11"
		vim.opt.clipboard = "unnamedplus"
		vim.g.loaded_matchit = nil
		vim.cmd("runtime " .. "matchit")
	end,
}

M.plugins = {
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},

		statusline = {
			separator_style = "round",
		},
	},

	override = {
		["nvim-treesitter/nvim-treesitter"] = override.treesitter,
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
	},

	user = require("custom.plugins"),

	remove = {
		"folke/which-key.nvim",
	},
}

M.ui = {
	theme = "tokyonight",
}

M.mappings = require("custom.mappings")

return M
