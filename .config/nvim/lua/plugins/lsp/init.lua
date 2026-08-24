return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		-- Defers the whole mason chain (mason, mason-lspconfig,
		-- mason-tool-installer, fidget) with it, instead of five plugins on
		-- every launch including ones that open no file.
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{ "mason-org/mason-lspconfig.nvim" },
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			require("plugins.lsp.diagnostics").setup()
			require("plugins.lsp.keymaps").setup()
			require("plugins.lsp.servers").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").toggle("diagnostics")
				end,
			},
			{
				"<leader>xw",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
			},
			{
				"gR",
				function()
					require("trouble").toggle("lsp_references")
				end,
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					multilines = {
						enabled = true,
					},
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end,
	},
}
