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

  -- User interface
  use("nvim-tree/nvim-web-devicons")
  use("nvim-tree/nvim-tree.lua")
  use "feline-nvim/feline.nvim"
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye") -- better buffer close
  use("akinsho/toggleterm.nvim") -- toggle terminal
  use("lewis6991/impatient.nvim")

  -- Colorschemes
  use("folke/tokyonight.nvim")

  -- cmp plugins
  use { "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",

      -- snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets"
    }
  }

  -- LSP
  use { "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- better function signature location
      "ray-x/lsp_signature.nvim",
      "lvimuser/lsp-inlayhints.nvim",

      -- status updates
      "j-hui/fidget.nvim",

      -- better typescript experience
      "jose-elias-alvarez/typescript.nvim",

      -- shows variables as I navigate
      "SmiteshP/nvim-navic"
    } }

  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  })
  use("RRethy/vim-illuminate")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    run = "make",
  })

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag"
    }
  }

  -- Orgmode
  use { 'nvim-orgmode/orgmode' }
  use { 'akinsho/org-bullets.nvim' }

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("f-person/git-blame.nvim")
  use("tpope/vim-fugitive")

  -- Utils
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("mbbill/undotree")
  use("numToStr/Comment.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("andymass/vim-matchup") -- improve the % key
  use("norcalli/nvim-colorizer.lua")
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  })
  use("junegunn/vim-slash")
  use("ThePrimeagen/harpoon")

  use {
    'jinh0/eyeliner.nvim',
    config = function()
      require 'eyeliner'.setup {
        highlight_on_key = true
      }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
