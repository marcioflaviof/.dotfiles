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
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	-- use("vim-airline/vim-airline") -- Status bar
    use({"nvim-lualine/lualine.nvim", requires = {'kyazdani42/nvim-web-devicons', opt = true}})
	use("windwp/nvim-autopairs") -- Autopairs
	use("numToStr/Comment.nvim") -- Easily comment
	use("akinsho/toggleterm.nvim") -- Toggle terminal
    use("akinsho/bufferline.nvim")
    use("moll/vim-bbye")

    -- Git
	use("tpope/vim-fugitive") -- Git in vim
    use("lewis6991/gitsigns.nvim")

	-- Nvim tree
	use("kyazdani42/nvim-tree.lua") -- Navigation tree
	use("kyazdani42/nvim-web-devicons") -- Icons

	-- TreeSitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Colors lint etc..
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Telescope
	use("nvim-telescope/telescope.nvim") -- Searcher
	use("nvim-telescope/telescope-media-files.nvim") -- See images
	use("nvim-telescope/telescope-fzy-native.nvim") -- Better sorter

	-- Colors
	use("folke/tokyonight.nvim") -- Theme
	use("LunarVim/onedarker.nvim") -- Theme
	use({ "dracula/vim", as = "dracula" }) -- Theme
	use("norcalli/nvim-colorizer.lua") -- CSS colors
	use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", cmd = "MarkdownPreview" }) -- Markdown preview

	-- Cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snipped completions
	use("hrsh7th/cmp-nvim-lsp")
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") --simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("jose-elias-alvarez/nvim-lsp-ts-utils") -- organize imports

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
