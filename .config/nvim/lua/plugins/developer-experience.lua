-- MATCHUP

vim.g.matchup_enabled = 1
-- vim.g.matchup_matchparen_enabled = 0
vim.g.matchup_surround_enabled = 1

return {
	{ "andymass/vim-matchup", lazy = false },
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
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
		event = "InsertEnter",
		opts = {},
	},
	{
		-- Kept over snacks.words, which is LSP-only. Illuminate falls back
		-- lsp -> regex, so it still highlights in yaml/sql/http/coffee/markdown,
		-- none of which have a documentHighlight-capable server here. It also
		-- ships reference navigation and textobjects.
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({})
		end,
	},
	{ "junegunn/vim-slash", event = "VeryLazy" },
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
		event = "VeryLazy",
		-- `:h MiniAi.move_cursor()`. Declared as `keys` rather than set at spec
		-- eval time, so they cannot fire before MiniAi exists.
		keys = {
			{
				"[f",
				function()
					MiniAi.move_cursor("left", "a", "f", { search_method = "prev" })
				end,
				mode = { "n", "x", "o" },
				desc = "Jump to prev function",
			},
			{
				"]f",
				function()
					MiniAi.move_cursor("left", "a", "f", { search_method = "next" })
				end,
				mode = { "n", "x", "o" },
				desc = "Jump to next function",
			},
		},
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
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				},
			})
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = "VeryLazy",
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
		event = "VeryLazy",
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
	{ "kchmck/vim-coffee-script", ft = "coffee" },
	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
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
	{
		"zk-org/zk-nvim",
		cmd = { "ZkNew", "ZkNotes", "ZkTags", "ZkMatch" },
		-- Keymaps live here rather than in `config` so they still work from a
		-- non-markdown buffer without loading zk on every launch.
		keys = {
			{ "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "zk: new note" },
			{ "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "zk: open notes" },
			{ "<leader>zt", "<Cmd>ZkTags<CR>", desc = "zk: tags" },
			{
				"<leader>zf",
				"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
				desc = "zk: search notes",
			},
			{ "<leader>zf", ":'<,'>ZkMatch<CR>", mode = "v", desc = "zk: match selection" },
		},
		config = function()
			require("zk").setup({
				picker = "snacks_picker",

				lsp = {
					config = {
						name = "zk",
						cmd = { "zk", "lsp" },
						filetypes = { "markdown" },
					},

					auto_attach = {
						enabled = true,
					},
				},
			})
		end,
	},
}
