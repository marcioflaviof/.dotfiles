return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		-- only load inside a vault, not for every markdown file
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian/*.md",
		},
		---@module 'obsidian'
		---@type obsidian.config
		opts = {
			legacy_commands = false,
			picker = {
				name = "snacks.picker",
			},
			ui = {
				enable = false,
			},
			attachments = {
				folder = "Attachments",
			},
			workspaces = {
				{
					name = "personal",
					path = "~/Documents/Obsidian",
				},
			},
		},
	},
}
