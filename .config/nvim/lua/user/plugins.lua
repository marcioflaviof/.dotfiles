local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})
-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	use("nvim-lualine/lualine.nvim")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim") -- switch between projects, see later
	use("lewis6991/impatient.nvim")

	use("lukas-reineke/indent-blankline.nvim")
	use("andymass/vim-matchup") -- improve the % key
	use("norcalli/nvim-colorizer.lua")

	-- use "windwp/nvim-spectre" -- like ctrl+f in vscode
	use("karb94/neoscroll.nvim") -- smooth scrolling

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use("lunarvim/colorschemes") -- A bunch of colorschemes you can try out

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" })
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
	})

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("ray-x/lsp_signature.nvim") -- Show function signature when you type
	use({
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	})
	use("RRethy/vim-illuminate")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		run = "make",
	})

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "p00f/nvim-ts-rainbow" })
	use("windwp/nvim-ts-autotag")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("f-person/git-blame.nvim")
	use("b0o/SchemaStore.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
