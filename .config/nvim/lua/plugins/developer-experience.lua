-- MATCHUP

vim.g.matchup_enabled = 1
-- vim.g.matchup_matchparen_enabled = 0
vim.g.matchup_surround_enabled = 1

return {
	{ "andymass/vim-matchup", lazy = false },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = -1
			vim.o.foldenable = true
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			require("ufo").setup({
				-- close_fold_kinds_for_ft = { default = { "imports" } },
				provider_selector = function(_, ft, _)
					local lspWithOutFolding = { "markdown", "zsh", "css", "html", "python", "json" }
					if vim.tbl_contains(lspWithOutFolding, ft) then
						return { "treesitter", "indent" }
					end
					return { "lsp", "indent" }
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({})
		end,
	},
	"junegunn/vim-slash",
	{
		"jiaoshijie/undotree",
		---@module 'undotree.collector'
		---@type UndoTreeCollector.Opts
		opts = {
			float_diff = true, -- using float window previews diff, set this `true` will disable layout option
			layout = "left_bottom", -- "left_bottom", "left_left_bottom"
			position = "left", -- "right", "bottom"
			ignore_filetype = {
				"undotree",
				"undotreeDiff",
				"qf",
			},
			window = {
				winblend = 30,
				border = "rounded", -- The string values are the same as those described in 'winborder'.
			},
			keymaps = {
				j = "move_next",
				k = "move_prev",
				gj = "move2parent",
				J = "move_change_next",
				K = "move_change_prev",
				["<cr>"] = "action_enter",
				p = "enter_diffbuf",
				q = "quit",
			},
		},
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		config = function()
			local ai = require("mini.ai")
			return ai.setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
				},
			})
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		opts = {
			n_lines = 500,
			search_method = "cover_or_next",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		"nvim-mini/mini.operators",
		version = "*",
		opts = {},
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {},
	},
	"kchmck/vim-coffee-script",
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {},
	},
	{
		"Wansmer/treesj",
		keys = { "<space>m" },
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
