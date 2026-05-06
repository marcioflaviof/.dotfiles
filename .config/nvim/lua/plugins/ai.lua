vim.api.nvim_set_keymap("n", "<Leader>o", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Leader>o", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
-- vim.cmd([[cab cc CodeCompanion]])
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot" },
		event = "InsertEnter",
		opts = {
			copilot_node_command = "/home/mf/.local/share/mise/installs/node/23.11.0/bin/node",
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 0,
				keymap = {
					accept = "<M-l>",
				},
			},
			filetypes = {
				markdown = true,
				yaml = true,
			},
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"franco-ruggeri/codecompanion-spinner.nvim",
		},
		opts = {
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "gpt-5.3-Codex",
							},
						},
					})
				end,
			},
			strategies = {
				chat = { adapter = "copilot" },
				inline = { adapter = "copilot" },
				cmd = { adapter = "copilot" },
			},
			extensions = {
				spinner = {},
			},
		},
	},
}
