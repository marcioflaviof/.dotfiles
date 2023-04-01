local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Install your plugins here
return lazy.setup({
	-- My plugins here
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

	-- User interface

	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"feline-nvim/feline.nvim",
	"akinsho/bufferline.nvim",
	"moll/vim-bbye", -- better buffer close
	"akinsho/toggleterm.nvim", -- toggle terminal

	-- Colorschemes
	"folke/tokyonight.nvim",

	-- cmp plugins
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",

			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- {
			-- 	"tzachar/cmp-tabnine",
			-- 	build = "./install.sh",
			-- 	dependencies = "hrsh7th/nvim-cmp",
			-- 	event = "InsertEnter",
			-- },
		},
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- better function signature location
			"ray-x/lsp_signature.nvim",
			"lvimuser/lsp-inlayhints.nvim",

			-- better typescript experience
			"jose-elias-alvarez/typescript.nvim",
		},
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},

	-- shows variables as I navigate
	"SmiteshP/nvim-navic",

	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	"RRethy/vim-illuminate",

	-- Telescope
	"nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		build = "make",
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},
	"JoosepAlviste/nvim-ts-context-commentstring",
	"windwp/nvim-ts-autotag",
	"kchmck/vim-coffee-script",
	"nvim-treesitter/nvim-treesitter-context",
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },

	-- Orgmode
	"nvim-orgmode/orgmode",
	"akinsho/org-bullets.nvim",

	-- Git
	"lewis6991/gitsigns.nvim",
	"f-person/git-blame.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Utils
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"mbbill/undotree",
	"numToStr/Comment.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"andymass/vim-matchup", -- improve the % key
	"norcalli/nvim-colorizer.lua",
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	"junegunn/vim-slash",
	"ThePrimeagen/harpoon",

	-- folds
	{
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	},
	{
		"anuvyklack/fold-preview.nvim",
		dependencies = "anuvyklack/keymap-amend.nvim",
		config = function()
			require("fold-preview").setup({
				auto = 400,
			})
		end,
	},
})
