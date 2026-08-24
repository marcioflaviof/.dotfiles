-- MATCHUP

vim.g.matchup_enabled = 1
-- vim.g.matchup_matchparen_enabled = 0
vim.g.matchup_surround_enabled = 1

local map_ai_move = function(lhs, textobject_id, direction, desc)
	local rhs = function()
		MiniAi.move_cursor("left", "a", textobject_id, { search_method = direction })
	end
	vim.keymap.set({ "n", "x", "o" }, lhs, rhs, { desc = desc })
end

-- Instead of `'f'` use id of textobject you'd like to move.
-- For more info see `:h MiniAi.move_cursor()`.
map_ai_move("[f", "f", "prev", "Jump to prev function")
map_ai_move("]f", "f", "next", "Jump to next function")

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
		-- Kept over snacks.words, which is LSP-only. Illuminate falls back
		-- lsp -> regex, so it still highlights in yaml/sql/http/coffee/markdown,
		-- none of which have a documentHighlight-capable server here. It also
		-- ships reference navigation and textobjects.
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
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
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
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
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
	{
		"zk-org/zk-nvim",
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
			local opts = { noremap = true, silent = false }

			-- Create a new note after asking for its title.
			vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

			-- Open notes.
			vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
			-- Open notes associated with the selected tags.
			vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

			-- Search for the notes matching a given query.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>zf",
				"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
				opts
			)
			-- Search for the notes matching the current visual selection.
			vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
		end,
	},
}
