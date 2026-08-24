return {
	{
		"tpope/vim-projectionist",
		config = function()
			vim.g.projectionist_heuristics = {
				["*"] = {
					["src/*.tsx"] = {
						alternate = "src/{dirname}/__tests__/{basename}.test.tsx",
						type = "source",
					},
					["src/**/__tests__/*.test.tsx"] = {
						alternate = "src/{dirname}/{basename}.tsx",
						type = "test",
					},

					["src/*.ts"] = {
						alternate = "src/{dirname}/__tests__/{basename}.test.ts",
						type = "source",
					},
					["src/**/__tests__/*.test.ts"] = {
						alternate = "src/{dirname}/{basename}.ts",
						type = "test",
					},
				},
			}

			vim.keymap.set("n", "<leader>al", "<CMD>A<CR>", { desc = "Alternate file" })
		end,
	},
	{
		"tpope/vim-rails",
		ft = { "ruby", "eruby", "slim", "yaml", "yml" },
		config = function()
			vim.keymap.set("n", "<leader>rl", "<CMD>R<CR>", { desc = "Rails related file" })
		end,
	},
	{
		"cbochs/grapple.nvim",
		-- `<leader>r` used to be "select tag 4", but it is a prefix of rn/rl/rs/
		-- ra/rr/rc/rC (LSP rename, vim-rails, kulala), so every press stalled
		-- for 'timeoutlen'. `<leader>h` was likewise a prefix of `<leader>hm`;
		-- it is now a pure group prefix with hh/ha underneath.
		keys = {
			{ "<leader>ha", "<cmd>Grapple tag<cr>", desc = "Grapple: add tag" },
			{ "<leader>hh", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple: tags" },
			{ "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Grapple: tag 1" },
			{ "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Grapple: tag 2" },
			{ "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Grapple: tag 3" },
			{ "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Grapple: tag 4" },
		},
		opts = {
			scope = "git_branch",
		},
		cmd = "Grapple",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			labels = "ASDFGHJKLQWERTYUIOPZXCVBNM",
			modes = {
				search = {
					enabled = true,
				},
			},
		},
		keys = {
			{
				"S",
				mode = { "n" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"s",
				mode = { "n" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"<c-space>",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter({
						actions = {
							["<c-space>"] = "next",
							["<BS>"] = "prev",
						},
					})
				end,
				desc = "Treesitter Incremental Selection",
			},
		},
	},
}
